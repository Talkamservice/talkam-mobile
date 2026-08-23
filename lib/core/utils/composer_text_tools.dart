import 'package:flutter/material.dart';
import 'package:talkam/core/utils/composer_markup.dart';

/// Pure, controller-agnostic text transforms for the post/comment
/// composers' formatting tools. Nothing here touches a
/// [TextEditingController] directly — `ComposerEditorCubit` owns applying
/// these results back to the field exactly once per change, so there's a
/// single predictable write path instead of several call sites racing to
/// mutate the same controller.
///
/// Bold/italic write plain `*bold*`/`_italic_` markup (see
/// [ComposerMarkup]) — ordinary characters, styled for real only at
/// render time, so there's no font-fallback risk the way encoding style
/// into a special Unicode character range would have.
class ComposerTextTools {
  ComposerTextTools._();

  // ─── Bold / italic ──────────────────────────────────────────────────

  static TextEditingValue toggleBold(String text, TextSelection selection) =>
      _toggleWrap(text, selection, delimiter: '*');

  static TextEditingValue toggleItalic(String text, TextSelection selection) =>
      _toggleWrap(text, selection, delimiter: '_');

  /// What the B/I toggles should show as active for [selection] — whatever
  /// style run the selection's start (or the collapsed cursor) currently
  /// falls inside. See [ComposerMarkup.styleAt].
  static ({bool bold, bool italic}) activeStyleFor(
      String text, TextSelection selection) {
    if (!selection.isValid ||
        selection.start < 0 ||
        selection.start > text.length) {
      return (bold: false, italic: false);
    }
    return ComposerMarkup.styleAt(text, selection.start);
  }

  /// Wraps [selection] in [delimiter], or unwraps it if it's already
  /// exactly wrapped in that delimiter (a real toggle, not just add-only).
  /// With a collapsed cursor: inserts an empty pair and places the cursor
  /// between them, ready to type into; tapping again right there removes
  /// the still-empty pair instead of nesting another one.
  static TextEditingValue _toggleWrap(
    String text,
    TextSelection selection, {
    required String delimiter,
  }) {
    final dLen = delimiter.length;

    if (selection.isValid && !selection.isCollapsed) {
      final start = selection.start;
      final end = selection.end;
      final hasBefore =
          start - dLen >= 0 && text.substring(start - dLen, start) == delimiter;
      final hasAfter = end + dLen <= text.length &&
          text.substring(end, end + dLen) == delimiter;

      if (hasBefore && hasAfter) {
        final newText = text.substring(0, start - dLen) +
            text.substring(start, end) +
            text.substring(end + dLen);
        return TextEditingValue(
          text: newText,
          selection:
              TextSelection(baseOffset: start - dLen, extentOffset: end - dLen),
        );
      }

      final newText = text.substring(0, start) +
          delimiter +
          text.substring(start, end) +
          delimiter +
          text.substring(end);
      return TextEditingValue(
        text: newText,
        selection:
            TextSelection(baseOffset: start + dLen, extentOffset: end + dLen),
      );
    }

    final cursor = selection.isValid ? selection.start : text.length;
    final hasEmptyPairHere = cursor - dLen >= 0 &&
        cursor + dLen <= text.length &&
        text.substring(cursor - dLen, cursor) == delimiter &&
        text.substring(cursor, cursor + dLen) == delimiter;

    if (hasEmptyPairHere) {
      final newText =
          text.substring(0, cursor - dLen) + text.substring(cursor + dLen);
      return TextEditingValue(
        text: newText,
        selection: TextSelection.collapsed(offset: cursor - dLen),
      );
    }

    final newText = text.substring(0, cursor) +
        delimiter +
        delimiter +
        text.substring(cursor);
    return TextEditingValue(
      text: newText,
      selection: TextSelection.collapsed(offset: cursor + dLen),
    );
  }

  // ─── Bulleted lines ─────────────────────────────────────────────────

  static ({int start, int end}) _lineBlockRange(
      String text, int start, int end) {
    final searchFrom = start > 0 ? start - 1 : 0;
    final nlBefore = text.isEmpty ? -1 : text.lastIndexOf('\n', searchFrom);
    final blockStart = nlBefore == -1 ? 0 : nlBefore + 1;
    final nlAfter = text.indexOf('\n', end);
    final blockEnd = nlAfter == -1 ? text.length : nlAfter;
    return (start: blockStart, end: blockEnd);
  }

  static bool isCursorOnBulletedLine(String text, TextSelection selection) {
    if (!selection.isValid ||
        selection.start < 0 ||
        selection.start > text.length) {
      return false;
    }
    final range = _lineBlockRange(text, selection.start, selection.start);
    if (range.start > range.end || range.end > text.length) return false;
    return text.substring(range.start, range.end).startsWith('• ');
  }

  /// Toggles "• " on every line spanned by [selection] (or just the current
  /// line, if collapsed): bullets all of them if any aren't bulleted yet,
  /// un-bullets all of them if every one already is.
  static TextEditingValue toggleBullet(String text, TextSelection selection) {
    final start = selection.isValid ? selection.start : text.length;
    final end = selection.isValid ? selection.end : text.length;
    final range = _lineBlockRange(text, start, end);
    final block = text.substring(range.start, range.end);
    final lines = block.split('\n');
    final nonEmpty = lines.where((l) => l.isNotEmpty).toList();
    final allBulleted =
        nonEmpty.isNotEmpty && nonEmpty.every((l) => l.startsWith('• '));

    final newLines = lines.map((l) {
      if (l.isEmpty) return l;
      if (allBulleted) return l.startsWith('• ') ? l.substring(2) : l;
      return l.startsWith('• ') ? l : '• $l';
    }).toList();
    final newBlock = newLines.join('\n');
    final newText =
        text.substring(0, range.start) + newBlock + text.substring(range.end);
    final delta = newBlock.length - block.length;
    final newOffset = (end + delta).clamp(0, newText.length);
    return TextEditingValue(
      text: newText,
      selection: TextSelection.collapsed(offset: newOffset),
    );
  }

  /// Called right after the user types "\n" while on a bulleted line: if
  /// that line had real content, continues the list onto the new line; if
  /// it was an empty bulleted line (Enter pressed with nothing after the
  /// bullet), exits the list instead of adding another bullet — matching
  /// Notion/Docs. Returns null if the line just left wasn't bulleted at all
  /// (nothing to do).
  static TextEditingValue? continueOrExitBulletAfterNewline(
      String text, int newlineIndex) {
    final nl = text.lastIndexOf('\n', newlineIndex > 0 ? newlineIndex - 1 : 0);
    final prevLineStart = nl == -1 ? 0 : nl + 1;
    if (prevLineStart > newlineIndex || newlineIndex > text.length) return null;
    final prevLine = text.substring(prevLineStart, newlineIndex);
    if (!prevLine.startsWith('• ')) return null;

    if (prevLine.trim() == '•') {
      // Empty bulleted line — exit list mode instead of continuing it.
      final newText =
          text.substring(0, prevLineStart) + text.substring(newlineIndex + 1);
      return TextEditingValue(
        text: newText,
        selection: TextSelection.collapsed(offset: prevLineStart),
      );
    }

    const bullet = '• ';
    final insertAt = newlineIndex + 1;
    final newText = text.replaceRange(insertAt, insertAt, bullet);
    return TextEditingValue(
      text: newText,
      selection: TextSelection.collapsed(offset: insertAt + bullet.length),
    );
  }

  // ─── @mention trigger ───────────────────────────────────────────────

  static bool _isMentionBoundary(String ch) =>
      ch == ' ' || ch == '\n' || ch == '\t';

  /// The in-progress @mention query if the (collapsed) cursor sits right
  /// after an unterminated "@word" token — an '@' at the start of the text
  /// or preceded by whitespace, with no whitespace between it and the
  /// cursor — or null if there's no active mention trigger. The query may
  /// be the empty string right after typing a bare "@".
  static String? activeMentionQuery(String text, TextSelection selection) {
    if (!selection.isValid || !selection.isCollapsed) return null;
    final cursor = selection.baseOffset;
    if (cursor <= 0 || cursor > text.length) return null;

    var i = cursor - 1;
    while (i >= 0) {
      final ch = text[i];
      if (ch == '@') {
        final hasBoundaryBefore = i == 0 || _isMentionBoundary(text[i - 1]);
        return hasBoundaryBefore ? text.substring(i + 1, cursor) : null;
      }
      if (_isMentionBoundary(ch)) return null;
      i--;
    }
    return null;
  }

  /// Replaces the in-progress "@query" token the cursor sits in (see
  /// [activeMentionQuery]) with "@username " and moves the cursor past it,
  /// ready to keep typing. Only call this when [activeMentionQuery] just
  /// returned non-null for the same [text]/[selection].
  static TextEditingValue insertMention(
      String text, TextSelection selection, String username) {
    final cursor = selection.baseOffset;
    var i = cursor - 1;
    while (i >= 0 && text[i] != '@') {
      i--;
    }
    final before = text.substring(0, i);
    final after = text.substring(cursor);
    final insertion = '@$username ';
    final newText = '$before$insertion$after';
    return TextEditingValue(
      text: newText,
      selection:
          TextSelection.collapsed(offset: before.length + insertion.length),
    );
  }

  // ─── Insertion diff ─────────────────────────────────────────────────

  /// Finds the substring inserted between [oldText] and [newText] (assumes
  /// a single, contiguous insertion — the normal case for typing/pasting),
  /// via common-prefix/common-suffix. Returns null for a deletion/no net
  /// change. Used to detect a bare "\n" insertion for bullet
  /// continue/exit.
  static ({int start, int end, String inserted})? isolateInsertion(
      String oldText, String newText) {
    if (newText.length <= oldText.length) return null;
    final minLen =
        oldText.length < newText.length ? oldText.length : newText.length;
    var prefixLen = 0;
    while (prefixLen < minLen && oldText[prefixLen] == newText[prefixLen]) {
      prefixLen++;
    }
    var suffixLen = 0;
    final maxSuffix = minLen - prefixLen;
    while (suffixLen < maxSuffix &&
        oldText[oldText.length - 1 - suffixLen] ==
            newText[newText.length - 1 - suffixLen]) {
      suffixLen++;
    }
    final start = prefixLen;
    final end = newText.length - suffixLen;
    if (end <= start) return null;
    return (start: start, end: end, inserted: newText.substring(start, end));
  }
}
