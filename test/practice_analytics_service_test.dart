import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:speak_english/services/practice_analytics_service.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  test('starts with an empty, zero-score summary', () async {
    final service = PracticeAnalyticsService();
    await service.load();

    expect(service.summary.totalAttempts, 0);
    expect(service.summary.averageScore, 0);
    expect(service.summary.weakPrompts, isEmpty);
  });

  test('persists attempts and reloads them in newest-first order', () async {
    final service = PracticeAnalyticsService();
    await service.load();

    await service.recordAttempt(
      lessonId: 'lesson-1',
      prompt: 'First phrase',
      target: 'Hello there',
      score: 80,
      exerciseType: 'speakPrompt',
      createdAt: DateTime.utc(2026, 1, 1),
    );
    await service.recordAttempt(
      lessonId: 'lesson-1',
      prompt: 'Second phrase',
      target: 'How are you?',
      score: 40,
      exerciseType: 'listenRepeat',
      createdAt: DateTime.utc(2026, 1, 2),
    );

    final reloaded = PracticeAnalyticsService();
    await reloaded.load();

    expect(reloaded.attempts, hasLength(2));
    expect(reloaded.attempts.first.prompt, 'Second phrase');
    expect(reloaded.attempts.last.prompt, 'First phrase');
    expect(reloaded.summary.totalAttempts, 2);
    expect(reloaded.summary.averageScore, 60);
    expect(reloaded.summary.weakPrompts, contains('second phrase'));
  });

  test('clamps scores to the supported 0–100 range', () async {
    final service = PracticeAnalyticsService();
    await service.recordAttempt(
      lessonId: 'lesson-2',
      prompt: 'A phrase',
      target: 'A target',
      score: 150,
      exerciseType: 'chooseAndSay',
    );

    expect(service.attempts.single.score, 100);
  });

  test('keeps analytics in a separate preference key', () async {
    SharedPreferences.setMockInitialValues({
      'speaklocal_progress_v1': '{"xp":123}',
      'speaklocal_learning_memory_v1': '[{"id":"existing"}]',
    });

    final service = PracticeAnalyticsService();
    await service.recordAttempt(
      lessonId: 'lesson-3',
      prompt: 'Test',
      target: 'Testing',
      score: 90,
      exerciseType: 'speakPrompt',
    );

    final prefs = await SharedPreferences.getInstance();
    expect(prefs.getString('speaklocal_progress_v1'), '{"xp":123}');
    expect(
      prefs.getString('speaklocal_learning_memory_v1'),
      '[{"id":"existing"}]',
    );
    expect(prefs.containsKey(PracticeAnalyticsService.storageKey), isTrue);
  });
}
