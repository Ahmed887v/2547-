import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'screens/home_screen.dart';
import 'services/learning_memory_service.dart';
import 'services/progress_service.dart';
import 'theme/app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  // Load existing lesson progress without changing its stored data.
  final progress = ProgressService();
  await progress.load();

  // Load vocabulary and correction memory separately from lesson progress.
  final learningMemory = LearningMemoryService();
  await learningMemory.load();

  runApp(
    SpeakLocalApp(
      progress: progress,
      learningMemory: learningMemory,
    ),
  );
}

class SpeakLocalApp extends StatelessWidget {
  final ProgressService progress;
  final LearningMemoryService learningMemory;

  const SpeakLocalApp({
    super.key,
    required this.progress,
    required this.learningMemory,
  });

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ProgressService>.value(value: progress),
        ChangeNotifierProvider<LearningMemoryService>.value(
          value: learningMemory,
        ),
      ],
      child: MaterialApp(
        title: 'SpeakLocal',
        debugShowCheckedModeBanner: false,
        theme: buildAppTheme(),
        home: const HomeScreen(),
      ),
    );
  }
}
