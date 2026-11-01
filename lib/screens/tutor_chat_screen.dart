import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../services/speech_service.dart';
import '../services/tutor_chat_service.dart';
import '../services/tts_service.dart';
import '../theme/app_theme.dart';

/// A persistent text-and-voice conversation surface for the Smart Tutor.
/// Replies come from the configured backend; no fake AI response is generated.
class TutorChatScreen extends StatefulWidget {
  const TutorChatScreen({super.key});

  @override
  State<TutorChatScreen> createState() => _TutorChatScreenState();
}

class _TutorChatScreenState extends State<TutorChatScreen> {
  static const _storageKey = 'speaklocal_tutor_chat_v1';
  final _input = TextEditingController();
  final _scroll = ScrollController();
  final _service = TutorChatService();
  final _speech = SpeechService();
  final _tts = TtsService();
  final List<_ChatMessage> _messages = [];
  bool _loading = true;
  bool _sending = false;
  bool _listening = false;
  bool _speechReady = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    _restore();
    _initializeVoice();
  }

  Future<void> _initializeVoice() async {
    await _tts.init();
    final ready = await _speech.init();
    if (mounted) setState(() => _speechReady = ready);
  }

  Future<void> _restore() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getStringList(_storageKey) ?? [];
    for (final line in raw) {
      final split = line.indexOf('|');
      if (split <= 0) continue;
      _messages.add(_ChatMessage(
        isUser: line.substring(0, split) == 'u',
        text: line.substring(split + 1),
      ));
    }
    if (mounted) setState(() => _loading = false);
  }

  Future<void> _persist() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(
      _storageKey,
      _messages.map((m) => '${m.isUser ? 'u' : 'a'}|${m.text}').toList(),
    );
  }

  Future<void> _send() async {
    final text = _input.text.trim();
    if (text.isEmpty || _sending) return;
    _input.clear();
    setState(() {
      _error = null;
      _sending = true;
      _messages.add(_ChatMessage(isUser: true, text: text));
    });
    await _persist();
    _jumpToBottom();

    try {
      final history = _messages
          .take(_messages.length - 1)
          .toList()
          .take(20)
          .map((m) => {
                'role': m.isUser ? 'user' : 'assistant',
                'content': m.text,
              })
          .toList();
      final reply = await _service.send(history: history, message: text);
      if (!mounted) return;
      setState(() => _messages.add(_ChatMessage(isUser: false, text: reply)));
      await _persist();
    } on TutorChatException catch (e) {
      if (mounted) setState(() => _error = e.message);
    } catch (_) {
      if (mounted) setState(() => _error = 'حدث خطأ غير متوقع أثناء إرسال الرسالة.');
    } finally {
      if (mounted) {
        setState(() => _sending = false);
        _jumpToBottom();
      }
    }
  }

  Future<void> _toggleMic() async {
    if (_listening) {
      await _speech.stop();
      if (mounted) setState(() => _listening = false);
      return;
    }
    if (!_speechReady) {
      final ready = await _speech.init();
      if (!mounted) return;
      setState(() => _speechReady = ready);
      if (!ready) {
        setState(() => _error = 'خدمة التعرف على الكلام غير متاحة على الهاتف.');
        return;
      }
    }
    setState(() {
      _error = null;
      _listening = true;
    });
    final started = await _speech.start(
      onResult: (words, confidence) {
        if (mounted) _input.text = words;
      },
      onListeningChanged: (active) {
        if (mounted) setState(() => _listening = active);
      },
      onError: (message) {
        if (mounted) setState(() => _error = 'الميكروفون: $message');
      },
    );
    if (!started && mounted) setState(() => _listening = false);
  }

  void _jumpToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scroll.hasClients) {
        _scroll.animateTo(
          _scroll.position.maxScrollExtent,
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _input.dispose();
    _scroll.dispose();
    _speech.dispose();
    _tts.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Smart Tutor', style: TextStyle(fontWeight: FontWeight.w900)),
            Text('English conversation practice',
                style: TextStyle(fontSize: 11, color: AppColors.muted)),
          ],
        ),
        actions: [
          IconButton(
            tooltip: 'مسح المحادثة',
            onPressed: _sending ? null : _clearChat,
            icon: const Icon(Icons.delete_outline_rounded),
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            color: AppColors.green.withOpacity(.08),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: const Text(
              'اكتب بالإنجليزية أو استخدم الميكروفون. سيصحح لك المعلّم ويشرح الأخطاء.',
              style: TextStyle(fontSize: 12, color: AppColors.greenDark),
            ),
          ),
          Expanded(
            child: _loading
                ? const Center(child: CircularProgressIndicator())
                : _messages.isEmpty
                    ? _welcome()
                    : ListView.builder(
                        controller: _scroll,
                        padding: const EdgeInsets.all(16),
                        itemCount: _messages.length + (_sending ? 1 : 0),
                        itemBuilder: (context, index) {
                          if (index == _messages.length) {
                            return const Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: EdgeInsets.all(12),
                                child: CircularProgressIndicator(),
                              ),
                            );
                          }
                          final message = _messages[index];
                          return _bubble(message);
                        },
                      ),
          ),
          if (_error != null)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              color: AppColors.orange.withOpacity(.10),
              child: Text(_error!, style: const TextStyle(fontSize: 12)),
            ),
          SafeArea(
            top: false,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(12, 8, 12, 12),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  IconButton.filledTonal(
                    onPressed: _sending ? null : _toggleMic,
                    icon: Icon(_listening ? Icons.stop : Icons.mic),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: TextField(
                      controller: _input,
                      minLines: 1,
                      maxLines: 5,
                      textCapitalization: TextCapitalization.sentences,
                      onSubmitted: (_) => _send(),
                      decoration: InputDecoration(
                        hintText: 'اكتب رسالتك بالإنجليزية...',
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(24),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 18,
                          vertical: 12,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  IconButton.filled(
                    onPressed: _sending ? null : _send,
                    icon: const Icon(Icons.send_rounded),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _welcome() => Center(
        child: Padding(
          padding: const EdgeInsets.all(28),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.forum_rounded, size: 54, color: AppColors.green),
              const SizedBox(height: 16),
              const Text('Let’s talk in English!',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900)),
              const SizedBox(height: 8),
              const Text(
                'ابدأ برسالة بسيطة عن يومك أو اختر موضوعًا تحب التحدث عنه.',
                textAlign: TextAlign.center,
                style: TextStyle(color: AppColors.muted),
              ),
              const SizedBox(height: 18),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  _suggestion('Tell me about your day'),
                  _suggestion('I want to practice past tense'),
                  _suggestion('Let’s talk about travel'),
                ],
              ),
            ],
          ),
        ),
      );

  Widget _suggestion(String text) => ActionChip(
        label: Text(text),
        onPressed: () {
          _input.text = text;
          _send();
        },
      );

  Widget _bubble(_ChatMessage message) => Align(
        alignment: message.isUser ? Alignment.centerRight : Alignment.centerLeft,
        child: Container(
          constraints: const BoxConstraints(maxWidth: 320),
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: message.isUser ? AppColors.green : AppColors.line.withOpacity(.55),
            borderRadius: BorderRadius.circular(18),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                message.text,
                style: TextStyle(
                  color: message.isUser ? Colors.white : AppColors.ink,
                  height: 1.4,
                ),
              ),
              if (!message.isUser)
                Align(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                    visualDensity: VisualDensity.compact,
                    tooltip: 'استمع للرد',
                    onPressed: () => _tts.speak(message.text),
                    icon: const Icon(Icons.volume_up_rounded, size: 18),
                  ),
                ),
            ],
          ),
        ),
      );

  Future<void> _clearChat() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_storageKey);
    if (mounted) setState(() {
      _messages.clear();
      _error = null;
    });
  }
}

class _ChatMessage {
  const _ChatMessage({required this.isUser, required this.text});
  final bool isUser;
  final String text;
}
