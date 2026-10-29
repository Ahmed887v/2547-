// Local learning memory for SpeakLocal.
//
// Stores vocabulary and language corrections independently from lesson progress.
// Data stays on this device and survives app restarts.
// A future AI conversation service can call these methods to save learning items.

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum LearningMemoryKind {
  vocabulary,
  correction,
}

class LearningMemoryItem {
  final String id;
  final LearningMemoryKind kind;
  final String original;
  final String corrected;
  final String explanation;
  final String example;
  final int occurrences;
  final int successfulUses;
  final int reviewIntervalDays;
  final int correctReviewStreak;
  final DateTime createdAt;
  final DateTime? lastReviewedAt;
  final DateTime nextReviewAt;

  const LearningMemoryItem({
    required this.id,
    required this.kind,
    required this.original,
    required this.corrected,
    required this.explanation,
    required this.example,
    required this.occurrences,
    required this.successfulUses,
    required this.reviewIntervalDays,
    required this.correctReviewStreak,
    required this.createdAt,
    required this.lastReviewedAt,
    required this.nextReviewAt,
  });

  factory LearningMemoryItem.fromJson(Map<String, dynamic> json) {
    return LearningMemoryItem(
      id: json['id'] as String,
      kind: LearningMemoryKind.values.firstWhere(
        (value) => value.name == json['kind'],
        orElse: () => LearningMemoryKind.vocabulary,
      ),
      original: json['original'] as String? ?? '',
      corrected: json['corrected'] as String? ?? '',
      explanation: json['explanation'] as String? ?? '',
      example: json['example'] as String? ?? '',
      occurrences: (json['occurrences'] as num?)?.toInt() ?? 1,
      successfulUses: (json['successfulUses'] as num?)?.toInt() ?? 0,
      reviewIntervalDays:
          (json['reviewIntervalDays'] as num?)?.toInt() ?? 0,
      correctReviewStreak:
          (json['correctReviewStreak'] as num?)?.toInt() ?? 0,
      createdAt: DateTime.tryParse(json['createdAt'] as String? ?? '') ??
          DateTime.now(),
      lastReviewedAt:
          DateTime.tryParse(json['lastReviewedAt'] as String? ?? ''),
      nextReviewAt:
          DateTime.tryParse(json['nextReviewAt'] as String? ?? '') ??
              DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'kind': kind.name,
        'original': original,
        'corrected': corrected,
        'explanation': explanation,
        'example': example,
        'occurrences': occurrences,
        'successfulUses': successfulUses,
        'reviewIntervalDays': reviewIntervalDays,
        'correctReviewStreak': correctReviewStreak,
        'createdAt': createdAt.toIso8601String(),
        'lastReviewedAt': lastReviewedAt?.toIso8601String(),
        'nextReviewAt': nextReviewAt.toIso8601String(),
      };

  LearningMemoryItem copyWith({
    String? original,
    String? corrected,
    String? explanation,
    String? example,
    int? occurrences,
    int? successfulUses,
    int? reviewIntervalDays,
    int? correctReviewStreak,
    DateTime? lastReviewedAt,
    DateTime? nextReviewAt,
  }) {
    return LearningMemoryItem(
      id: id,
      kind: kind,
      original: original ?? this.original,
      corrected: corrected ?? this.corrected,
      explanation: explanation ?? this.explanation,
      example: example ?? this.example,
      occurrences: occurrences ?? this.occurrences,
      successfulUses: successfulUses ?? this.successfulUses,
      reviewIntervalDays:
          reviewIntervalDays ?? this.reviewIntervalDays,
      correctReviewStreak:
          correctReviewStreak ?? this.correctReviewStreak,
      createdAt: createdAt,
      lastReviewedAt: lastReviewedAt ?? this.lastReviewedAt,
      nextReviewAt: nextReviewAt ?? this.nextReviewAt,
    );
  }
}

class LearningMemoryService extends ChangeNotifier {
  static const String _storageKey = 'speaklocal_learning_memory_v1';

  final Map<String, LearningMemoryItem> _items = {};
  bool _loaded = false;

  bool get isLoaded => _loaded;

  List<LearningMemoryItem> get items {
    final result = _items.values.toList();
    result.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    return List.unmodifiable(result);
  }

  List<LearningMemoryItem> get vocabulary => items
      .where((item) => item.kind == LearningMemoryKind.vocabulary)
      .toList();

  List<LearningMemoryItem> get corrections => items
      .where((item) => item.kind == LearningMemoryKind.correction)
      .toList();

  List<LearningMemoryItem> get dueItems {
    final now = DateTime.now();
    final result = _items.values
        .where((item) => !item.nextReviewAt.isAfter(now))
        .toList();
    result.sort((a, b) => a.nextReviewAt.compareTo(b.nextReviewAt));
    return result;
  }

  Future<void> load() async {
    if (_loaded) return;

    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_storageKey);

    if (raw != null) {
      try {
        final decoded = jsonDecode(raw);
        if (decoded is List) {
          for (final entry in decoded) {
            if (entry is Map<String, dynamic>) {
              final item = LearningMemoryItem.fromJson(entry);
              _items[item.id] = item;
            } else if (entry is Map) {
              final item = LearningMemoryItem.fromJson(
                Map<String, dynamic>.from(entry),
              );
              _items[item.id] = item;
            }
          }
        }
      } on FormatException {
        // Keep the app usable if the stored learning-memory JSON is damaged.
        // Do not delete or overwrite the raw value automatically.
      }
    }

    _loaded = true;
    notifyListeners();
  }

  Future<void> recordVocabulary({
    required String word,
    String translation = '',
    String example = '',
  }) async {
    final value = word.trim();
    if (value.isEmpty) return;

    final existing = _find(
      kind: LearningMemoryKind.vocabulary,
      original: value,
    );

    if (existing != null) {
      _items[existing.id] = existing.copyWith(
        occurrences: existing.occurrences + 1,
        explanation:
            translation.trim().isEmpty ? null : translation.trim(),
        example: example.trim().isEmpty ? null : example.trim(),
      );
    } else {
      final now = DateTime.now();
      final item = LearningMemoryItem(
        id: 'v_${now.microsecondsSinceEpoch}',
        kind: LearningMemoryKind.vocabulary,
        original: value,
        corrected: value,
        explanation: translation.trim(),
        example: example.trim(),
        occurrences: 1,
        successfulUses: 0,
        reviewIntervalDays: 0,
        correctReviewStreak: 0,
        createdAt: now,
        lastReviewedAt: null,
        nextReviewAt: now,
      );
      _items[item.id] = item;
    }

    await _persist();
  }

  Future<void> recordCorrection({
    required String original,
    required String corrected,
    String explanation = '',
    String example = '',
  }) async {
    final wrong = original.trim();
    final right = corrected.trim();
    if (wrong.isEmpty || right.isEmpty) return;

    final existing = _find(
      kind: LearningMemoryKind.correction,
      original: wrong,
      corrected: right,
    );

    if (existing != null) {
      _items[existing.id] = existing.copyWith(
        occurrences: existing.occurrences + 1,
        explanation:
            explanation.trim().isEmpty ? null : explanation.trim(),
        example: example.trim().isEmpty ? null : example.trim(),
      );
    } else {
      final now = DateTime.now();
      final item = LearningMemoryItem(
        id: 'c_${now.microsecondsSinceEpoch}',
        kind: LearningMemoryKind.correction,
        original: wrong,
        corrected: right,
        explanation: explanation.trim(),
        example: example.trim(),
        occurrences: 1,
        successfulUses: 0,
        reviewIntervalDays: 0,
        correctReviewStreak: 0,
        createdAt: now,
        lastReviewedAt: null,
        nextReviewAt: now,
      );
      _items[item.id] = item;
    }

    await _persist();
  }

  // Call this when the learner independently uses a saved correction correctly.
  Future<void> recordSuccessfulUse(String itemId) async {
    final item = _items[itemId];
    if (item == null) return;

    _items[itemId] = item.copyWith(
      successfulUses: item.successfulUses + 1,
    );
    await _persist();
  }

  // Quality scale: 0 = forgot completely, 5 = remembered easily.
  // Repeated successful reviews gradually increase the interval.
  Future<void> markReviewed({
    required String itemId,
    required int quality,
  }) async {
    final item = _items[itemId];
    if (item == null) return;

    final score = quality.clamp(0, 5);
    final int interval;
    final int streak;

    if (score < 3) {
      interval = 1;
      streak = 0;
    } else {
      interval = item.reviewIntervalDays == 0
          ? 1
          : score == 3
              ? item.reviewIntervalDays
              : item.reviewIntervalDays * 2;
      streak = item.correctReviewStreak + 1;
    }

    final now = DateTime.now();
    _items[itemId] = item.copyWith(
      reviewIntervalDays: interval,
      correctReviewStreak: streak,
      lastReviewedAt: now,
      nextReviewAt: now.add(Duration(days: interval)),
    );

    await _persist();
  }

  LearningMemoryItem? _find({
    required LearningMemoryKind kind,
    required String original,
    String? corrected,
  }) {
    final normalizedOriginal = _normalize(original);
    final normalizedCorrected =
        corrected == null ? null : _normalize(corrected);

    for (final item in _items.values) {
      if (item.kind != kind ||
          _normalize(item.original) != normalizedOriginal) {
        continue;
      }

      if (normalizedCorrected != null &&
          _normalize(item.corrected) != normalizedCorrected) {
        continue;
      }

      return item;
    }
    return null;
  }

  String _normalize(String value) =>
      value.toLowerCase().replaceAll(RegExp(r'\s+'), ' ').trim();

  Future<void> _persist() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      _storageKey,
      jsonEncode(_items.values.map((item) => item.toJson()).toList()),
    );
    notifyListeners();
  }
}
