import 'package:flutter/material.dart';

/// Plain-text bold/italic markup for posts & comments — WhatsApp-style
/// `*bold*` / `_italic_` (and `*_bold italic_*` combined), stored as
/// perfectly ordinary characters. This is what makes it safe: there's no
/// special Unicode range involved (the earlier "fake bold via Unicode
/// look-alike characters" approach did use one, and that's exactly what
/// caused the font to fall back to a mismatched system font wherever it
/// rendered — asterisks and underscores exist in every font). Real
/// bold/italic is applied at render time via [toSpans], in whatever font
/// the surrounding text already uses.
///
/// This isn't general-purpose markdown — it only understands these two
/// delimiters, on purpose, since that's all the composer's B/I tool needs.
class ComposerMarkup {
  ComposerMarkup._();

  static final RegExp _pattern = RegExp(
    r'\*_(.+?)_\*|_\*(.+?)\*_|\*(.+?)\*|_(.+?)_',
    dotAll: true,
  );

  /// The parsed runs of [text] — plain and styled, in original-string
  /// order, covering the whole string. Backs both [toSpans] (rendering)
  /// and `ComposerEditorCubit`'s "what should B/I show as active" check.
  static List<StyleRun> parse(String text) {
    final runs = <StyleRun>[];
    var cursor = 0;
    for (final match in _pattern.allMatches(text)) {
      if (match.start > cursor) {
        runs.add(StyleRun(
          start: cursor,
          end: match.start,
          text: text.substring(cursor, match.start),
        ));
      }
      final bothA = match.group(1);
      final bothB = match.group(2);
      final boldOnly = match.group(3);
      final italicOnly = match.group(4);
      runs.add(StyleRun(
        start: match.start,
        end: match.end,
        text: bothA ?? bothB ?? boldOnly ?? italicOnly ?? '',
        bold: bothA != null || bothB != null || boldOnly != null,
        italic: bothA != null || bothB != null || italicOnly != null,
      ));
      cursor = match.end;
    }
    if (cursor < text.length) {
      runs.add(StyleRun(
        start: cursor,
        end: text.length,
        text: text.substring(cursor),
      ));
    }
    return runs;
  }

  /// Renders [text] as real bold/italic [TextSpan]s inheriting [baseStyle]
  /// (so the font stays whatever the caller was already using).
  static List<TextSpan> toSpans(String text, {TextStyle? baseStyle}) {
    if (text.isEmpty) return const [];
    return parse(text)
        .map((run) => TextSpan(
              text: run.text,
              style: (baseStyle ?? const TextStyle()).copyWith(
                fontWeight: run.bold ? FontWeight.bold : null,
                fontStyle: run.italic ? FontStyle.italic : null,
              ),
            ))
        .toList();
  }

  /// Whether [offset] (a cursor position, or a selection's start) falls
  /// inside a styled run — the delimiters themselves count as part of it,
  /// so landing right at the edge of a styled span still reads as active.
  static ({bool bold, bool italic}) styleAt(String text, int offset) {
    for (final run in parse(text)) {
      if (offset >= run.start && offset <= run.end) {
        return (bold: run.bold, italic: run.italic);
      }
    }
    return (bold: false, italic: false);
  }
}

class StyleRun {
  const StyleRun({
    required this.start,
    required this.end,
    required this.text,
    this.bold = false,
    this.italic = false,
  });

  /// Offsets into the original (still-delimited) source string.
  final int start;
  final int end;
  final String text;
  final bool bold;
  final bool italic;
}
