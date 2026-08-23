import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/core/utils/composer_text_tools.dart';
import 'package:talkam/features/post/data/models/get_posts_response.dart';
import 'package:talkam/features/search/data/models/people_search_response.dart';
import 'package:talkam/features/search/data/models/talkam_search_result.dart';
import 'package:talkam/features/search/data/repository/search_repository.dart';

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
  final SearchRepository _searchRepository = injector.get();
  late TextEditingValue _previousValue;
  bool _mutating = false;
  Timer? _mentionDebounce;

  @override
  Future<void> close() {
    controller.removeListener(_handleControllerChange);
    _mentionDebounce?.cancel();
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

  /// Inserts the picked user's @mention at the active trigger (see
  /// [ComposerEditorState.mentionQuery]) and closes the suggestions list.
  void selectMention(String username) {
    _mutate(ComposerTextTools.insertMention(
        controller.text, controller.selection, username));
    _resync();
  }

  /// Explicitly hides mention suggestions (e.g. the user dismissed them)
  /// without changing the text — [_resync] would otherwise immediately
  /// recompute the same active query and show them again.
  void dismissMentionSuggestions() {
    _mentionDebounce?.cancel();
    emit(ComposerEditorState(
      isBoldActive: state.isBoldActive,
      isItalicActive: state.isItalicActive,
      isBulletLineActive: state.isBulletLineActive,
      showStyleOptions: state.showStyleOptions,
      showMoreOptions: state.showMoreOptions,
    ));
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
    final mentionQuery = ComposerTextTools.activeMentionQuery(
        controller.text, controller.selection);
    final mentionQueryChanged = mentionQuery != state.mentionQuery;

    emit(ComposerEditorState(
      isBoldActive: active.bold,
      isItalicActive: active.italic,
      isBulletLineActive: ComposerTextTools.isCursorOnBulletedLine(
          controller.text, controller.selection),
      showStyleOptions: state.showStyleOptions,
      showMoreOptions: state.showMoreOptions,
      mentionQuery: mentionQuery,
      mentionResults: mentionQueryChanged ? const [] : state.mentionResults,
      mentionLoading: mentionQueryChanged && mentionQuery != null,
    ));

    if (!mentionQueryChanged) return;
    _mentionDebounce?.cancel();
    // Wait for at least one real character after "@" before hitting the
    // network — a bare "@" alone would just be a full people listing.
    if (mentionQuery == null || mentionQuery.isEmpty) return;
    _mentionDebounce = Timer(
        const Duration(milliseconds: 300), () => _searchMentions(mentionQuery));
  }

  Future<void> _searchMentions(String query) async {
    List<PostCreator> results = const [];
    try {
      final SearchResult<PeopleSearchResponse> response =
          await _searchRepository.search(query, sort: SearchSort.people);
      results = response.result.data;
    } catch (e, stack) {
      // Swallowed on purpose (a failed lookup shouldn't surface as an
      // error toast while typing) — but logged, since otherwise this is
      // indistinguishable from a genuine zero-result search.
      logger.e('Mention search failed for "$query": $e', stackTrace: stack);
      results = const [];
    }
    // The trigger may have moved on (typed further, deleted the "@", moved
    // the cursor) while this request was in flight — only apply results
    // that still match what's currently active.
    if (isClosed || state.mentionQuery != query) return;
    emit(ComposerEditorState(
      isBoldActive: state.isBoldActive,
      isItalicActive: state.isItalicActive,
      isBulletLineActive: state.isBulletLineActive,
      showStyleOptions: state.showStyleOptions,
      showMoreOptions: state.showMoreOptions,
      mentionQuery: query,
      mentionResults: results,
      mentionLoading: false,
    ));
  }

  void _mutate(TextEditingValue value) {
    _mutating = true;
    controller.value = value;
    _previousValue = value;
    _mutating = false;
  }
}
