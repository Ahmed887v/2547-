/// Normalized content item used by every Smart Tutor activity.
enum TutorContentKind { vocabulary, expression }

class TutorContentItem {
  final String id;
  final TutorContentKind kind;
  final String prompt;
  final String meaning;
  final String arabicMeaning;
  final String example;
  final String pronunciation;
  final String source;

  const TutorContentItem({
    required this.id,
    required this.kind,
    required this.prompt,
    required this.meaning,
    required this.arabicMeaning,
    required this.example,
    this.pronunciation = '',
    this.source = '',
  });

  String get normalizedPrompt => prompt.toLowerCase().trim().replaceAll(RegExp(r'\\s+'), ' ');
}
