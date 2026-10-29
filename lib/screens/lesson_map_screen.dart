import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/lessons.dart';
import '../models/lesson.dart';
import '../services/progress_service.dart';
import '../theme/app_theme.dart';
import 'practice_screen.dart';

class LessonMapScreen extends StatelessWidget {
  const LessonMapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final progress = context.watch<ProgressService>();

    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 28),
      children: [
        const Text(
          'Learning path',
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.w900),
        ),
        const SizedBox(height: 4),
        Text(
          '${progress.completedCount()} / ${allLessons().length} lessons cleared',
          style: const TextStyle(color: AppColors.muted),
        ),
        const SizedBox(height: 18),
        ...curriculum.map((unit) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.sky.withOpacity(0.55),
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: AppColors.blue.withOpacity(0.25)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      unit.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 18,
                        color: AppColors.blueDark,
                      ),
                    ),
                    Text(
                      unit.description,
                      style: const TextStyle(color: AppColors.muted),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 14),
              ...unit.lessons.asMap().entries.map((entry) {
                final i = entry.key;
                final lesson = entry.value;
                final unlocked = progress.isLessonUnlocked(lesson.id);
                final done = progress.isCompleted(lesson.id);
                final best = progress.bestScores[lesson.id];
                return _PathNode(
                  lesson: lesson,
                  index: i + 1,
                  unlocked: unlocked,
                  done: done,
                  best: best,
                  onTap: () {
                    if (!unlocked) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Finish the previous lesson first.'),
                        ),
                      );
                      return;
                    }
                    if (progress.hearts <= 0) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('No hearts left. Refill in Profile.'),
                        ),
                      );
                      return;
                    }
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => PracticeScreen(lessonId: lesson.id),
                      ),
                    );
                  },
                );
              }),
              const SizedBox(height: 18),
            ],
          );
        }),
      ],
    );
  }
}

class _PathNode extends StatelessWidget {
  final Lesson lesson;
  final int index;
  final bool unlocked;
  final bool done;
  final int? best;
  final VoidCallback onTap;

  const _PathNode({
    required this.lesson,
    required this.index,
    required this.unlocked,
    required this.done,
    required this.best,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final color = Color(lesson.color.argb);
    final alignRight = index.isEven;

    return Padding(
      padding: EdgeInsets.only(
        left: alignRight ? 48 : 0,
        right: alignRight ? 0 : 48,
        bottom: 14,
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(22),
        child: Ink(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: unlocked ? Colors.white : const Color(0xFFF3F3F3),
            borderRadius: BorderRadius.circular(22),
            border: Border.all(
              color: done
                  ? color
                  : (unlocked ? AppColors.line : const Color(0xFFD8D8D8)),
              width: 2.5,
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 54,
                height: 54,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: unlocked
                      ? color.withOpacity(0.18)
                      : const Color(0xFFE0E0E0),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: unlocked ? color : const Color(0xFFBDBDBD),
                    width: 3,
                  ),
                ),
                child: Text(
                  unlocked ? lesson.emoji : '🔒',
                  style: const TextStyle(fontSize: 22),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      lesson.title,
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        color: unlocked ? AppColors.ink : AppColors.muted,
                      ),
                    ),
                    Text(
                      lesson.subtitle,
                      style: const TextStyle(color: AppColors.muted, fontSize: 13),
                    ),
                    if (best != null)
                      Text(
                        'Best score $best% · +${lesson.xpReward} XP',
                        style: TextStyle(
                          color: color,
                          fontWeight: FontWeight.w800,
                          fontSize: 12,
                        ),
                      ),
                  ],
                ),
              ),
              Icon(
                done
                    ? Icons.check_circle_rounded
                    : (unlocked
                        ? Icons.play_circle_fill_rounded
                        : Icons.lock_rounded),
                color: done
                    ? AppColors.green
                    : (unlocked ? color : AppColors.muted),
                size: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
