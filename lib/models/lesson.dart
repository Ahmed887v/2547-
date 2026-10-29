enum ExerciseType { listenRepeat, speakPrompt, chooseAndSay }

class Phrase {
  final String text;
  final String meaningAr;
  final String tip;

  const Phrase({
    required this.text,
    required this.meaningAr,
    this.tip = '',
  });
}

class Exercise {
  final ExerciseType type;
  final Phrase phrase;
  final List<String>? choices;

  const Exercise({
    required this.type,
    required this.phrase,
    this.choices,
  });
}

class Lesson {
  final String id;
  final String title;
  final String subtitle;
  final String emoji;
  final ColorSeed color;
  final int xpReward;
  final List<Exercise> exercises;
  final bool lockedByDefault;

  const Lesson({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.emoji,
    required this.color,
    required this.xpReward,
    required this.exercises,
    this.lockedByDefault = false,
  });
}

enum ColorSeed {
  green(0xFF58CC02),
  blue(0xFF1CB0F6),
  orange(0xFFFF9600),
  purple(0xFFCE82FF),
  yellow(0xFFFFC800);

  const ColorSeed(this.argb);
  final int argb;
}

class Unit {
  final String id;
  final String title;
  final String description;
  final List<Lesson> lessons;

  const Unit({
    required this.id,
    required this.title,
    required this.description,
    required this.lessons,
  });
}
