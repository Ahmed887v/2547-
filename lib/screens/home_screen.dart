import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';

import '../data/lessons.dart';
import '../services/progress_service.dart';
import '../theme/app_theme.dart';
import '../widgets/stat_chip.dart';
import 'lesson_map_screen.dart';
import 'profile_screen.dart';
import 'practice_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _tab = 0;

  @override
  Widget build(BuildContext context) {
    final pages = [
      const _LearnTab(),
      const LessonMapScreen(),
      const ProfileScreen(),
    ];

    return Scaffold(
      body: SafeArea(child: pages[_tab]),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          border: Border(top: BorderSide(color: AppColors.line, width: 2)),
        ),
        child: BottomNavigationBar(
          currentIndex: _tab,
          onTap: (i) => setState(() => _tab = i),
          selectedItemColor: AppColors.green,
          unselectedItemColor: AppColors.muted,
          selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w800),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_rounded),
              label: 'Learn',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.map_rounded),
              label: 'Path',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_rounded),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}

class _LearnTab extends StatelessWidget {
  const _LearnTab();

  @override
  Widget build(BuildContext context) {
    final progress = context.watch<ProgressService>();
    final lessons = allLessons();
    final next = lessons.firstWhere(
      (l) => !progress.isCompleted(l.id) && progress.isLessonUnlocked(l.id),
      orElse: () => lessons.last,
    );
    final goalPct = (progress.dailyXp / progress.dailyGoal).clamp(0.0, 1.0);

    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 28),
      children: [
        Row(
          children: [
            const Text(
              'SpeakLocal',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w900,
                color: AppColors.green,
              ),
            ),
            const Spacer(),
            StatChip(
              icon: Icons.local_fire_department_rounded,
              value: '${progress.streak}',
              color: AppColors.orange,
            ),
            const SizedBox(width: 8),
            StatChip(
              icon: Icons.bolt_rounded,
              value: '${progress.xp}',
              color: AppColors.yellow,
            ),
            const SizedBox(width: 8),
            StatChip(
              icon: Icons.favorite_rounded,
              value: '${progress.hearts}',
              color: AppColors.red,
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          'Speak English every day — fully on your phone.',
          style: TextStyle(color: AppColors.muted.withOpacity(0.95)),
        ),
        const SizedBox(height: 22),
        Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFFE8FFF0), Color(0xFFD7FFB8)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: AppColors.greenSoft, width: 2),
          ),
          child: Row(
            children: [
              CircularPercentIndicator(
                radius: 42,
                lineWidth: 9,
                percent: goalPct,
                animation: true,
                circularStrokeCap: CircularStrokeCap.round,
                progressColor: AppColors.green,
                backgroundColor: Colors.white,
                center: Text(
                  '${(goalPct * 100).round()}%',
                  style: const TextStyle(fontWeight: FontWeight.w900),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Daily speaking goal',
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${progress.dailyXp} / ${progress.dailyGoal} XP today',
                      style: const TextStyle(color: AppColors.muted),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      progress.dailyGoalMet
                          ? 'Goal complete — amazing!'
                          : 'A few phrases keep your streak alive.',
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        color: AppColors.greenDark,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        const Text(
          'Continue speaking',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
        ),
        const SizedBox(height: 12),
        _NextLessonCard(
          emoji: next.emoji,
          title: next.title,
          subtitle: next.subtitle,
          color: Color(next.color.argb),
          onStart: () {
            if (progress.hearts <= 0) {
              _showNoHearts(context);
              return;
            }
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => PracticeScreen(lessonId: next.id),
              ),
            );
          },
        ),
        const SizedBox(height: 24),
        const Text(
          'How it works',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
        ),
        const SizedBox(height: 12),
        const _TipTile(
          icon: Icons.hearing_rounded,
          title: 'Listen',
          body: 'Hear natural English on your device TTS.',
          color: AppColors.blue,
        ),
        const _TipTile(
          icon: Icons.mic_rounded,
          title: 'Speak',
          body: 'Repeat into the mic — like ELSA Speak drills.',
          color: AppColors.green,
        ),
        const _TipTile(
          icon: Icons.insights_rounded,
          title: 'Score',
          body: 'Local pronunciation score + XP, no account needed.',
          color: AppColors.purple,
        ),
      ],
    );
  }

  void _showNoHearts(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Out of hearts'),
        content: const Text(
          'Take a short break, then refill hearts from Profile to keep practicing.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}

class _NextLessonCard extends StatelessWidget {
  final String emoji;
  final String title;
  final String subtitle;
  final Color color;
  final VoidCallback onStart;

  const _NextLessonCard({
    required this.emoji,
    required this.title,
    required this.subtitle,
    required this.color,
    required this.onStart,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.line, width: 2),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.18),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 56,
                height: 56,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: color.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Text(emoji, style: const TextStyle(fontSize: 28)),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 18,
                      ),
                    ),
                    Text(subtitle, style: const TextStyle(color: AppColors.muted)),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          SoftButton(
            label: 'Start lesson',
            icon: Icons.play_arrow_rounded,
            color: color,
            dark: Color.lerp(color, Colors.black, 0.2)!,
            onPressed: onStart,
          ),
        ],
      ),
    );
  }
}

class _TipTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String body;
  final Color color;

  const _TipTile({
    required this.icon,
    required this.title,
    required this.body,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
          side: const BorderSide(color: AppColors.line, width: 2),
        ),
        leading: CircleAvatar(
          backgroundColor: color.withOpacity(0.15),
          child: Icon(icon, color: color),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w800)),
        subtitle: Text(body),
      ),
    );
  }
}
