// Offline adaptive placement test for SpeakLocal.
//
// This is a lightweight estimate based on a short, local multiple-choice sample.
// It is not an official CEFR assessment and does not replace a full proficiency test.

enum PlacementLevel {
  beginner,
  elementary,
  preIntermediate,
  intermediate,
  upperIntermediate,
}

class PlacementQuestion {
  const PlacementQuestion({
    required this.id,
    required this.prompt,
    required this.choices,
    required this.correctIndex,
    required this.level,
    required this.explanation,
  });

  final String id;
  final String prompt;
  final List<String> choices;
  final int correctIndex;
  final int level;
  final String explanation;
}

class PlacementResult {
  const PlacementResult({
    required this.answered,
    required this.correct,
    required this.accuracy,
    required this.estimatedLevel,
    required this.label,
    required this.recommendation,
  });

  final int answered;
  final int correct;
  final double accuracy;
  final int estimatedLevel;
  final String label;
  final String recommendation;
}

/// Selects questions near the learner's current estimated difficulty.
/// Correct answers move the next question up; incorrect answers move it down.
class PlacementTestService {
  PlacementTestService({List<PlacementQuestion>? questions})
      : questions = List.unmodifiable(questions ?? defaultQuestions);

  final List<PlacementQuestion> questions;
  final Set<String> _usedIds = {};
  int _difficulty = 1;
  int _correct = 0;
  int _answered = 0;

  int get answered => _answered;
  int get correct => _correct;
  int get currentDifficulty => _difficulty;
  bool get isComplete => _usedIds.length >= questions.length;

  PlacementQuestion? get nextQuestion {
    if (isComplete) return null;
    final available = questions.where((q) => !_usedIds.contains(q.id)).toList()
      ..sort((a, b) {
        final aDistance = (a.level - _difficulty).abs();
        final bDistance = (b.level - _difficulty).abs();
        if (aDistance != bDistance) return aDistance.compareTo(bDistance);
        return a.level.compareTo(b.level);
      });
    return available.first;
  }

  /// Records an answer and adapts difficulty for the next question.
  /// Returns false if the question is unknown or was already answered.
  bool answer(String questionId, int selectedIndex) {
    final question = questions.cast<PlacementQuestion?>().firstWhere(
      (q) => q?.id == questionId,
      orElse: () => null,
    );
    if (question == null ||
        _usedIds.contains(questionId) ||
        selectedIndex < 0 ||
        selectedIndex >= question.choices.length) {
      return false;
    }

    _usedIds.add(questionId);
    _answered++;
    final wasCorrect = selectedIndex == question.correctIndex;
    if (wasCorrect) {
      _correct++;
      _difficulty = (_difficulty + 1).clamp(1, 5);
    } else {
      _difficulty = (_difficulty - 1).clamp(1, 5);
    }
    return wasCorrect;
  }

  PlacementResult get result {
    final accuracy = _answered == 0 ? 0.0 : _correct / _answered;
    final estimated = _answered == 0
        ? 1
        : ((_difficulty + ((_correct / _answered) >= 0.75 ? 1 : 0))
            .clamp(1, 5));
    const labels = {
      1: 'Beginner',
      2: 'Elementary',
      3: 'Pre-intermediate',
      4: 'Intermediate',
      5: 'Upper-intermediate',
    };
    const recommendations = {
      1: 'Start with greetings, everyday words, and short sentence patterns.',
      2: 'Build everyday vocabulary and practise simple present and past forms.',
      3: 'Practise longer sentences, common conversations, and useful expressions.',
      4: 'Focus on fluent responses, precise grammar, and listening comprehension.',
      5: 'Practise nuanced vocabulary, natural expressions, and extended speaking.',
    };
    return PlacementResult(
      answered: _answered,
      correct: _correct,
      accuracy: accuracy,
      estimatedLevel: estimated,
      label: labels[estimated]!,
      recommendation: recommendations[estimated]!,
    );
  }

  void reset() {
    _usedIds.clear();
    _difficulty = 1;
    _correct = 0;
    _answered = 0;
  }

  static const List<PlacementQuestion> defaultQuestions = [
    PlacementQuestion(id: 'p1', prompt: 'Choose the correct greeting.', choices: ['Good morning', 'Goodly morning', 'Morning goodly', 'Well morning'], correctIndex: 0, level: 1, explanation: '“Good morning” is the standard greeting.'),
    PlacementQuestion(id: 'p2', prompt: 'Complete: “She ___ coffee every day.”', choices: ['drink', 'drinks', 'drinking', 'drank'], correctIndex: 1, level: 1, explanation: 'Use -s with a third-person singular subject in the present simple.'),
    PlacementQuestion(id: 'p3', prompt: 'What is the past tense of “go”?', choices: ['goed', 'gone', 'went', 'going'], correctIndex: 2, level: 1, explanation: '“Went” is the simple past form of “go”.'),
    PlacementQuestion(id: 'p4', prompt: 'Complete: “I have lived here ___ 2020.”', choices: ['for', 'since', 'during', 'from'], correctIndex: 1, level: 2, explanation: 'Use “since” with a starting point in time.'),
    PlacementQuestion(id: 'p5', prompt: 'Choose the natural sentence.', choices: ['I am agree with you.', 'I agree with you.', 'I agreeing with you.', 'I do agree you.'], correctIndex: 1, level: 2, explanation: '“Agree” is a verb and does not need “am” here.'),
    PlacementQuestion(id: 'p6', prompt: '“Although it was raining, ___.”', choices: ['but we went out', 'we went out', 'because we went out', 'so although we went out'], correctIndex: 1, level: 3, explanation: '“Although” already introduces the contrast; do not add “but” in this structure.'),
    PlacementQuestion(id: 'p7', prompt: 'Choose the closest meaning of “reluctant”.', choices: ['eager', 'unwilling', 'certain', 'careless'], correctIndex: 1, level: 3, explanation: '“Reluctant” means hesitant or unwilling.'),
    PlacementQuestion(id: 'p8', prompt: 'Complete: “If I ___ about the delay, I would have called.”', choices: ['knew', 'had known', 'would know', 'have known'], correctIndex: 1, level: 4, explanation: 'A past unreal condition commonly uses “if + past perfect”.'),
    PlacementQuestion(id: 'p9', prompt: 'Choose the best completion: “The proposal was rejected, ___ surprised nobody.”', choices: ['that', 'what', 'which', 'who'], correctIndex: 2, level: 4, explanation: '“Which” can refer back to the entire preceding clause.'),
    PlacementQuestion(id: 'p10', prompt: '“Her explanation was cogent.” What does “cogent” mean?', choices: ['persuasive and logical', 'brief but unclear', 'emotionally detached', 'deliberately misleading'], correctIndex: 0, level: 5, explanation: 'A cogent argument is clear, logical, and convincing.'),
  ];
}
