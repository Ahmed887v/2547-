import 'package:flutter/material.dart';

import '../services/placement_test_service.dart';
import '../theme/app_theme.dart';

/// Short, offline placement flow. Results are estimates, not official CEFR scores.
class PlacementTestScreen extends StatefulWidget {
  const PlacementTestScreen({super.key});

  @override
  State<PlacementTestScreen> createState() => _PlacementTestScreenState();
}

class _PlacementTestScreenState extends State<PlacementTestScreen> {
  late PlacementTestService _test;
  int? _selectedIndex;
  PlacementQuestion? _displayedQuestion;
  bool _finished = false;

  @override
  void initState() {
    super.initState();
    _test = PlacementTestService();
    _displayedQuestion = _test.nextQuestion;
  }

  void _answer(int index) {
    final question = _displayedQuestion;
    if (question == null || _selectedIndex != null) return;

    setState(() {
      _selectedIndex = index;
      _test.answer(question.id, index);
    });
  }

  void _continue() {
    setState(() {
      _selectedIndex = null;
      if (_test.isComplete || _test.nextQuestion == null) {
        _finished = true;
      } else {
        _displayedQuestion = _test.nextQuestion;
      }
    });
  }

  void _restart() {
    setState(() {
      _test.reset();
      _selectedIndex = null;
      _displayedQuestion = _test.nextQuestion;
      _finished = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final question = _displayedQuestion;
    final result = _test.result;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Find your level'),
        foregroundColor: AppColors.greenDark,
      ),
      body: SafeArea(
        child: _finished
            ? _resultView(result)
            : question == null
                ? _resultView(result)
                : ListView(
                    padding: const EdgeInsets.all(20),
                    children: [
                      const Text(
                        'ADAPTIVE PLACEMENT',
                        style: TextStyle(
                          color: AppColors.greenDark,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 1.1,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Question ${_test.answered + 1} of ${_test.questions.length}',
                        style: const TextStyle(color: AppColors.muted),
                      ),
                      const SizedBox(height: 10),
                      LinearProgressIndicator(
                        value: _test.answered / _test.questions.length,
                        color: AppColors.green,
                        backgroundColor: AppColors.line,
                      ),
                      const SizedBox(height: 28),
                      Text(
                        question.prompt,
                        style: const TextStyle(
                          fontSize: 23,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      const SizedBox(height: 18),
                      ...List.generate(question.choices.length, (index) {
                        final selected = _selectedIndex == index;
                        final answered = _selectedIndex != null;
                        final correct = index == question.correctIndex;
                        final color = !answered
                            ? AppColors.line
                            : correct
                                ? AppColors.green
                                : selected
                                    ? AppColors.red
                                    : AppColors.line;
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              alignment: Alignment.centerLeft,
                              padding: const EdgeInsets.all(16),
                              side: BorderSide(color: color, width: 1.5),
                            ),
                            onPressed: answered ? null : () => _answer(index),
                            child: Text(question.choices[index]),
                          ),
                        );
                      }),
                      if (_selectedIndex != null) ...[
                        const SizedBox(height: 8),
                        Text(
                          question.explanation,
                          style: const TextStyle(
                            color: AppColors.greenDark,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 16),
                        FilledButton(
                          onPressed: _continue,
                          child: Text(
                            _test.isComplete ? 'See my result' : 'Next question',
                          ),
                        ),
                      ],
                      const SizedBox(height: 18),
                      const Text(
                        'Your result is a quick offline estimate based on this question bank, not an official language certificate.',
                        style: TextStyle(color: AppColors.muted, fontSize: 12),
                      ),
                    ],
                  ),
      ),
    );
  }

  Widget _resultView(PlacementResult result) {
    return ListView(
      padding: const EdgeInsets.all(24),
      children: [
        const Icon(Icons.school_rounded, size: 58, color: AppColors.green),
        const SizedBox(height: 18),
        const Text(
          'Your estimated level',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
        ),
        const SizedBox(height: 8),
        Text(
          result.label,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 30,
            color: AppColors.greenDark,
            fontWeight: FontWeight.w900,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          '${result.correct} / ${result.answered} correct · ${(result.accuracy * 100).round()}%',
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 24),
        Text(result.recommendation, textAlign: TextAlign.center),
        const SizedBox(height: 24),
        FilledButton.icon(
          onPressed: _restart,
          icon: const Icon(Icons.refresh_rounded),
          label: const Text('Try again'),
        ),
        OutlinedButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Back to SpeakLocal'),
        ),
      ],
    );
  }
}
