// SpeakLocal: local vocabulary and correction review.
// All review data is stored by LearningMemoryService on this device.

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/learning_memory_service.dart';
import '../services/practice_analytics_service.dart';
import '../theme/app_theme.dart';
import '../widgets/stat_chip.dart';

class ReviewScreen extends StatefulWidget {
  const ReviewScreen({super.key});

  @override
  State<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  // Load saved practice analytics once when the review screen is created.
  late final PracticeAnalyticsService _analytics;
  late final Future<void> _analyticsFuture;

  @override
  void initState() {
    super.initState();
    _analytics = PracticeAnalyticsService();
    _analytics.addListener(_onAnalyticsChanged);
    _analyticsFuture = _analytics.load();
  }

  void _onAnalyticsChanged() {
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    _analytics.removeListener(_onAnalyticsChanged);
    _analytics.dispose();
    super.dispose();
  }

  // 0 = all items, 1 = vocabulary, 2 = corrections.
  int _filter = 0;
  int _index = 0;
  bool _revealed = false;

  // Hide successfully reviewed cards for this screen session only.
  // The vocabulary remains saved and can return when it is due again.
  final Set<String> _reviewedThisSession = <String>{};

  // Rank weak practice phrases first without changing saved review dates.
  List<LearningMemoryItem> _filteredItems(
    LearningMemoryService memory,
  ) {
    final weakPrompts = _analytics.summary.weakPrompts
        .map((prompt) => prompt.trim().toLowerCase())
        .where((prompt) => prompt.isNotEmpty)
        .toSet();

    bool isWeak(LearningMemoryItem item) {
      final original = item.original.trim().toLowerCase();
      final corrected = item.corrected.trim().toLowerCase();
      return weakPrompts.contains(original) || weakPrompts.contains(corrected);
    }

    final now = DateTime.now();
    final items = memory.items
        .where((item) => !_reviewedThisSession.contains(item.id))
        .where((item) {
      if (_filter == 1) {
        return item.kind == LearningMemoryKind.vocabulary;
      }
      if (_filter == 2) {
        return item.kind == LearningMemoryKind.correction;
      }
      return true;
    }).toList();

    // Sort by: overdue first, weak practice matches next, then oldest due date.
    items.sort((a, b) {
      final aDue = !a.nextReviewAt.isAfter(now);
      final bDue = !b.nextReviewAt.isAfter(now);

      if (aDue != bDue) return aDue ? -1 : 1;

      final aWeak = isWeak(a);
      final bWeak = isWeak(b);
      if (aWeak != bWeak) return aWeak ? -1 : 1;

      if (aDue && bDue) {
        return a.nextReviewAt.compareTo(b.nextReviewAt);
      }

      return b.createdAt.compareTo(a.createdAt);
    });

    return items;
  }

  Future<void> _review(
    LearningMemoryService memory,
    LearningMemoryItem item,
    int quality,
  ) async {
    // A due item moves behind the remaining due items after review.
    // Keep the index in place so the next due item is not skipped.
    final wasDue = !item.nextReviewAt.isAfter(DateTime.now());

    await memory.markReviewed(itemId: item.id, quality: quality);

    if (!mounted) return;

    setState(() {
      if (quality >= 3) {
        _reviewedThisSession.add(item.id);
      } else if (!wasDue) {
        _index++;
      }
      _revealed = false;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          quality < 3
              ? 'Saved. This item will return for review soon.'
              : 'Review saved. Keep up the good work!',
        ),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final memory = context.watch<LearningMemoryService>();
    final items = _filteredItems(memory);
    final dueCount = memory.dueItems.length;

    // Keep the selected index valid when items or filters change.
    final safeIndex = items.isEmpty ? 0 : _index % items.length;
    final item = items.isEmpty ? null : items[safeIndex];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Learning review',
          style: TextStyle(fontWeight: FontWeight.w900),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 28),
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFFE7F8EE), Color(0xFFD3F0E0)],
              ),
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: AppColors.green.withOpacity(0.35)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Little steps, lasting progress',
                  style: TextStyle(
                    fontSize: 21,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Practise saved words and corrections. '
                  'Your review history stays on this device.',
                  style: TextStyle(height: 1.4, color: AppColors.ink),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: StatChip(
                        icon: Icons.library_books_rounded,
                        value: '${memory.items.length} saved',
                        color: AppColors.greenDark,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: StatChip(
                        icon: Icons.schedule_rounded,
                        value: '$dueCount due',
                        color: AppColors.orange,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 22),

          // Practice analytics are shown separately from saved vocabulary.
          FutureBuilder<void>(
            future: _analyticsFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState != ConnectionState.done) {
                return const Card(
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: LinearProgressIndicator(),
                  ),
                );
              }

              final summary = _analytics.summary;
              return Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: const Color(0xFFF0F4FF),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: AppColors.line),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Icon(Icons.insights_rounded,
                            color: AppColors.greenDark),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            'Practice insights',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),
                    Row(
                      children: [
                        Expanded(
                          child: _analyticsMetric(
                            'Attempts',
                            '${summary.totalAttempts}',
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: _analyticsMetric(
                            'Average score',
                            summary.totalAttempts == 0
                                ? '—'
                                : '${summary.averageScore.round()}%',
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),
                    const Text(
                      'Phrases to practise',
                      style: TextStyle(fontWeight: FontWeight.w800),
                    ),
                    const SizedBox(height: 6),
                    if (summary.weakPrompts.isEmpty)
                      Text(
                        summary.totalAttempts == 0
                            ? 'Complete a practice exercise to start building your insights.'
                            : 'No weak phrases detected yet. Keep practising!',
                        style: const TextStyle(
                          color: AppColors.muted,
                          height: 1.4,
                        ),
                      )
                    else
                      ...summary.weakPrompts.take(5).map(
                            (prompt) => Padding(
                              padding: const EdgeInsets.only(top: 6),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Icon(
                                    Icons.replay_rounded,
                                    size: 18,
                                    color: AppColors.orange,
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(child: Text(prompt)),
                                ],
                              ),
                            ),
                          ),
                  ],
                ),
              );
            },
          ),
          const SizedBox(height: 22),
          const Text(
            'Choose a collection',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _filterChip('All', 0),
              _filterChip('Vocabulary', 1),
              _filterChip('Corrections', 2),
            ],
          ),
          const SizedBox(height: 20),
          if (item == null)
            _emptyState(memory)
          else ...[
            Text(
              'CARD ${(safeIndex + 1)} OF ${items.length}',
              style: const TextStyle(
                color: AppColors.muted,
                fontWeight: FontWeight.w800,
                letterSpacing: 1,
              ),
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(22),
                border: Border.all(color: AppColors.line),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x10000000),
                    blurRadius: 12,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        item.kind == LearningMemoryKind.vocabulary
                            ? Icons.translate_rounded
                            : Icons.edit_note_rounded,
                        color: AppColors.greenDark,
                        size: 25,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        item.kind == LearningMemoryKind.vocabulary
                            ? 'VOCABULARY'
                            : 'CORRECTION',
                        style: const TextStyle(
                          color: AppColors.muted,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 1,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 18),
                  const Text(
                    'Try to remember:',
                    style: TextStyle(color: AppColors.muted),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    item.kind == LearningMemoryKind.vocabulary
                        ? item.original
                        : item.original,
                    style: const TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    item.kind == LearningMemoryKind.vocabulary
                        ? 'What does this word mean?'
                        : 'How would you say this correctly?',
                    style: const TextStyle(
                      color: AppColors.muted,
                      fontSize: 15,
                    ),
                  ),
                  if (_revealed) ...[
                    const Divider(height: 30),
                    const Text(
                      'ANSWER',
                      style: TextStyle(
                        color: AppColors.greenDark,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 1,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      item.kind == LearningMemoryKind.vocabulary
                          ? (item.explanation.isNotEmpty
                              ? item.explanation
                              : item.corrected)
                          : item.corrected,
                      style: const TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    if (item.explanation.isNotEmpty &&
                        item.kind == LearningMemoryKind.correction) ...[
                      const SizedBox(height: 10),
                      Text(
                        item.explanation,
                        style: const TextStyle(
                          height: 1.45,
                          color: AppColors.muted,
                        ),
                      ),
                    ],
                    if (item.example.isNotEmpty) ...[
                      const SizedBox(height: 14),
                      const Text(
                        'Example',
                        style: TextStyle(fontWeight: FontWeight.w900),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        item.example,
                        style: const TextStyle(
                          height: 1.4,
                          color: AppColors.muted,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                    const SizedBox(height: 16),
                    const Text(
                      'How well did you remember?',
                      style: TextStyle(fontWeight: FontWeight.w800),
                    ),
                    const SizedBox(height: 12),
                    SoftButton(
                      label: 'Need more practice',
                      icon: Icons.refresh_rounded,
                      color: AppColors.red,
                      dark: const Color(0xFFD13333),
                      onPressed: () => _review(memory, item, 1),
                    ),
                    const SizedBox(height: 10),
                    SoftButton(
                      label: 'Remembered',
                      icon: Icons.check_circle_outline_rounded,
                      onPressed: () => _review(memory, item, 3),
                    ),
                    const SizedBox(height: 10),
                    SoftButton(
                      label: 'Easy',
                      icon: Icons.bolt_rounded,
                      color: AppColors.yellow,
                      dark: AppColors.orange,
                      onPressed: () => _review(memory, item, 5),
                    ),
                  ] else ...[
                    const SizedBox(height: 22),
                    SoftButton(
                      label: 'Reveal answer',
                      icon: Icons.visibility_rounded,
                      onPressed: () => setState(() => _revealed = true),
                    ),
                  ],
                ],
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'Seen ${item.occurrences} time(s) · '
              'Successful uses: ${item.successfulUses}',
              textAlign: TextAlign.center,
              style: const TextStyle(color: AppColors.muted),
            ),
            const SizedBox(height: 14),
            TextButton.icon(
              onPressed: () => setState(() {
                _index = (_index + 1) % items.length;
                _revealed = false;
              }),
              icon: const Icon(Icons.skip_next_rounded),
              label: const Text('Skip for now'),
            ),
          ],
        ],
      ),
    );
  }

  Widget _filterChip(String label, int value) {
    final selected = _filter == value;

    return ChoiceChip(
      label: Text(label),
      selected: selected,
      onSelected: (_) => setState(() {
        _filter = value;
        _index = 0;
        _revealed = false;
      }),
    );
  }

  Widget _emptyState(LearningMemoryService memory) {
    final onlyWords = _filter == 1;
    final onlyCorrections = _filter == 2;

    final title = onlyWords
        ? 'No saved vocabulary yet'
        : onlyCorrections
            ? 'No saved corrections yet'
            : 'Your review deck is ready';

    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: AppColors.line),
      ),
      child: Column(
        children: [
          const Icon(
            Icons.auto_stories_rounded,
            size: 48,
            color: AppColors.greenDark,
          ),
          const SizedBox(height: 12),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            memory.items.isEmpty
                ? 'Saved words and corrections will appear here. '
                    'The current lessons do not automatically populate '
                    'this collection yet.'
                : 'Try another collection to see your saved learning items.',
            textAlign: TextAlign.center,
            style: const TextStyle(
              height: 1.45,
              color: AppColors.muted,
            ),
          ),
          if (memory.items.isEmpty) ...[
            const SizedBox(height: 16),
            const Text(
              'Your existing lesson progress is separate and has not been reset.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 12, color: AppColors.muted),
            ),
          ],
        ],
      ),
    );
  }

  Widget _analyticsMetric(String label, String value) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            value,
            style: const TextStyle(
              fontSize: 23,
              fontWeight: FontWeight.w900,
              color: AppColors.greenDark,
            ),
          ),
          const SizedBox(height: 3),
          Text(
            label,
            style: const TextStyle(
              color: AppColors.muted,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
