import 'package:flutter/material.dart';

import '../services/learning_memory_service.dart';
import '../services/practice_analytics_service.dart';
import '../theme/app_theme.dart';

/// Combines saved exercise attempts and due learning-memory items in one view.
class LearningHistoryScreen extends StatefulWidget {
  const LearningHistoryScreen({super.key});

  @override
  State<LearningHistoryScreen> createState() => _LearningHistoryScreenState();
}

class _LearningHistoryScreenState extends State<LearningHistoryScreen> {
  late final PracticeAnalyticsService _analytics;
  late final LearningMemoryService _memory;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _analytics = PracticeAnalyticsService();
    _memory = LearningMemoryService();
    _load();
  }

  Future<void> _load() async {
    await Future.wait([_analytics.load(), _memory.load()]);
    if (mounted) setState(() => _loading = false);
  }

  @override
  void dispose() {
    _analytics.dispose();
    _memory.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Learning history'),
        foregroundColor: AppColors.greenDark,
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : AnimatedBuilder(
              animation: Listenable.merge([_analytics, _memory]),
              builder: (context, _) {
                final summary = _analytics.summary;
                final attempts = _analytics.attempts;
                final due = _memory.dueItems;
                return ListView(
                  padding: const EdgeInsets.all(20),
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: _StatCard(
                            label: 'Attempts',
                            value: '${summary.totalAttempts}',
                            icon: Icons.history_rounded,
                            color: AppColors.blue,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: _StatCard(
                            label: 'Average score',
                            value: '${summary.averageScore.round()}%',
                            icon: Icons.insights_rounded,
                            color: AppColors.green,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: _StatCard(
                            label: 'Due to review',
                            value: '${due.length}',
                            icon: Icons.replay_rounded,
                            color: AppColors.orange,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    const Text('Focus next',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900)),
                    const SizedBox(height: 8),
                    if (summary.weakPrompts.isEmpty)
                      const _EmptyNote(
                        text: 'No weak prompts yet. Keep practising and your low-scoring items will appear here.',
                      )
                    else
                      ...summary.weakPrompts.take(8).map(
                            (prompt) => ListTile(
                              contentPadding: EdgeInsets.zero,
                              leading: const Icon(Icons.flag_rounded, color: AppColors.orange),
                              title: Text(prompt),
                              subtitle: const Text('Prioritised by recent practice scores'),
                            ),
                          ),
                    const SizedBox(height: 16),
                    const Text('Review memory',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900)),
                    const SizedBox(height: 8),
                    if (due.isEmpty)
                      const _EmptyNote(
                        text: 'Nothing is due right now. Mistakes and saved vocabulary are kept on this device.',
                      )
                    else
                      ...due.take(12).map(
                            (item) => Card(
                              child: ListTile(
                                leading: Icon(
                                  item.kind == LearningMemoryKind.correction
                                      ? Icons.edit_note_rounded
                                      : Icons.bookmark_rounded,
                                  color: AppColors.purple,
                                ),
                                title: Text(item.corrected.isEmpty ? item.original : item.corrected),
                                subtitle: Text(item.explanation.isEmpty ? item.example : item.explanation),
                              ),
                            ),
                          ),
                    const SizedBox(height: 16),
                    const Text('Recent attempts',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900)),
                    const SizedBox(height: 8),
                    if (attempts.isEmpty)
                      const _EmptyNote(
                        text: 'Your practice attempts will appear here after you complete exercises.',
                      )
                    else
                      ...attempts.take(30).map(
                            (attempt) => ListTile(
                              contentPadding: EdgeInsets.zero,
                              leading: CircleAvatar(
                                backgroundColor: attempt.score >= 70
                                    ? AppColors.greenSoft
                                    : const Color(0xFFFFE3E3),
                                child: Text(
                                  '${attempt.score}',
                                  style: const TextStyle(fontWeight: FontWeight.w900),
                                ),
                              ),
                              title: Text(attempt.prompt.isEmpty ? attempt.target : attempt.prompt),
                              subtitle: Text(
                                '${attempt.exerciseType.replaceAll('_', ' ')} · ${attempt.createdAt.toLocal()}',
                              ),
                              trailing: const Icon(Icons.chevron_right_rounded),
                            ),
                          ),
                    const SizedBox(height: 16),
                    const Text(
                      'Scores reflect the app exercise evaluation. Speaking scores compare recognised text and are not acoustic pronunciation measurements.',
                      style: TextStyle(color: AppColors.muted, fontSize: 12),
                    ),
                  ],
                );
              },
            ),
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
  });

  final String label;
  final String value;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) => Card(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              Icon(icon, color: color),
              const SizedBox(height: 8),
              Text(value, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w900)),
              Text(label, textAlign: TextAlign.center, style: const TextStyle(fontSize: 11, color: AppColors.muted)),
            ],
          ),
        ),
      );
}

class _EmptyNote extends StatelessWidget {
  const _EmptyNote({required this.text});
  final String text;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Text(text, style: const TextStyle(color: AppColors.muted)),
      );
}
