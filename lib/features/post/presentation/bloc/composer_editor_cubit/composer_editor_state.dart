part of 'composer_editor_cubit.dart';

class ComposerEditorState {
  const ComposerEditorState({
    this.isBoldActive = false,
    this.isItalicActive = false,
    this.isBulletLineActive = false,
    this.showStyleOptions = false,
    this.showMoreOptions = false,
  });

  /// Whether B/I should show as active — either because the current
  /// selection/cursor position is already styled that way, or because the
  /// user just tapped the toggle at a bare cursor and it's armed for the
  /// next characters typed.
  final bool isBoldActive;
  final bool isItalicActive;

  /// Whether the cursor is currently on a bulleted line.
  final bool isBulletLineActive;

  final bool showStyleOptions;
  final bool showMoreOptions;

  ComposerEditorState copyWith({
    bool? isBoldActive,
    bool? isItalicActive,
    bool? isBulletLineActive,
    bool? showStyleOptions,
    bool? showMoreOptions,
  }) =>
      ComposerEditorState(
        isBoldActive: isBoldActive ?? this.isBoldActive,
        isItalicActive: isItalicActive ?? this.isItalicActive,
        isBulletLineActive: isBulletLineActive ?? this.isBulletLineActive,
        showStyleOptions: showStyleOptions ?? this.showStyleOptions,
        showMoreOptions: showMoreOptions ?? this.showMoreOptions,
      );
}
