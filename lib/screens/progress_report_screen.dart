import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/practice_analytics_service.dart';
import '../services/progress_service.dart';
import '../theme/app_theme.dart';

/// Reports persisted learning activity; transcript scores are not acoustic measurements.
class ProgressReportScreen extends StatefulWidget {
  const ProgressReportScreen({super.key});
  @override
  State<ProgressReportScreen> createState() => _ProgressReportScreenState();
}

class _ProgressReportScreenState extends State<ProgressReportScreen> {
  late final PracticeAnalyticsService _analytics;
  bool _loading = true;
  @override
  void initState() { super.initState(); _analytics = PracticeAnalyticsService(); _load(); }
  Future<void> _load() async { await _analytics.load(); if (mounted) setState(() => _loading = false); }
  @override
  void dispose() { _analytics.dispose(); super.dispose(); }
  @override
  Widget build(BuildContext context) {
    final progress = context.watch<ProgressService>();
    final summary = _analytics.summary;
    return Scaffold(
      appBar: AppBar(title: const Text('Progress report')),
      body: _loading ? const Center(child: CircularProgressIndicator()) : ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Text('YOUR LEARNING OVERVIEW', style: TextStyle(color: AppColors.greenDark, fontWeight: FontWeight.w900, letterSpacing: 1)),
          const SizedBox(height: 14),
          GridView.count(crossAxisCount: 2, shrinkWrap: true, physics: const NeverScrollableScrollPhysics(), crossAxisSpacing: 12, mainAxisSpacing: 12, childAspectRatio: 1.45, children: [
            _MetricCard(label: 'Total XP', value: '${progress.xp}', icon: Icons.bolt_rounded, color: AppColors.orange),
            _MetricCard(label: 'Day streak', value: '${progress.streak}', icon: Icons.local_fire_department_rounded, color: AppColors.red),
            _MetricCard(label: 'Completed lessons', value: '${progress.completedCount()}', icon: Icons.school_rounded, color: AppColors.blue),
            _MetricCard(label: 'Practice attempts', value: '${summary.totalAttempts}', icon: Icons.edit_note_rounded, color: AppColors.purple),
          ]),
          const SizedBox(height: 22),
          _SectionCard(title: 'Practice performance', child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(summary.totalAttempts == 0 ? 'No scored practice attempts have been saved yet.' : 'Average recorded exercise score', style: const TextStyle(color: AppColors.muted)),
            const SizedBox(height: 8),
            Text(summary.totalAttempts == 0 ? '—' : '${summary.averageScore.round()}%', style: const TextStyle(fontSize: 34, fontWeight: FontWeight.w900, color: AppColors.greenDark)),
            if (summary.totalAttempts > 0) ...[
              ClipRRect(borderRadius: BorderRadius.circular(8), child: LinearProgressIndicator(value: (summary.averageScore / 100).clamp(0.0, 1.0), minHeight: 10, color: AppColors.green, backgroundColor: AppColors.line)),
              const SizedBox(height: 8),
            ],
            const Text('Speaking scores compare recognized words with target text; they are not acoustic pronunciation measurements.', style: TextStyle(fontSize: 12, color: AppColors.muted)),
          ])),
          const SizedBox(height: 14),
          _SectionCard(title: 'Focus areas', child: summary.weakPrompts.isEmpty ? const Text('No weak prompts identified yet. Keep practicing to build a useful history.', style: TextStyle(color: AppColors.muted)) : Wrap(spacing: 8, runSpacing: 8, children: summary.weakPrompts.take(12).map((p) => Chip(avatar: const Icon(Icons.refresh_rounded, size: 16), label: Text(p))).toList())),
          const SizedBox(height: 14),
          _SectionCard(title: 'Recent activity', child: summary.recentAttempts.isEmpty ? const Text('Your saved practice attempts will appear here.', style: TextStyle(color: AppColors.muted)) : Column(children: summary.recentAttempts.map((a) => ListTile(contentPadding: EdgeInsets.zero, title: Text(a.prompt.isEmpty ? a.lessonId : a.prompt, maxLines: 2, overflow: TextOverflow.ellipsis), subtitle: Text('${a.exerciseType} · ${a.createdAt.toLocal()}', style: const TextStyle(fontSize: 11)), trailing: Text('${a.score}%', style: TextStyle(fontWeight: FontWeight.w900, color: a.score >= 70 ? AppColors.greenDark : AppColors.orange)))).toList())),
        ],
      ),
    );
  }
}

class _MetricCard extends StatelessWidget {
  const _MetricCard({required this.label, required this.value, required this.icon, required this.color});
  final String label, value; final IconData icon; final Color color;
  @override
  Widget build(BuildContext context) => Container(padding: const EdgeInsets.all(14), decoration: BoxDecoration(borderRadius: BorderRadius.circular(18), border: Border.all(color: AppColors.line, width: 1.5)), child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Icon(icon, color: color), Text(value, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w900)), Text(label, style: const TextStyle(fontSize: 12, color: AppColors.muted))]));
}

class _SectionCard extends StatelessWidget {
  const _SectionCard({required this.title, required this.child});
  final String title; final Widget child;
  @override
  Widget build(BuildContext context) => Container(padding: const EdgeInsets.all(16), decoration: BoxDecoration(border: Border.all(color: AppColors.line, width: 1.5), borderRadius: BorderRadius.circular(20)), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(title, style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w900)), const SizedBox(height: 12), child]));
}
