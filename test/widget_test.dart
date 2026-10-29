import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:speak_english/main.dart';
import 'package:speak_english/services/learning_memory_service.dart';
import 'package:speak_english/services/progress_service.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('SpeakLocal loads home', (tester) async {
    // Use in-memory storage instead of a platform preferences plugin.
    SharedPreferences.setMockInitialValues({});

    final progress = ProgressService();
    await progress.load();

    final learningMemory = LearningMemoryService();
    await learningMemory.load();

    await tester.pumpWidget(
      SpeakLocalApp(
        progress: progress,
        learningMemory: learningMemory,
      ),
    );

    await tester.pump();

    expect(find.text('SpeakLocal'), findsOneWidget);
  });
}
