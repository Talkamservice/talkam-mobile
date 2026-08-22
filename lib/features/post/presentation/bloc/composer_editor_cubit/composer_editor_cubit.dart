import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:talkam/core/utils/composer_text_tools.dart';

part 'composer_editor_state.dart';

/// Owns all text-editing behavior for a single composer field (a post body
/// or a reply body): bold/italic via plain `*bold*`/`_italic_` markup
/// (see [ComposerTextTools]/`ComposerMarkup`) that accurately reflects
/// whatever's under the current selection/cursor rather than a
/// manually-flipped switch, real toggle-on/toggle-off, bulleted lines
/// (including auto-continue/auto-exit on Enter), and the B/I + "more
/// tools" reveal-panel open state.
///
/// Owns [controller] for its lifetime — construct one per composer field in
/// `initState`, `close()` it in `dispose`. All writes to the controller go
/// through this cubit (never assign `controller.value` from the widget) so
/// there's exactly one place applying transforms, which is what makes the
/// selection-tracking reliable.
class ComposerEditorCubit extends Cubit<ComposerEditorState> {
  ComposerEditorCubit(this.controller) : super(const ComposerEditorState()) {
    _previousValue = controller.value;
    controller.addListener(_handleControllerChange);
  }

  final TextEditingController controller;
  late TextEditingValue _previousValue;
  bool _mutating = false;

  @override
  Future<void> close() {
    controller.removeListener(_handleControllerChange);
    return super.close();
  }

  void toggleStyleOptions() =>
      emit(state.copyWith(showStyleOptions: !state.showStyleOptions));

  void toggleMoreOptions() =>
      emit(state.copyWith(showMoreOptions: !state.showMoreOptions));

  void closeMoreOptions() => emit(state.copyWith(showMoreOptions: false));

  void toggleBold() {
    _mutate(
        ComposerTextTools.toggleBold(controller.text, controller.selection));
    _resync();
  }

  void toggleItalic() {
    _mutate(
        ComposerTextTools.toggleItalic(controller.text, controller.selection));
    _resync();
  }

  void toggleBulletLine() {
    _mutate(
        ComposerTextTools.toggleBullet(controller.text, controller.selection));
    _resync();
  }

  void _handleControllerChange() {
    if (_mutating) return;
    final current = controller.value;
    final prev = _previousValue;
    _previousValue = current;

    if (current.text == prev.text) {
      if (current.selection != prev.selection) _resync();
      return;
    }

    // A single "\n" just landed — auto-continue/exit a bulleted line.
    final insertion =
        ComposerTextTools.isolateInsertion(prev.text, current.text);
    if (insertion != null &&
        insertion.inserted == '\n' &&
        current.selection.isCollapsed) {
      final result = ComposerTextTools.continueOrExitBulletAfterNewline(
          current.text, insertion.start);
      if (result != null) {
        _mutate(result);
        _resync();
        return;
      }
    }

    _resync();
  }

  void _resync() {
    final active =
        ComposerTextTools.activeStyleFor(controller.text, controller.selection);
    emit(state.copyWith(
      isBoldActive: active.bold,
      isItalicActive: active.italic,
      isBulletLineActive: ComposerTextTools.isCursorOnBulletedLine(
          controller.text, controller.selection),
    ));
  }

  void _mutate(TextEditingValue value) {
    _mutating = true;
    controller.value = value;
    _previousValue = value;
    _mutating = false;
  }
}
