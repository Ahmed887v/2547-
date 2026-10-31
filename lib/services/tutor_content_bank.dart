import 'package:flutter/services.dart';

import '../models/tutor_content_item.dart';

/// Loads the original Markdown banks as bundled offline assets.
/// Repeated contextual variants are deduplicated by normalized headword.
class TutorContentBank {
  static const vocabularyAsset = 'assets/content/1000_english_words.md';
  static const expressionsAsset = 'assets/content/1000_american_slang_expressions.md';

  List<TutorContentItem> _items = [];
  bool _loaded = false;

  bool get isLoaded => _loaded;
  List<TutorContentItem> get all => List.unmodifiable(_items);
  List<TutorContentItem> get vocabulary =>
      _items.where((e) => e.kind == TutorContentKind.vocabulary).toList(growable: false);
  List<TutorContentItem> get expressions =>
      _items.where((e) => e.kind == TutorContentKind.expression).toList(growable: false);

  Future<void> load() async {
    if (_loaded) return;
    final vocabText = await rootBundle.loadString(vocabularyAsset);
    final expressionText = await rootBundle.loadString(expressionsAsset);
    final parsed = <TutorContentItem>[
      ..._parse(vocabText, TutorContentKind.vocabulary),
      ..._parse(expressionText, TutorContentKind.expression),
    ];
    final unique = <String, TutorContentItem>{};
    for (final item in parsed) {
      unique.putIfAbsent('${item.kind.name}:${item.normalizedPrompt}', () => item);
    }
    _items = unique.values.toList(growable: false);
    if (_items.isEmpty) {
      throw const FormatException('The Smart Tutor content banks contain no valid entries.');
    }
    _loaded = true;
  }

  List<TutorContentItem> _parse(String source, TutorContentKind kind) {
    final result = <TutorContentItem>[];
    final blocks = source.split(RegExp(r'(?=^### Entry\s+\d+:)', multiLine: true));
    for (final block in blocks) {
      if (!block.startsWith('### Entry')) continue;
      String field(String label) {
        final match = RegExp(
          r'^- \*\*' + RegExp.escape(label) + r':\*\*\s*(.*)$',
          multiLine: true,
        ).firstMatch(block);
        return match?.group(1)?.trim() ?? '';
      }

      final prompt = field(kind == TutorContentKind.vocabulary ? 'Word' : 'Expression');
      if (prompt.isEmpty) continue;
      final meaning = field(kind == TutorContentKind.vocabulary
          ? 'English Definition'
          : 'English Meaning');
      final arabic = field('Arabic Definition').isNotEmpty
          ? field('Arabic Definition')
          : field('Arabic Meaning');
      final example = field(kind == TutorContentKind.vocabulary
          ? 'English Example'
          : 'Example Sentence');
      final pronunciation = field('Phonetic Pronunciation');
      final cleanPrompt = prompt.replaceFirst(RegExp(r'\s*\([^)]*\)$'), '').trim();
      if (cleanPrompt.isEmpty || meaning.isEmpty) continue;
      final normalized = cleanPrompt.toLowerCase().replaceAll(RegExp(r'\s+'), ' ');
      result.add(TutorContentItem(
        id: '${kind.name}_${normalized.hashCode.toUnsigned(32).toRadixString(16)}',
        kind: kind,
        prompt: cleanPrompt,
        meaning: meaning,
        arabicMeaning: arabic,
        example: example.replaceAll(RegExp(r'^["“]|["”]$'), ''),
        pronunciation: pronunciation,
        source: kind == TutorContentKind.vocabulary ? vocabularyAsset : expressionsAsset,
      ));
    }
    return result;
  }
}
