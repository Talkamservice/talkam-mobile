import 'package:flutter/material.dart';
import 'package:talkam/core/utils/composer_markup.dart';

/// A drop-in [TextEditingController] that live-highlights `*bold*`/
/// `_italic_` markup (see [ComposerMarkup]) while typing — the same
/// technique Twitter/Slack/Discord use to highlight @mentions and syntax
/// inline in a plain text field: override [buildTextSpan] to render the
/// field's one plain string as styled spans, without touching what's
/// actually stored in [text]. What's typed is exactly what gets submitted;
/// this only changes how it's *displayed* while editing.
///
/// The `*`/`_` delimiters themselves are rendered invisible (transparent,
/// negligible width) — not just dimmed — so only the real bold/italic
/// content shows, in whatever font the field already uses. They still
/// exist in [text] exactly as typed/inserted; only their pixels disappear.
/// Inserting/removing them is handled by the toolbar's wrap/unwrap toggle
/// (`ComposerEditorCubit`/`ComposerTextTools`), not manual typing, so
/// there's no need to ever show them for editing purposes here.
///
/// Fully compatible with plain [TextEditingController] call sites — just
/// construct one of these instead and pass it to `TextField(controller:)`
/// as usual; `ComposerEditorCubit`, bullet handling, etc. all keep working
/// unchanged since this only overrides how text renders, not how it reads
/// or mutates.
///
/// Note: unlike the default controller, this doesn't render the OS
/// IME composing-region underline — an accepted, common simplification for
/// custom controllers, and cosmetic only (typing/autocorrect still work).
class RichComposerController extends TextEditingController {
  RichComposerController({super.text});

  RichComposerController.fromValue(super.value) : super.fromValue();

  @override
  TextSpan buildTextSpan({
    required BuildContext context,
    TextStyle? style,
    required bool withComposing,
  }) {
    final runs = ComposerMarkup.parse(text);
    if (runs.every((r) => !r.bold && !r.italic)) {
      // Nothing styled — skip the span-splitting entirely.
      return TextSpan(text: text, style: style);
    }

    // Present in the span tree (so cursor/selection offset math against
    // `text` stays correct — Flutter maps caret position by offset into
    // the rendered span, not the source string) but rendered with no
    // visible pixels: transparent and near-zero size, so it neither shows
    // nor takes up noticeable space.
    final hiddenStyle = (style ?? const TextStyle()).copyWith(
      color: Colors.transparent,
      fontSize: 0.1,
      fontWeight: FontWeight.normal,
      fontStyle: FontStyle.normal,
    );

    final children = <TextSpan>[];
    for (final run in runs) {
      if (!run.bold && !run.italic) {
        children.add(TextSpan(text: run.text, style: style));
        continue;
      }
      final outer = text.substring(run.start, run.end);
      final delimLen = (outer.length - run.text.length) ~/ 2;
      final contentStyle = (style ?? const TextStyle()).copyWith(
        fontWeight: run.bold ? FontWeight.bold : style?.fontWeight,
        fontStyle: run.italic ? FontStyle.italic : style?.fontStyle,
      );
      children.add(
          TextSpan(text: outer.substring(0, delimLen), style: hiddenStyle));
      children.add(TextSpan(text: run.text, style: contentStyle));
      children.add(TextSpan(
          text: outer.substring(outer.length - delimLen), style: hiddenStyle));
    }
    return TextSpan(style: style, children: children);
  }
}
