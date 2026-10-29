import 'dart:async';

import 'package:speech_to_text/speech_to_text.dart';

/// Handles speech recognition while preserving the transcript across sessions.
/// Bluetooth input depends on Android's active route and recognizer support.
class SpeechService {
  final SpeechToText _speech = SpeechToText();

  bool available = false;
  String lastWords = '';
  double confidence = 0;

  bool _keepListening = false;
  bool _starting = false;
  bool _disposed = false;
  bool _restartPending = false;

  Timer? _restartTimer;
  String _partialWords = '';
  final List<String> _completedSegments = [];
  void Function(String words, double confidence)? _onResult;

  Future<bool> init() async {
    if (available) return true;

    available = await _speech.initialize(
      onError: (_) {
        // Status events may follow an error. Restart only while recording
        // remains enabled by the user.
      },
      onStatus: _onStatus,
    );

    return available;
  }

  bool get isListening => _keepListening || _starting || _speech.isListening;

  Future<void> start({
    required void Function(String words, double confidence) onResult,
  }) async {
    if (!available) {
      await init();
    }
    if (!available) return;

    lastWords = '';
    confidence = 0;

    await _speech.listen(
      onResult: (result) {
        lastWords = result.recognizedWords;
        confidence = result.confidence > 0 ? result.confidence : confidence;
        onResult(lastWords, confidence);
      },
      listenOptions: SpeechListenOptions(
        listenMode: ListenMode.dictation,
        cancelOnError: false,
        partialResults: true,
        localeId: 'en_US',
        listenFor: const Duration(minutes: 5),
        pauseFor: const Duration(seconds: 25),
      ),
    );
  }

  Future<void> _startSession() async {
    if (_disposed || !_keepListening || _starting) return;
    if (_speech.isListening) return;

    _starting = true;

    try {
      await _speech.listen(
        onResult: (result) {
          if (_disposed || !_keepListening) return;

          final words = result.recognizedWords.trim();

          if (result.finalResult) {
            // Avoid appending the same final segment more than once.
            if (words.isNotEmpty &&
                (_completedSegments.isEmpty ||
                    _completedSegments.last != words)) {
              _completedSegments.add(words);
            }
            _partialWords = '';
          } else {
            _partialWords = words;
          }

          lastWords = [
            ..._completedSegments,
            if (_partialWords.isNotEmpty) _partialWords,
          ].join(' ').replaceAll(RegExp(r'\s+'), ' ').trim();

          if (result.confidence > 0) {
            confidence = result.confidence;
          }

          _onResult?.call(lastWords, confidence);
        },
        listenOptions: SpeechListenOptions(
          listenMode: ListenMode.dictation,
          cancelOnError: false,
          partialResults: true,
          localeId: 'en_US',
          listenFor: const Duration(minutes: 5),
          pauseFor: const Duration(seconds: 25),
        ),
      );
    } catch (_) {
      _scheduleRestart();
    } finally {
      _starting = false;
    }
  }

  void _onStatus(String status) {
    if (_disposed || !_keepListening) return;

    final normalized = status.toLowerCase();
    if (normalized == 'done' || normalized == 'notlistening') {
      _scheduleRestart();
    }
  }

  void _scheduleRestart() {
    if (_disposed || !_keepListening || _restartPending) return;

    _restartPending = true;
    _restartTimer?.cancel();

    _restartTimer = Timer(const Duration(milliseconds: 700), () async {
      _restartPending = false;

      if (_disposed || !_keepListening) return;

      await _startSession();
    });
  }

  Future<void> stop() async {
    // Turn off restart first, because Android may emit "done" after stop().
    _keepListening = false;
    _restartTimer?.cancel();
    _restartPending = false;

    if (_speech.isListening) {
      await _speech.stop();
    }

    lastWords = [
      ..._completedSegments,
      if (_partialWords.isNotEmpty) _partialWords,
    ].join(' ').replaceAll(RegExp(r'\s+'), ' ').trim();

    _onResult?.call(lastWords, confidence);
  }

  Future<void> cancel() async {
    _keepListening = false;
    _restartTimer?.cancel();
    _restartPending = false;

    _completedSegments.clear();
    _partialWords = '';
    lastWords = '';
    _onResult = null;

    if (_speech.isListening) {
      await _speech.cancel();
    }
  }

  void dispose() {
    _disposed = true;
    _keepListening = false;
    _restartTimer?.cancel();
    _speech.cancel();
  }
}

/// Estimates transcript similarity; it does not measure pronunciation acoustics.
class PronunciationScorer {
  static int score(String target, String spoken) {
    final a = _normalize(target);
    final b = _normalize(spoken);

    if (a.isEmpty || b.isEmpty) return 0;
    if (a == b) return 100;

    final aw = a.split(' ').where((w) => w.isNotEmpty).toList();
    final bw = b.split(' ').where((w) => w.isNotEmpty).toList();

    if (aw.isEmpty || bw.isEmpty) return 0;

    final wordDistance = _wordLevenshtein(aw, bw);
    final maxWords = aw.length > bw.length ? aw.length : bw.length;
    final wordSimilarity = 1 - wordDistance / maxWords;
    final characterSimilarity = _similarity(a, b);

    return ((wordSimilarity * 0.75 + characterSimilarity * 0.25) * 100)
        .round()
        .clamp(0, 100);
  }

  static String feedback(int score) {
    if (score >= 90) {
      return 'Excellent! The recognized words closely match the target.';
    }
    if (score >= 75) {
      return 'Great job! The recognized words mostly match.';
    }
    if (score >= 55) {
      return 'Good try — listen again and speak a little more slowly.';
    }
    if (score >= 35) {
      return 'Keep going — listen to the model, then try again.';
    }
    return 'Try once more. Tap Listen first, then speak clearly.';
  }

  static String _normalize(String value) {
    return value
        .toLowerCase()
        .replaceAll('’', "'")
        .replaceAll(RegExp(r'\bcan not\b'), 'cannot')
        .replaceAll(RegExp(r'\bgonna\b'), 'going to')
        .replaceAll(RegExp(r'\bwanna\b'), 'want to')
        .replaceAll(RegExp(r"[^a-z0-9\s']"), ' ')
        .replaceAll(RegExp(r'\s+'), ' ')
        .trim();
  }

  static double _similarity(String a, String b) {
    if (a == b) return 1;
    if (a.isEmpty || b.isEmpty) return 0;

    final distance = _levenshtein(a, b);
    final maxLength = a.length > b.length ? a.length : b.length;

    return 1 - distance / maxLength;
  }

  static int _wordLevenshtein(List<String> a, List<String> b) {
    final dp = List.generate(
      a.length + 1,
      (_) => List<int>.filled(b.length + 1, 0),
    );

    for (var i = 0; i <= a.length; i++) {
      dp[i][0] = i;
    }
    for (var j = 0; j <= b.length; j++) {
      dp[0][j] = j;
    }

    for (var i = 1; i <= a.length; i++) {
      for (var j = 1; j <= b.length; j++) {
        final cost = a[i - 1] == b[j - 1] ? 0 : 1;

        dp[i][j] = [
          dp[i - 1][j] + 1,
          dp[i][j - 1] + 1,
          dp[i - 1][j - 1] + cost,
        ].reduce((x, y) => x < y ? x : y);
      }
    }

    return dp[a.length][b.length];
  }

  static int _levenshtein(String a, String b) {
    final dp = List.generate(
      a.length + 1,
      (_) => List<int>.filled(b.length + 1, 0),
    );

    for (var i = 0; i <= a.length; i++) {
      dp[i][0] = i;
    }
    for (var j = 0; j <= b.length; j++) {
      dp[0][j] = j;
    }

    for (var i = 1; i <= a.length; i++) {
      for (var j = 1; j <= b.length; j++) {
        final cost = a[i - 1] == b[j - 1] ? 0 : 1;

        dp[i][j] = [
          dp[i - 1][j] + 1,
          dp[i][j - 1] + 1,
          dp[i - 1][j - 1] + cost,
        ].reduce((x, y) => x < y ? x : y);
      }
    }

    return dp[a.length][b.length];
  }
}
