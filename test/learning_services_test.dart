import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:speak_english/services/learning_memory_service.dart';
import 'package:speak_english/services/progress_service.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  group('ProgressService', () {
    test('saves and restores lesson progress', () async {
      final first = ProgressService();
      await first.load();

      await first.addPracticeResult(
        lessonId: 'test_lesson',
        averageScore: 80,
        earnedXp: 25,
      );

      final restored = ProgressService();
      await restored.load();

      expect(restored.xp, 25);
      expect(restored.dailyXp, 25);
      expect(restored.hearts, 5);
      expect(restored.isCompleted('test_lesson'), isTrue);
      expect(restored.bestScores['test_lesson'], 80);
    });

    test('does not complete a lesson below the passing score', () async {
      final progress = ProgressService();
      await progress.load();

      await progress.addPracticeResult(
        lessonId: 'low_score_lesson',
        averageScore: 54,
        earnedXp: 10,
      );

      expect(progress.isCompleted('low_score_lesson'), isFalse);
      expect(progress.bestScores['low_score_lesson'], 54);
    });
  });

  group('LearningMemoryService', () {
    test('merges repeated vocabulary regardless of case and spacing', () async {
      final memory = LearningMemoryService();
      await memory.load();

      await memory.recordVocabulary(
        word: '  Good   morning ',
        translation: 'صباح الخير',
      );
      await memory.recordVocabulary(word: 'good morning');

      expect(memory.vocabulary, hasLength(1));
      expect(memory.vocabulary.single.occurrences, 2);
    });

    test('stores corrections separately from vocabulary', () async {
      final memory = LearningMemoryService();
      await memory.load();

      await memory.recordVocabulary(word: 'went');
      await memory.recordCorrection(
        original: 'I goed',
        corrected: 'I went',
      );

      expect(memory.vocabulary, hasLength(1));
      expect(memory.corrections, hasLength(1));
      expect(memory.items, hasLength(2));
    });

    test('reviewing an item schedules it for the future', () async {
      final memory = LearningMemoryService();
      await memory.load();
      await memory.recordVocabulary(word: 'carefully');

      final item = memory.vocabulary.single;
      expect(memory.dueItems.any((entry) => entry.id == item.id), isTrue);

      await memory.markReviewed(itemId: item.id, quality: 5);

      expect(memory.dueItems.any((entry) => entry.id == item.id), isFalse);
      expect(memory.vocabulary.single.reviewIntervalDays, 1);
      expect(memory.vocabulary.single.correctReviewStreak, 1);
    });

    test('restores saved learning memory after reload', () async {
      final first = LearningMemoryService();
      await first.load();
      await first.recordCorrection(
        original: 'She go',
        corrected: 'She goes',
      );

      final restored = LearningMemoryService();
      await restored.load();

      expect(restored.corrections, hasLength(1));
      expect(restored.corrections.single.original, 'She go');
      expect(restored.corrections.single.corrected, 'She goes');
    });
  });
}
