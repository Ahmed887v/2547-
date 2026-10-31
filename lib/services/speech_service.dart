import 'dart:async';

import 'package:speech_to_text/speech_to_text.dart';

/// Owns one speech-recognition session and keeps the UI in sync with Android.
class SpeechService {
  final SpeechToText _speech = SpeechToText();

  bool available = false;
  bool _starting = false;
  bool _sessionActive = false;
  bool _disposed = false;

  String lastWords = '';
  double confidence = 0;

  void Function(String words, double confidence)? _onResult;
  void Function(bool listening)? _onListeningChanged;
  void Function(String message)? _onError;

  bool get isListening =>
      !_disposed && (_starting || _sessionActive || _speech.isListening);

  Future<bool> init({
    void Function(String message)? onError,
  }) async {
    if (_disposed) return false;
    if (available) return true;

    try {
      available = await _speech.initialize(
        onStatus: _handleStatus,
        onError: (error) {
          _starting = false;
          _sessionActive = false;
          _onListeningChanged?.call(false);
          _onError?.call(error.errorMsg);
        },
      );
      if (!available) onError?.call('Speech recognition is unavailable.');
    } catch (error) {
      available = false;
      onError?.call(error.toString());
    }
    return available;
  }

  Future<bool> start({
    required void Function(String words, double confidence) onResult,
    void Function(bool listening)? onListeningChanged,
    void Function(String message)? onError,
  }) async {
    if (_disposed || isListening) return false;

    _onResult = onResult;
    _onListeningChanged = onListeningChanged;
    _onError = onError;
    lastWords = '';
    confidence = 0;

    if (!available && !await init()) {
      _onError?.call('Speech recognition is unavailable.');
      return false;
    }
    if (_disposed) return false;

    _starting = true;
    _sessionActive = true;
    _onListeningChanged?.call(true);

    try {
      await _speech.listen(
        onResult: (result) {
          if (_disposed || !_sessionActive) return;
          lastWords = result.recognizedWords.trim();
          if (result.confidence > 0) confidence = result.confidence;
          _onResult?.call(lastWords, confidence);
        },
        listenOptions: SpeechListenOptions(
          listenMode: ListenMode.dictation,
          cancelOnError: false,
          partialResults: true,
          localeId: 'en_US',
          listenFor: const Duration(minutes: 2),
          pauseFor: const Duration(seconds: 15),
        ),
      );
      _starting = false;
      // Android may report a status event immediately after listen().
      if (!_speech.isListening && _sessionActive) {
        // Do not leave the UI falsely red if the platform rejected the session.
        _sessionActive = false;
        _onListeningChanged?.call(false);
        _onError?.call(
            'The phone did not start listening. Check microphone permission and the speech recognition service.');
        return false;
      }
      return true;
    } catch (error) {
      _starting = false;
      _sessionActive = false;
      _onListeningChanged?.call(false);
      _onError?.call(error.toString());
      return false;
    }
  }

  void _handleStatus(String status) {
    if (_disposed) return;
    final normalized = status.toLowerCase();
    if (normalized == 'done' || normalized == 'notlistening') {
      _starting = false;
      if (_sessionActive) {
        _sessionActive = false;
        _onListeningChanged?.call(false);
        _onResult?.call(lastWords, confidence);
      }
    }
  }

  Future<void> stop() async {
    _sessionActive = false;
    _starting = false;
    try {
      if (_speech.isListening) await _speech.stop();
    } catch (error) {
      _onError?.call(error.toString());
    }
    _onListeningChanged?.call(false);
    _onResult?.call(lastWords, confidence);
  }

  Future<void> cancel() async {
    _sessionActive = false;
    _starting = false;
    try {
      if (_speech.isListening) await _speech.cancel();
    } catch (_) {}
    lastWords = '';
    confidence = 0;
    _onListeningChanged?.call(false);
  }

  void dispose() {
    _disposed = true;
    _sessionActive = false;
    _starting = false;
    _onListeningChanged = null;
    _onResult = null;
    _onError = null;
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
