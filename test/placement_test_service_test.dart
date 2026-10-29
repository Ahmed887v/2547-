import 'package:flutter_test/flutter_test.dart';
import 'package:speak_english/services/placement_test_service.dart';

void main() {
  group('PlacementTestService', () {
    test('starts at beginner difficulty and selects a question', () {
      final service = PlacementTestService();

      expect(service.currentDifficulty, 1);
      expect(service.answered, 0);
      expect(service.nextQuestion, isNotNull);
    });

    test('correct answers increase difficulty without exceeding five', () {
      final service = PlacementTestService();
      for (var i = 0; i < 8; i++) {
        final question = service.nextQuestion!;
        service.answer(question.id, question.correctIndex);
      }

      expect(service.currentDifficulty, 5);
      expect(service.correct, 8);
    });

    test('incorrect answers decrease difficulty without going below one', () {
      final service = PlacementTestService();
      final question = service.nextQuestion!;
      service.answer(question.id, (question.correctIndex + 1) % question.choices.length);

      expect(service.currentDifficulty, 1);
      expect(service.correct, 0);
      expect(service.answered, 1);
    });

    test('does not count a question twice or accept an invalid choice', () {
      final service = PlacementTestService();
      final question = service.nextQuestion!;

      expect(service.answer(question.id, question.correctIndex), isTrue);
      expect(service.answer(question.id, question.correctIndex), isFalse);
      expect(service.answer('missing', 0), isFalse);
      expect(service.answered, 1);
    });

    test('returns a bounded estimate and actionable recommendation', () {
      final service = PlacementTestService();
      final question = service.nextQuestion!;
      service.answer(question.id, question.correctIndex);
      final result = service.result;

      expect(result.answered, 1);
      expect(result.correct, 1);
      expect(result.accuracy, 1);
      expect(result.estimatedLevel, inInclusiveRange(1, 5));
      expect(result.recommendation, isNotEmpty);
    });

    test('reset clears answers and restores starting difficulty', () {
      final service = PlacementTestService();
      final question = service.nextQuestion!;
      service.answer(question.id, question.correctIndex);
      service.reset();

      expect(service.answered, 0);
      expect(service.correct, 0);
      expect(service.currentDifficulty, 1);
      expect(service.isComplete, isFalse);
    });
  });
}
