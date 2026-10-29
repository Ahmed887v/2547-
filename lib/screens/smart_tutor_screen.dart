import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:speak_english/services/practice_analytics_service.dart';
import '../services/speech_service.dart';
import '../services/tts_service.dart';
import '../services/learning_memory_service.dart';
import '../services/progress_service.dart';
import '../theme/app_theme.dart';

/// Offline adaptive tutor. Questions are selected from a mixed bank and
/// recent correct answers are temporarily deprioritized on this device.
class SmartTutorScreen extends StatefulWidget {
  const SmartTutorScreen({super.key});

  @override
  State<SmartTutorScreen> createState() => _SmartTutorScreenState();
}

class _TutorItem {
  final String prompt;
  final String answer;
  final String meaning;
  final List<String> choices;
  final String tip;
  const _TutorItem(this.prompt, this.answer, this.meaning, this.choices, this.tip);
}

const _words = <_TutorItem>[
  _TutorItem('Benevolent', 'kind and helpful', 'طيب ورحيم ويحب مساعدة الآخرين', ['kind and helpful','angry and loud','careless with money','hard to understand'], 'Think of someone who willingly helps people.'),
  _TutorItem('Abate', 'to become less intense', 'يخف أو يقل في الشدة', ['to become less intense','to make something larger','to hide the truth','to arrive early'], 'A storm can abate when it becomes calmer.'),
  _TutorItem('Candor', 'honesty and openness', 'الصراحة والوضوح', ['honesty and openness','fear of strangers','a long journey','a formal celebration'], 'It is valued when people speak honestly.'),
  _TutorItem('Eloquent', 'fluent and persuasive', 'بليغ وفصيح ومقنع في الكلام', ['fluent and persuasive','very sleepy','unable to move','extremely expensive'], 'An eloquent speaker expresses ideas clearly.'),
  _TutorItem('Furtive', 'secretive and avoiding attention', 'متخفٍ ويحاول ألا يلفت الانتباه', ['secretive and avoiding attention','friendly and outgoing','carefully organized','full of energy'], 'Imagine someone glancing around secretly.'),
  _TutorItem('Jovial', 'cheerful and friendly', 'مرح وبشوش', ['cheerful and friendly','strict and severe','quietly worried','very confused'], 'A jovial person lifts the mood.'),
  _TutorItem('Immutable', 'unable to be changed', 'ثابت وغير قابل للتغيير', ['unable to be changed','easy to forget','likely to break','full of surprises'], 'The prefix im- can suggest “not”.'),
  _TutorItem('Garrulous', 'excessively talkative', 'ثرثار وكثير الكلام', ['excessively talkative','extremely generous','very punctual','easily frightened'], 'Picture a person who never stops talking.'),
];

const _expressions = <_TutorItem>[
  _TutorItem('Break the ice', 'start a friendly conversation', 'يكسر الجمود ويبدأ الحديث بلطف', ['start a friendly conversation','end a friendship','make a cold drink','avoid answering'], 'Often used at the start of a meeting or party.'),
  _TutorItem('Hit the road', 'leave or begin a journey', 'يغادر أو يبدأ الرحلة', ['leave or begin a journey','get into an argument','work all night','miss a deadline'], 'If it is late, you might say it is time to go.'),
  _TutorItem('Cut corners', 'save time or money by reducing quality', 'يوفّر بطريقة قد تقلل الجودة', ['save time or money by reducing quality','decorate a room','take a longer route','finish every detail perfectly'], 'This usually carries a negative meaning.'),
  _TutorItem('Face the music', 'accept unpleasant consequences', 'يواجه عواقب أفعاله', ['accept unpleasant consequences','enjoy a concert','avoid responsibility','learn to play an instrument'], 'Think about owning up to a mistake.'),
  _TutorItem('Pull my leg', 'tease someone playfully', 'يمزح مع شخص أو يخدعه على سبيل المزاح', ['tease someone playfully','help someone walk','ask for directions','make a serious promise'], 'If it is only a joke, the speaker may say this.'),
  _TutorItem('Call it a day', 'stop working for now', 'ينهي العمل لهذا اليوم', ['stop working for now','plan the whole week','start a new job','make a phone call'], 'People say this after a long day of work.'),
  _TutorItem('Spill the beans', 'reveal a secret', 'يفشي سرًا', ['reveal a secret','cook dinner','make a mess with food','change your mind'], 'Imagine accidentally telling everyone a surprise.'),
  _TutorItem('On the ball', 'alert and quick to understand', 'يقظ وسريع الفهم والتصرف', ['alert and quick to understand','physically on a ball','often late','bad at teamwork'], 'A capable colleague who notices things quickly is this.'),
];

class _SmartTutorScreenState extends State<SmartTutorScreen> {
  static const _historyKey = 'speaklocal_tutor_seen_v1';
  final _random = Random();
  final _tts = TtsService();
  final _speech = SpeechService();
  bool _speechReady = false;
  bool _listening = false;
  bool _speaking = false;
  String _heard = '';
  int? _pronunciationScore;
  Set<String> _seen = {};
  Set<String> _weakPrompts = {};
  _TutorItem? _current;
  bool _showMeaning = false;
  String? _selected;
  int _correct = 0;
  int _answered = 0;
  int _streak = 0;
  bool _loaded = false;

  @override
  void initState() {
    super.initState();
    _load();
    _initSpeechTools();
  }

  Future<void> _initSpeechTools() async {
    await _tts.init();
    _speechReady = await _speech.init();
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    _tts.dispose();
    _speech.cancel();
    super.dispose();
  }

  Future<void> _playWord() async {
    if (_listening) {
      await _speech.stop();
      if (mounted) setState(() => _listening = false);
    }
    setState(() => _speaking = true);
    try {
      await _tts.speak(_current!.prompt);
    } finally {
      if (mounted) setState(() => _speaking = false);
    }
  }

  Future<void> _togglePronunciation() async {
    if (_listening) {
      await _speech.stop();
      if (!mounted) return;
      final score = PronunciationScorer.score(_current!.prompt, _heard);
      setState(() {
        _listening = false;
        _pronunciationScore = score;
      });
      final item = _current;
      if (item != null) {
        if (score < 70) _weakPrompts.add(item.prompt.toLowerCase());
        else _weakPrompts.remove(item.prompt.toLowerCase());
        await PracticeAnalyticsService().recordAttempt(
          lessonId: 'smart_tutor',
          prompt: item.prompt,
          target: item.prompt,
          score: score,
          exerciseType: 'smart_tutor_speech',
        );
        if (score < 75 && _heard.trim().isNotEmpty && mounted) {
          await context.read<LearningMemoryService>().recordCorrection(
            original: _heard.trim(),
            corrected: item.prompt,
            explanation: 'Smart Tutor speech transcript did not closely match the target. This is transcript matching, not acoustic pronunciation analysis.',
            example: '${item.meaning} — ${item.prompt}',
          );
        }
        if (score < 45 && mounted) {
          await context.read<ProgressService>().loseHeart();
        }
      }
      return;
    }
    if (!_speechReady) _speechReady = await _speech.init();
    if (!_speechReady) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Speech recognition is unavailable. Enable English speech recognition on your phone.')),
      );
      return;
    }
    setState(() {
      _heard = '';
      _pronunciationScore = null;
      _listening = true;
    });
    await _speech.start(onResult: (words, confidence) {
      if (mounted) setState(() => _heard = words);
    });
  }

  Future<void> _load() async {
    final prefs = await SharedPreferences.getInstance();
    _seen = (prefs.getStringList(_historyKey) ?? []).toSet();
    // Pull weak prompts from the same persisted history used by lesson review.
    final analytics = PracticeAnalyticsService();
    await analytics.load();
    _weakPrompts = analytics.summary.weakPrompts.map((e) => e.toLowerCase()).toSet();
    if (!mounted) return;
    setState(() { _loaded = true; _next(); });
  }

  String _key(_TutorItem item) => item.prompt.toLowerCase();

  void _next() {
    final bank = [..._words, ..._expressions];
    final weak = bank.where((e) => _weakPrompts.contains(e.prompt.toLowerCase())).toList();
    final unseen = bank.where((e) => !_seen.contains(_key(e))).toList();
    // Revisit known weak items first; otherwise introduce unseen material.
    final pool = weak.isNotEmpty ? weak : (unseen.isNotEmpty ? unseen : bank);
    _current = pool[_random.nextInt(pool.length)];
    _selected = null;
    _showMeaning = false;
    _heard = '';
    _pronunciationScore = null;
    _listening = false;
  }

  Future<void> _answer(String choice) async {
    if (_selected != null || _current == null) return;
    final right = choice == _current!.answer;
    final item = _current!;
    if (right) {
      _weakPrompts.remove(item.prompt.toLowerCase());
    } else {
      _weakPrompts.add(item.prompt.toLowerCase());
    }
    setState(() {
      _selected = choice;
      _showMeaning = true;
      _answered++;
      if (right) { _correct++; _streak++; } else { _streak = 0; }
      _seen.add(_key(item));
    });
    // Record every MCQ result in the same persistent analytics history used by lesson practice.
    await PracticeAnalyticsService().recordAttempt(
      lessonId: 'smart_tutor',
      prompt: item.prompt,
      target: item.answer,
      score: right ? 100 : 0,
      exerciseType: 'smart_tutor_multiple_choice',
    );
    if (!right && mounted) {
      await context.read<LearningMemoryService>().recordCorrection(
        original: choice,
        corrected: item.answer,
        explanation: 'Smart Tutor multiple-choice answer was incorrect.',
        example: '${item.meaning} — ${item.prompt}',
      );
      if (mounted) await context.read<ProgressService>().loseHeart();
    }
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(_historyKey, _seen.toList());
  }

  @override
  Widget build(BuildContext context) {
    final item = _current;
    return Scaffold(
      backgroundColor: const Color(0xFFF7FAF5),
      appBar: AppBar(
        title: const Text('Smart Tutor', style: TextStyle(fontWeight: FontWeight.w900)),
        backgroundColor: const Color(0xFFF7FAF5),
        foregroundColor: AppColors.greenDark,
        elevation: 0,
      ),
      body: !_loaded || item == null
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              padding: const EdgeInsets.fromLTRB(18, 8, 18, 28),
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(colors: [Color(0xFF173D35), Color(0xFF28785D)]),
                    borderRadius: BorderRadius.circular(26),
                  ),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    const Text('YOUR PERSONAL ENGLISH COACH', style: TextStyle(color: Color(0xFFB7F3D3), fontSize: 11, fontWeight: FontWeight.w900, letterSpacing: 1)),
                    const SizedBox(height: 12),
                    const Text('Small steps. Real progress.', style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w900)),
                    const SizedBox(height: 8),
                    const Text('Choose the meaning. Learn from every answer.', style: TextStyle(color: Colors.white70)),
                    const SizedBox(height: 18),
                    Row(children: [
                      _metric('Answered', '$_answered'),
                      const SizedBox(width: 10),
                      _metric('Correct', '$_correct'),
                      const SizedBox(width: 10),
                      _metric('Streak', '$_streak'),
                    ]),
                  ]),
                ),
                const SizedBox(height: 22),
                Row(children: [
                  const Icon(Icons.auto_awesome_rounded, color: AppColors.purple),
                  const SizedBox(width: 8),
                  const Expanded(child: Text('Quick adaptive lesson', style: TextStyle(fontSize: 19, fontWeight: FontWeight.w900))),
                  Container(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6), decoration: BoxDecoration(color: const Color(0xFFE8FFF0), borderRadius: BorderRadius.circular(20)), child: Text(_expressions.contains(item) ? 'SLANG' : 'VOCAB', style: const TextStyle(color: AppColors.greenDark, fontSize: 11, fontWeight: FontWeight.w900))),
                ]),
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(24), border: Border.all(color: AppColors.line, width: 1.5)),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text(item.prompt, style: const TextStyle(fontSize: 27, fontWeight: FontWeight.w900)),
                    const SizedBox(height: 8),
                    const Text('What does it mean?', style: TextStyle(color: AppColors.muted, fontSize: 15)),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: _speaking ? null : _playWord,
                            icon: Icon(_speaking ? Icons.volume_up : Icons.headphones_rounded),
                            label: Text(_speaking ? 'Playing…' : 'Listen'),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: FilledButton.icon(
                            style: FilledButton.styleFrom(
                              backgroundColor: _listening ? AppColors.red : AppColors.green,
                              foregroundColor: Colors.white,
                            ),
                            onPressed: _togglePronunciation,
                            icon: Icon(_listening ? Icons.stop_circle_outlined : Icons.mic_rounded),
                            label: Text(_listening ? 'Stop & score' : 'Say it'),
                          ),
                        ),
                      ],
                    ),
                    if (_heard.isNotEmpty || _pronunciationScore != null) ...[
                      const SizedBox(height: 12),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF4F7F3),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (_heard.isNotEmpty)
                              Text('You said: “$_heard”',
                                  style: const TextStyle(fontWeight: FontWeight.w700)),
                            if (_pronunciationScore != null) ...[
                              const SizedBox(height: 8),
                              Row(children: [
                                const Text('Speech match',
                                    style: TextStyle(fontWeight: FontWeight.w800)),
                                const Spacer(),
                                Text('$_pronunciationScore / 100',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w900,
                                      color: _pronunciationScore! >= 75
                                          ? AppColors.greenDark
                                          : AppColors.orange,
                                    )),
                              ]),
                              const SizedBox(height: 5),
                              Text('${PronunciationScorer.feedback(_pronunciationScore!)} This checks recognized words, not acoustic sound quality.',
                                  style: const TextStyle(color: AppColors.muted)),
                            ],
                          ],
                        ),
                      ),
                    ],
                    const SizedBox(height: 18),
                    ...item.choices.map((choice) {
                      final chosen = _selected == choice;
                      final right = choice == item.answer;
                      final Color bg = _selected == null ? Colors.white : right ? const Color(0xFFE4F8E8) : chosen ? const Color(0xFFFFE9E7) : Colors.white;
                      final Color border = _selected == null ? AppColors.line : right ? AppColors.green : chosen ? AppColors.red : AppColors.line;
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 9),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(15),
                          onTap: _selected == null ? () => _answer(choice) : null,
                          child: Container(
                            padding: const EdgeInsets.all(14),
                            decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(15), border: Border.all(color: border, width: 1.5)),
                            child: Row(children: [
                              Expanded(child: Text(choice, style: const TextStyle(fontWeight: FontWeight.w700))),
                              if (_selected != null && right) const Icon(Icons.check_circle, color: AppColors.green),
                              if (chosen && !right) const Icon(Icons.cancel, color: AppColors.red),
                            ]),
                          ),
                        ),
                      );
                    }),
                    if (_showMeaning) ...[
                      const Divider(height: 24),
                      Text(item.meaning, style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w800, color: AppColors.greenDark)),
                      const SizedBox(height: 8),
                      Text(item.tip, style: const TextStyle(color: AppColors.muted)),
                      const SizedBox(height: 8),
                      Text('Example: ${_example(item)}', style: const TextStyle(fontStyle: FontStyle.italic)),
                    ],
                  ]),
                ),
                const SizedBox(height: 14),
                if (_selected != null)
                  FilledButton.icon(
                    style: FilledButton.styleFrom(backgroundColor: AppColors.green, foregroundColor: Colors.white, padding: const EdgeInsets.symmetric(vertical: 16)),
                    onPressed: () => setState(_next),
                    icon: const Icon(Icons.arrow_forward_rounded),
                    label: const Text('Next question', style: TextStyle(fontWeight: FontWeight.w900)),
                  ),
                const SizedBox(height: 10),
                OutlinedButton.icon(
                  onPressed: () => setState(() { _next(); }),
                  icon: const Icon(Icons.shuffle_rounded),
                  label: const Text('Try another question'),
                ),
                const SizedBox(height: 12),
                const Text('Hear each word or expression, say it into the microphone, and get a transcript-match score. Works offline; questions avoid recently seen items until the bank has been used.', textAlign: TextAlign.center, style: TextStyle(color: AppColors.muted, fontSize: 12)),
              ],
            ),
    );
  }

  String _example(_TutorItem item) {
    switch (item.prompt) {
      case 'Break the ice': return 'A quick joke helped break the ice at the meeting.';
      case 'Hit the road': return 'It is getting late, so let us hit the road.';
      case 'Cut corners': return 'Do not cut corners when safety matters.';
      case 'Face the music': return 'He had to face the music after the mistake.';
      case 'Pull my leg': return 'Are you serious, or are you pulling my leg?';
      case 'Call it a day': return 'We finished the main task, so let us call it a day.';
      case 'Spill the beans': return 'Please do not spill the beans about the surprise.';
      case 'On the ball': return 'Maya is always on the ball at work.';
      default: return '${item.prompt} means ${item.answer}.';
    }
  }

  Widget _metric(String label, String value) => Expanded(
    child: Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(color: Colors.white.withOpacity(.12), borderRadius: BorderRadius.circular(14)),
      child: Column(children: [
        Text(value, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 19)),
        Text(label, style: const TextStyle(color: Colors.white70, fontSize: 11)),
      ]),
    ),
  );
}
