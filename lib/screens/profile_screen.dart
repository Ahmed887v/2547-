import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';

import '../data/lessons.dart';
import 'review_screen.dart';
import '../services/learning_memory_service.dart';
import '../services/progress_service.dart';
import '../theme/app_theme.dart';
import '../widgets/stat_chip.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final progress = context.watch<ProgressService>();
    final pct = progress.overallProgress();

    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 28),
      children: [
        const Text(
          'Your profile',
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.w900),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFFFFF6D8), Color(0xFFFFE8A3)],
            ),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: AppColors.yellow.withOpacity(0.5)),
          ),
          child: Column(
            children: [
              const CircleAvatar(
                radius: 40,
                backgroundColor: Colors.white,
                child: Text('🦉', style: TextStyle(fontSize: 40)),
              ),
              const SizedBox(height: 10),
              const Text(
                'Local Learner',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900),
              ),
              const SizedBox(height: 6),
              const Text(
                'Offline English speaking coach',
                style: TextStyle(color: AppColors.muted),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  StatChip(
                    icon: Icons.bolt_rounded,
                    value: '${progress.xp} XP',
                    color: AppColors.orange,
                  ),
                  StatChip(
                    icon: Icons.local_fire_department_rounded,
                    value: '${progress.streak} day',
                    color: AppColors.red,
                  ),
                  StatChip(
                    icon: Icons.favorite_rounded,
                    value: '${progress.hearts}',
                    color: AppColors.red,
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 22),
        const Text(
          'Course progress',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
        ),
        const SizedBox(height: 10),
        LinearPercentIndicator(
          lineHeight: 16,
          percent: pct,
          animation: true,
          barRadius: const Radius.circular(12),
          progressColor: AppColors.green,
          backgroundColor: AppColors.line,
          padding: EdgeInsets.zero,
        ),
        const SizedBox(height: 8),
        Text(
          '${progress.completedCount()} of ${allLessons().length} lessons · ${(pct * 100).round()}%',
          style: const TextStyle(color: AppColors.muted),
        ),
        const SizedBox(height: 18),
        Consumer<LearningMemoryService>(
          builder: (context, memory, child) => SoftButton(
            label: 'Review words & corrections (${memory.items.length})',
            icon: Icons.auto_stories_rounded,
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute<void>(
                  builder: (_) => const ReviewScreen(),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 24),
        const SizedBox(height: 24),
        SoftButton(
          label: 'Refill hearts',
          icon: Icons.favorite_rounded,
          color: AppColors.red,
          dark: const Color(0xFFD13333),
          onPressed: () async {
            await context.read<ProgressService>().refillHearts();
            if (context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Hearts refilled to 5')),
              );
            }
          },
        ),
        const SizedBox(height: 12),
        SoftButton(
          label: 'Reset progress',
          outlined: true,
          onPressed: () async {
            final ok = await showDialog<bool>(
              context: context,
              builder: (ctx) => AlertDialog(
                title: const Text('Reset everything?'),
                content: const Text(
                  'XP, streak, and completed lessons will be cleared on this device.',
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(ctx, false),
                    child: const Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () => Navigator.pop(ctx, true),
                    child: const Text('Reset'),
                  ),
                ],
              ),
            );
            if (ok == true && context.mounted) {
              await context.read<ProgressService>().resetAll();
            }
          },
        ),
        const SizedBox(height: 28),
        const Text(
          'About SpeakLocal',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
        ),
        const SizedBox(height: 8),
        const Text(
          'SpeakLocal is a Duolingo / ELSA-inspired speaking trainer that runs '
          'locally on your Android phone. Lessons, XP, and scores stay on device. '
          'Speech recognition uses your phone’s English recognizer; text-to-speech '
          'uses the built-in voice engine.',
          style: TextStyle(height: 1.45, color: AppColors.muted),
        ),
      ],
    );
  }
}
