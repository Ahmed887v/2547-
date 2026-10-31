import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// On-device learner model. This is separate from lesson XP and legacy memory.
class TutorLearnerProfile extends ChangeNotifier {
  static const _storageKey = 'speaklocal_tutor_profile_v1';
  final Map<String, TutorItemProgress> _progress = {};
  bool _loaded = false;

  bool get isLoaded => _loaded;
  int get practicedCount => _progress.length;
  int get totalAttempts => _progress.values.fold(0, (sum, p) => sum + p.attempts);
  double get overallAccuracy {
    final attempts = totalAttempts;
    if (attempts == 0) return 0;
    final correct = _progress.values.fold(0, (sum, p) => sum + p.correct);
    return correct / attempts;
  }

  TutorItemProgress progressFor(String id) =>
      _progress[id] ?? const TutorItemProgress();

  List<String> get weakItemIds => _progress.entries
      .where((e) => e.value.attempts > 0 && e.value.accuracy < .65)
      .map((e) => e.key).toList(growable: false);

  Future<void> load() async {
    if (_loaded) return;
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_storageKey);
    if (raw != null) {
      try {
        final decoded = jsonDecode(raw);
        if (decoded is Map) {
          for (final entry in decoded.entries) {
            if (entry.value is Map) {
              _progress[entry.key.toString()] =
                  TutorItemProgress.fromJson(Map<String, dynamic>.from(entry.value as Map));
            }
          }
        }
      } on FormatException {
        // Preserve corrupted data; start an in-memory profile without overwriting it.
      }
    }
    _loaded = true;
    notifyListeners();
  }

  Future<void> recordResult({
    required String itemId,
    required bool correct,
    required int score,
  }) async {
    final old = progressFor(itemId);
    final now = DateTime.now();
    final nextStreak = correct ? old.correctStreak + 1 : 0;
    final interval = !correct ? 0 : nextStreak == 1 ? 1 : nextStreak == 2 ? 3 : nextStreak == 3 ? 7 : 14;
    _progress[itemId] = old.copyWith(
      attempts: old.attempts + 1,
      correct: old.correct + (correct ? 1 : 0),
      lastScore: score.clamp(0, 100),
      correctStreak: nextStreak,
      lastPracticedAt: now,
      nextReviewAt: now.add(Duration(days: interval)),
    );
    await _persist();
    notifyListeners();
  }

  List<String> dueItemIds([DateTime? at]) {
    final now = at ?? DateTime.now();
    return _progress.entries
        .where((e) => e.value.nextReviewAt == null || !e.value.nextReviewAt!.isAfter(now))
        .map((e) => e.key).toList(growable: false);
  }

  Future<void> _persist() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_storageKey, jsonEncode(
      _progress.map((key, value) => MapEntry(key, value.toJson())),
    ));
  }
}

class TutorItemProgress {
  final int attempts;
  final int correct;
  final int lastScore;
  final int correctStreak;
  final DateTime? lastPracticedAt;
  final DateTime? nextReviewAt;

  const TutorItemProgress({
    this.attempts = 0,
    this.correct = 0,
    this.lastScore = 0,
    this.correctStreak = 0,
    this.lastPracticedAt,
    this.nextReviewAt,
  });

  double get accuracy => attempts == 0 ? 0 : correct / attempts;

  TutorItemProgress copyWith({
    int? attempts, int? correct, int? lastScore, int? correctStreak,
    DateTime? lastPracticedAt, DateTime? nextReviewAt,
  }) => TutorItemProgress(
    attempts: attempts ?? this.attempts,
    correct: correct ?? this.correct,
    lastScore: lastScore ?? this.lastScore,
    correctStreak: correctStreak ?? this.correctStreak,
    lastPracticedAt: lastPracticedAt ?? this.lastPracticedAt,
    nextReviewAt: nextReviewAt ?? this.nextReviewAt,
  );

  Map<String, dynamic> toJson() => {
    'attempts': attempts, 'correct': correct, 'lastScore': lastScore,
    'correctStreak': correctStreak,
    'lastPracticedAt': lastPracticedAt?.toIso8601String(),
    'nextReviewAt': nextReviewAt?.toIso8601String(),
  };

  factory TutorItemProgress.fromJson(Map<String, dynamic> json) => TutorItemProgress(
    attempts: (json['attempts'] as num?)?.toInt() ?? 0,
    correct: (json['correct'] as num?)?.toInt() ?? 0,
    lastScore: (json['lastScore'] as num?)?.toInt() ?? 0,
    correctStreak: (json['correctStreak'] as num?)?.toInt() ?? 0,
    lastPracticedAt: DateTime.tryParse(json['lastPracticedAt'] as String? ?? ''),
    nextReviewAt: DateTime.tryParse(json['nextReviewAt'] as String? ?? ''),
  );
}
