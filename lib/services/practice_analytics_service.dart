import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// A persisted record of one learning attempt.
///
/// The score measures the app's existing exercise evaluation. It must not be
/// interpreted as a clinical or acoustic measurement of pronunciation.
@immutable
class PracticeAttempt {
  const PracticeAttempt({
    required this.lessonId,
    required this.prompt,
    required this.target,
    required this.score,
    required this.createdAt,
    required this.exerciseType,
  });

  final String lessonId;
  final String prompt;
  final String target;
  final int score;
  final DateTime createdAt;
  final String exerciseType;

  Map<String, Object?> toJson() => {
        'lessonId': lessonId,
        'prompt': prompt,
        'target': target,
        'score': score,
        'createdAt': createdAt.toUtc().toIso8601String(),
        'exerciseType': exerciseType,
      };

  factory PracticeAttempt.fromJson(Map<String, dynamic> json) {
    final rawScore = json['score'];
    final parsedScore = rawScore is num ? rawScore.toInt() : 0;

    return PracticeAttempt(
      lessonId: json['lessonId'] as String? ?? '',
      prompt: json['prompt'] as String? ?? '',
      target: json['target'] as String? ?? '',
      score: parsedScore.clamp(0, 100),
      createdAt: DateTime.tryParse(json['createdAt'] as String? ?? '') ??
          DateTime.fromMillisecondsSinceEpoch(0, isUtc: true),
      exerciseType: json['exerciseType'] as String? ?? 'unknown',
    );
  }
}

/// Summary calculated from saved attempts rather than guessed from XP.
@immutable
class PracticeAnalyticsSummary {
  const PracticeAnalyticsSummary({
    required this.totalAttempts,
    required this.averageScore,
    required this.weakPrompts,
    required this.recentAttempts,
  });

  final int totalAttempts;
  final double averageScore;
  final List<String> weakPrompts;
  final List<PracticeAttempt> recentAttempts;
}

/// Stores exercise history separately from the existing progress and memory
/// keys, so adding analytics never overwrites the user's current progress.
class PracticeAnalyticsService extends ChangeNotifier {
  PracticeAnalyticsService({SharedPreferences? preferences})
      : _preferences = preferences;

  static const storageKey = 'speaklocal_practice_attempts_v1';
  static const int maxStoredAttempts = 2000;

  SharedPreferences? _preferences;
  final List<PracticeAttempt> _attempts = [];
  bool _loaded = false;

  List<PracticeAttempt> get attempts => List.unmodifiable(_attempts);
  bool get isLoaded => _loaded;

  Future<void> load() async {
    _preferences ??= await SharedPreferences.getInstance();
    final raw = _preferences!.getString(storageKey);
    _attempts.clear();

    if (raw != null && raw.isNotEmpty) {
      try {
        final decoded = jsonDecode(raw);
        if (decoded is List) {
          for (final entry in decoded) {
            if (entry is Map<String, dynamic>) {
              _attempts.add(PracticeAttempt.fromJson(entry));
            } else if (entry is Map) {
              _attempts.add(
                PracticeAttempt.fromJson(Map<String, dynamic>.from(entry)),
              );
            }
          }
        }
      } on FormatException {
        // Preserve app availability if this new analytics key is malformed.
        // Do not clear or modify any other saved user data.
        _attempts.clear();
      }
    }

    _attempts.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    _loaded = true;
    notifyListeners();
  }

  Future<void> recordAttempt({
    required String lessonId,
    required String prompt,
    required String target,
    required int score,
    required String exerciseType,
    DateTime? createdAt,
  }) async {
    if (!_loaded) await load();

    final normalizedScore = score.clamp(0, 100);
    _attempts.insert(
      0,
      PracticeAttempt(
        lessonId: lessonId,
        prompt: prompt.trim(),
        target: target.trim(),
        score: normalizedScore,
        createdAt: (createdAt ?? DateTime.now()).toUtc(),
        exerciseType: exerciseType,
      ),
    );

    if (_attempts.length > maxStoredAttempts) {
      _attempts.removeRange(maxStoredAttempts, _attempts.length);
    }

    await _persist();
    notifyListeners();
  }

  PracticeAnalyticsSummary get summary {
    if (_attempts.isEmpty) {
      return const PracticeAnalyticsSummary(
        totalAttempts: 0,
        averageScore: 0,
        weakPrompts: [],
        recentAttempts: [],
      );
    }

    final total = _attempts.fold<int>(0, (sum, item) => sum + item.score);
    final byPrompt = <String, List<int>>{};

    for (final attempt in _attempts) {
      final key = '${attempt.lessonId}::${attempt.prompt.toLowerCase()}';
      byPrompt.putIfAbsent(key, () => []).add(attempt.score);
    }

    final weak = byPrompt.entries
        .map((entry) {
          final average =
              entry.value.reduce((a, b) => a + b) / entry.value.length;
          return (prompt: entry.key.split('::').last, average: average);
        })
        .where((item) => item.average < 70)
        .toList()
      ..sort((a, b) => a.average.compareTo(b.average));

    return PracticeAnalyticsSummary(
      totalAttempts: _attempts.length,
      averageScore: total / _attempts.length,
      weakPrompts: List.unmodifiable(weak.map((item) => item.prompt).toSet()),
      recentAttempts: List.unmodifiable(_attempts.take(10)),
    );
  }

  Future<void> _persist() async {
    final preferences = _preferences ??= await SharedPreferences.getInstance();
    await preferences.setString(
      storageKey,
      jsonEncode(_attempts.map((attempt) => attempt.toJson()).toList()),
    );
  }
}
