import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/lessons.dart';

class ProgressService extends ChangeNotifier {
  static const _key = 'speaklocal_progress_v1';

  int xp = 0;
  int streak = 0;
  int hearts = 5;
  int dailyGoal = 50;
  int dailyXp = 0;
  String? lastPracticeDate;
  Set<String> completedLessons = {};
  Map<String, int> bestScores = {};

  bool get dailyGoalMet => dailyXp >= dailyGoal;

  Future<void> load() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_key);
    if (raw == null) {
      notifyListeners();
      return;
    }
    final map = jsonDecode(raw) as Map<String, dynamic>;
    xp = map['xp'] as int? ?? 0;
    streak = map['streak'] as int? ?? 0;
    hearts = map['hearts'] as int? ?? 5;
    dailyGoal = map['dailyGoal'] as int? ?? 50;
    dailyXp = map['dailyXp'] as int? ?? 0;
    lastPracticeDate = map['lastPracticeDate'] as String?;
    completedLessons = Set<String>.from(
      (map['completedLessons'] as List?)?.cast<String>() ?? [],
    );
    final rawScores = map['bestScores'];
    if (rawScores is Map) {
      bestScores = {
        for (final e in rawScores.entries)
          e.key.toString(): (e.value as num).toInt(),
      };
    } else {
      bestScores = {};
    }
    _rollDailyIfNeeded();
    notifyListeners();
  }

  Future<void> _save() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      _key,
      jsonEncode({
        'xp': xp,
        'streak': streak,
        'hearts': hearts,
        'dailyGoal': dailyGoal,
        'dailyXp': dailyXp,
        'lastPracticeDate': lastPracticeDate,
        'completedLessons': completedLessons.toList(),
        'bestScores': bestScores,
      }),
    );
  }

  String _today() {
    final n = DateTime.now();
    return '${n.year}-${n.month.toString().padLeft(2, '0')}-${n.day.toString().padLeft(2, '0')}';
  }

  void _rollDailyIfNeeded() {
    final today = _today();
    if (lastPracticeDate == null) return;
    if (lastPracticeDate == today) return;

    final last = DateTime.tryParse(lastPracticeDate!);
    final now = DateTime.now();
    if (last != null) {
      final gap = DateTime(now.year, now.month, now.day)
          .difference(DateTime(last.year, last.month, last.day))
          .inDays;
      if (gap > 1) streak = 0;
    }
    dailyXp = 0;
  }

  bool isLessonUnlocked(String lessonId) {
    final lessons = allLessons();
    final index = lessons.indexWhere((l) => l.id == lessonId);
    if (index <= 0) return true;
    return completedLessons.contains(lessons[index - 1].id);
  }

  bool isCompleted(String lessonId) => completedLessons.contains(lessonId);

  Future<void> addPracticeResult({
    required String lessonId,
    required int averageScore,
    required int earnedXp,
  }) async {
    _rollDailyIfNeeded();
    final today = _today();
    if (lastPracticeDate != today) {
      if (lastPracticeDate != null) {
        final last = DateTime.tryParse(lastPracticeDate!);
        final now = DateTime.now();
        if (last != null) {
          final gap = DateTime(now.year, now.month, now.day)
              .difference(DateTime(last.year, last.month, last.day))
              .inDays;
          if (gap == 1) {
            streak += 1;
          } else if (gap > 1) {
            streak = 1;
          }
        } else {
          streak = 1;
        }
      } else {
        streak = 1;
      }
      lastPracticeDate = today;
    }

    xp += earnedXp;
    dailyXp += earnedXp;
    final prev = bestScores[lessonId] ?? 0;
    if (averageScore > prev) bestScores[lessonId] = averageScore;
    if (averageScore >= 55) {
      completedLessons.add(lessonId);
    }
    notifyListeners();
    await _save();
  }

  Future<void> loseHeart() async {
    if (hearts > 0) hearts -= 1;
    notifyListeners();
    await _save();
  }

  Future<void> refillHearts() async {
    hearts = 5;
    notifyListeners();
    await _save();
  }

  Future<void> resetAll() async {
    xp = 0;
    streak = 0;
    hearts = 5;
    dailyXp = 0;
    lastPracticeDate = null;
    completedLessons.clear();
    bestScores.clear();
    notifyListeners();
    await _save();
  }

  int completedCount() => completedLessons.length;

  double overallProgress() {
    final total = allLessons().length;
    if (total == 0) return 0;
    return completedLessons.length / total;
  }
}
