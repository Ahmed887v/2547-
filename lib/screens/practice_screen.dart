import 'package:confetti/confetti.dart';
import 'package:speak_english/services/practice_analytics_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/lessons.dart';
import '../models/lesson.dart';
import '../services/progress_service.dart';
import '../services/learning_memory_service.dart';
import '../services/speech_service.dart';
import '../services/tts_service.dart';
import '../theme/app_theme.dart';
import '../widgets/stat_chip.dart';

class PracticeScreen extends StatefulWidget {
  final String lessonId;

  const PracticeScreen({super.key, required this.lessonId});

  @override
  State<PracticeScreen> createState() => _PracticeScreenState();
}

class _PracticeScreenState extends State<PracticeScreen> {
  final _tts = TtsService();
  final _speech = SpeechService();
  final _confetti = ConfettiController(duration: const Duration(seconds: 2));

  late Lesson lesson;
  int index = 0;
  String heard = '';
  int? lastScore;
  String? lastFeedback;
  String? selectedChoice;
  bool listening = false;
  bool busy = false;
  bool finished = false;
  final List<int> scores = [];
  final Set<String> _savedPhraseKeys = {};
  final Set<String> _savedCorrectionKeys = {};
  bool speechReady = false;
  bool _isDisposing = false;

  Exercise get current => lesson.exercises[index];

  @override
  void initState() {
    super.initState();
    lesson = findLesson(widget.lessonId)!;
    _bootstrap();
  }

  Future<void> _bootstrap() async {
    await _tts.init();
    speechReady = await _speech.init();
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    _isDisposing = true;
    _tts.dispose();
    _speech.cancel();
    _confetti.dispose();
    super.dispose();
  }

  Future<void> _listenModel() async {
    setState(() => busy = true);
    await _tts.speak(current.phrase.text);
    if (mounted) setState(() => busy = false);
  }

  Future<void> _toggleMic() async {
    if (listening) {
      await _speech.stop();
      if (!mounted) return;
      setState(() => listening = false);
      await _evaluate();
      return;
    }

    if (!speechReady) {
      speechReady = await _speech.init();
      if (!mounted) return;
      if (!speechReady) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Speech recognition unavailable. Enable Google voice typing / English speech pack.',
            ),
          ),
        );
        return;
      }
    }

    if (current.type == ExerciseType.chooseAndSay && selectedChoice == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Pick the correct phrase first.')),
      );
      return;
    }

    setState(() {
      listening = true;
      heard = '';
      lastScore = null;
      lastFeedback = null;
    });

    await _speech.start(
      onResult: (words, conf) {
        if (_isDisposing || !mounted) return;
        setState(() => heard = words);
      },
    );
  }

  // Evaluate the answer and save useful learning items for later review.
  Future<void> _evaluate() async {
    final phrase = current.phrase;
    final target = current.type == ExerciseType.chooseAndSay
        ? (selectedChoice ?? phrase.text)
        : phrase.text;

    final memory = context.read<LearningMemoryService>();

    // Save each lesson phrase once per screen session.
    final phraseKey = '${lesson.id}:$index';
    if (_savedPhraseKeys.add(phraseKey)) {
      await memory.recordVocabulary(
        word: phrase.text,
        translation: phrase.meaningAr,
        example: phrase.tip.isEmpty
            ? phrase.text
            : '${phrase.text}\nTip: ${phrase.tip}',
      );
    }

    // Save only corrections confirmed by the lesson's answer key.
    if (current.type == ExerciseType.chooseAndSay &&
        selectedChoice != phrase.text) {
      if (!mounted) return;

      setState(() {
        lastScore = 20;
        lastFeedback = 'Wrong choice — pick the natural phrase.';
      });
      scores.add(20);

      await memory.recordCorrection(
        original: selectedChoice ?? '',
        corrected: phrase.text,
        explanation: 'This lesson marked the selected phrase as incorrect. '
            'Choose the phrase that matches the lesson.',
        example: '${phrase.meaningAr} — ${phrase.text}',
      );

      if (mounted) {
        await context.read<ProgressService>().loseHeart();
      }
      return;
    }

    final score = PronunciationScorer.score(target, heard);
    if (!mounted) return;

    setState(() {
      lastScore = score;
      lastFeedback = PronunciationScorer.feedback(score);
    });
    scores.add(score);

// Persist this evaluated exercise attempt for progress analytics.
// This score reflects the app's existing evaluation, not acoustic analysis.
    await PracticeAnalyticsService().recordAttempt(
      lessonId: lesson.id,
      prompt: target,
      target: target,
      score: score,
      exerciseType: 'practice',
    );

    // Save low-scoring speech transcripts for targeted future review.
    // This compares recognized words; it is not acoustic pronunciation analysis.
    if (score < 75 && heard.trim().isNotEmpty) {
      final correctionKey = '${lesson.id}:$index:${heard.trim().toLowerCase()}';

      if (_savedCorrectionKeys.add(correctionKey)) {
        await memory.recordCorrection(
          original: heard.trim(),
          corrected: target,
          explanation:
              'The recognized words did not closely match the target phrase.',
          example: '${phrase.meaningAr} — $target',
        );
      }
    }

    // The screen may have been disposed while an awaited save was running.
    if (!mounted) return;

    if (score < 45) {
      await context.read<ProgressService>().loseHeart();
    }
  }

  Future<void> _next() async {
    if (lastScore == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Speak the phrase before continuing.')),
      );
      return;
    }

    if (index < lesson.exercises.length - 1) {
      setState(() {
        index += 1;
        heard = '';
        lastScore = null;
        lastFeedback = null;
        selectedChoice = null;
        listening = false;
      });
      return;
    }

    final avg = scores.isEmpty
        ? 0
        : (scores.reduce((a, b) => a + b) / scores.length).round();
    final xp =
        ((lesson.xpReward * (avg / 100)).round()).clamp(5, lesson.xpReward);
    await context.read<ProgressService>().addPracticeResult(
          lessonId: lesson.id,
          averageScore: avg,
          earnedXp: xp,
        );
    _confetti.play();
    setState(() => finished = true);
  }

  @override
  Widget build(BuildContext context) {
    final color = Color(lesson.color.argb);
    final step = (index + 1) / lesson.exercises.length;

    if (finished) {
      return _ResultView(
        lesson: lesson,
        scores: scores,
        confetti: _confetti,
        onDone: () => Navigator.of(context).pop(),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(lesson.title),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: Center(
              child: StatChip(
                icon: Icons.favorite_rounded,
                value: '${context.watch<ProgressService>().hearts}',
                color: AppColors.red,
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: LinearProgressIndicator(
                  value: step,
                  minHeight: 12,
                  backgroundColor: AppColors.line,
                  color: color,
                ),
              ),
              const SizedBox(height: 8),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Phrase ${index + 1} of ${lesson.exercises.length}',
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    color: AppColors.muted,
                  ),
                ),
              ),
              const SizedBox(height: 18),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(22),
                        decoration: BoxDecoration(
                          color: color.withOpacity(0.08),
                          borderRadius: BorderRadius.circular(28),
                          border: Border.all(
                              color: color.withOpacity(0.3), width: 2),
                        ),
                        child: Column(
                          children: [
                            Text(
                              _typeLabel(current.type),
                              style: TextStyle(
                                color: color,
                                fontWeight: FontWeight.w900,
                                letterSpacing: 0.6,
                              ),
                            ),
                            const SizedBox(height: 14),
                            Text(
                              current.phrase.text,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.w900,
                                height: 1.25,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              current.phrase.meaningAr,
                              textAlign: TextAlign.center,
                              textDirection: TextDirection.rtl,
                              style: const TextStyle(
                                fontSize: 16,
                                color: AppColors.muted,
                              ),
                            ),
                            if (current.phrase.tip.isNotEmpty) ...[
                              const SizedBox(height: 12),
                              Text(
                                'Tip: ${current.phrase.tip}',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: color,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                      if (current.type == ExerciseType.chooseAndSay) ...[
                        const SizedBox(height: 16),
                        ...?current.choices?.map((c) {
                          final selected = selectedChoice == c;
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: InkWell(
                              onTap: () => setState(() => selectedChoice = c),
                              borderRadius: BorderRadius.circular(16),
                              child: Ink(
                                width: double.infinity,
                                padding: const EdgeInsets.all(14),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  border: Border.all(
                                    color: selected ? color : AppColors.line,
                                    width: 2.5,
                                  ),
                                  color: selected
                                      ? color.withOpacity(0.12)
                                      : Colors.white,
                                ),
                                child: Text(
                                  c,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w800,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                      ],
                      const SizedBox(height: 18),
                      if (heard.isNotEmpty)
                        Text(
                          'You said: “$heard”',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                          ),
                        ),
                      if (lastScore != null) ...[
                        const SizedBox(height: 12),
                        _ScoreBadge(score: lastScore!),
                        const SizedBox(height: 8),
                        Text(
                          lastFeedback ?? '',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            color: AppColors.ink,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
              SoftButton(
                label: busy ? 'Playing…' : 'Listen',
                icon: Icons.volume_up_rounded,
                color: AppColors.blue,
                dark: AppColors.blueDark,
                onPressed: busy ? null : _listenModel,
              ),
              const SizedBox(height: 10),
              SoftButton(
                label: listening ? 'Stop & score' : 'Hold speak / tap mic',
                icon: listening ? Icons.stop_rounded : Icons.mic_rounded,
                color: listening ? AppColors.red : color,
                dark: listening
                    ? const Color(0xFFD13333)
                    : Color.lerp(color, Colors.black, 0.2)!,
                onPressed: busy ? null : _toggleMic,
              ),
              const SizedBox(height: 10),
              SoftButton(
                label: index == lesson.exercises.length - 1
                    ? 'Finish lesson'
                    : 'Next phrase',
                icon: Icons.arrow_forward_rounded,
                outlined: true,
                onPressed: lastScore == null ? null : _next,
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _typeLabel(ExerciseType type) {
    switch (type) {
      case ExerciseType.listenRepeat:
        return 'LISTEN & REPEAT';
      case ExerciseType.speakPrompt:
        return 'SPEAK THIS';
      case ExerciseType.chooseAndSay:
        return 'CHOOSE & SAY';
    }
  }
}

class _ScoreBadge extends StatelessWidget {
  final int score;
  const _ScoreBadge({required this.score});

  Color get color {
    if (score >= 80) return AppColors.green;
    if (score >= 55) return AppColors.orange;
    return AppColors.red;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
      decoration: BoxDecoration(
        color: color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: color, width: 2),
      ),
      child: Text(
        'Pronunciation $score%',
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.w900,
          fontSize: 18,
        ),
      ),
    );
  }
}

class _ResultView extends StatelessWidget {
  final Lesson lesson;
  final List<int> scores;
  final ConfettiController confetti;
  final VoidCallback onDone;

  const _ResultView({
    required this.lesson,
    required this.scores,
    required this.confetti,
    required this.onDone,
  });

  @override
  Widget build(BuildContext context) {
    final avg = scores.isEmpty
        ? 0
        : (scores.reduce((a, b) => a + b) / scores.length).round();
    final xp =
        ((lesson.xpReward * (avg / 100)).round()).clamp(5, lesson.xpReward);

    return Scaffold(
      body: Stack(
        children: [
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  const Spacer(),
                  const Text('🎉', style: TextStyle(fontSize: 64)),
                  const SizedBox(height: 12),
                  const Text(
                    'Lesson complete!',
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.w900),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    lesson.title,
                    style:
                        const TextStyle(color: AppColors.muted, fontSize: 16),
                  ),
                  const SizedBox(height: 28),
                  Row(
                    children: [
                      Expanded(
                        child: _StatBox(
                          label: 'AVG SCORE',
                          value: '$avg%',
                          color: AppColors.green,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _StatBox(
                          label: 'XP EARNED',
                          value: '+$xp',
                          color: AppColors.orange,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  SoftButton(
                    label: 'Continue',
                    icon: Icons.check_rounded,
                    onPressed: onDone,
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: ConfettiWidget(
              confettiController: confetti,
              blastDirectionality: BlastDirectionality.explosive,
              shouldLoop: false,
              colors: const [
                AppColors.green,
                AppColors.blue,
                AppColors.orange,
                AppColors.purple,
                AppColors.yellow,
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _StatBox extends StatelessWidget {
  final String label;
  final String value;
  final Color color;

  const _StatBox({
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.line, width: 2),
      ),
      child: Column(
        children: [
          Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.w800,
              color: AppColors.muted,
              fontSize: 12,
              letterSpacing: 0.6,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            value,
            style: TextStyle(
              fontWeight: FontWeight.w900,
              fontSize: 28,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
