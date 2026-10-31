import 'dart:math';

import '../models/tutor_content_item.dart';
import 'tutor_content_bank.dart';
import 'tutor_learner_profile.dart';

enum TutorSessionReason { dueReview, weakSkill, newMaterial, reinforcement }

/// Selects learning material using due reviews, observed weakness and exposure.
class SmartTutorEngine {
  final TutorContentBank bank;
  final TutorLearnerProfile profile;
  final Random _random;

  SmartTutorEngine({
    required this.bank,
    required this.profile,
    Random? random,
  }) : _random = random ?? Random();

  TutorContentItem? nextItem({Set<String> exclude = const {}}) {
    if (bank.all.isEmpty) return null;
    final available = bank.all.where((item) => !exclude.contains(item.id)).toList();
    final pool = available.isEmpty ? bank.all : available;
    final due = profile.dueItemIds().toSet();
    final weak = profile.weakItemIds.toSet();

    final dueItems = pool.where((item) => due.contains(item.id)).toList();
    if (dueItems.isNotEmpty) return _pick(dueItems);

    final weakItems = pool.where((item) => weak.contains(item.id)).toList();
    if (weakItems.isNotEmpty) return _pick(weakItems);

    final unseen = pool.where((item) => profile.progressFor(item.id).attempts == 0).toList();
    if (unseen.isNotEmpty) return _pick(unseen);

    // Reinforce the least accurate and oldest items when the bank has been seen.
    pool.sort((a, b) {
      final pa = profile.progressFor(a.id);
      final pb = profile.progressFor(b.id);
      final accuracy = pa.accuracy.compareTo(pb.accuracy);
      if (accuracy != 0) return accuracy;
      return (pa.lastPracticedAt ?? DateTime.fromMillisecondsSinceEpoch(0))
          .compareTo(pb.lastPracticedAt ?? DateTime.fromMillisecondsSinceEpoch(0));
    });
    final candidateCount = min(5, pool.length);
    return _pick(pool.take(candidateCount).toList());
  }

  TutorSessionReason reasonFor(TutorContentItem item) {
    final progress = profile.progressFor(item.id);
    if (progress.nextReviewAt != null &&
        !progress.nextReviewAt!.isAfter(DateTime.now())) {
      return TutorSessionReason.dueReview;
    }
    if (progress.attempts > 0 && progress.accuracy < .65) {
      return TutorSessionReason.weakSkill;
    }
    if (progress.attempts == 0) return TutorSessionReason.newMaterial;
    return TutorSessionReason.reinforcement;
  }

  TutorContentItem _pick(List<TutorContentItem> items) =>
      items[_random.nextInt(items.length)];
}
