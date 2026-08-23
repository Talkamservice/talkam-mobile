part of 'composer_editor_cubit.dart';

class ComposerEditorState {
  const ComposerEditorState({
    this.isBoldActive = false,
    this.isItalicActive = false,
    this.isBulletLineActive = false,
    this.showStyleOptions = false,
    this.showMoreOptions = false,
    this.mentionQuery,
    this.mentionResults = const [],
    this.mentionLoading = false,
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

  /// The in-progress "@query" text right after an active, unterminated
  /// "@" trigger (see `ComposerTextTools.activeMentionQuery`) — null when
  /// no mention suggestions should show. Always recomputed fresh on every
  /// text/selection change, so it's set directly rather than through
  /// [copyWith] (which can't tell "leave unchanged" apart from "clear to
  /// null" for a nullable field).
  final String? mentionQuery;

  /// Debounced people-search results for [mentionQuery]. Stale while
  /// [mentionLoading] is true for a query that changed since these were
  /// fetched.
  final List<PostCreator> mentionResults;
  final bool mentionLoading;

  bool get showMentionSuggestions => mentionQuery != null;

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
        mentionQuery: mentionQuery,
        mentionResults: mentionResults,
        mentionLoading: mentionLoading,
      );
}
