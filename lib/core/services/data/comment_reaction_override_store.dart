import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:talkam/core/services/data/resettable_on_logout.dart';

/// Client-side memory of which comments the current user has reacted to.
///
/// `GET /api/v2/user/post-comments` (confirmed via raw response log,
/// 2026-09-30) returns each comment's `likes`/`unlikes` counts correctly
/// but never populates `reaction` for the current user — unlike the
/// single react-toggle endpoint, whose response is never actually read
/// for this either (the like button's active state is driven by an
/// optimistic local mutation at tap-time, not a server round trip). Once
/// the comment list is refetched (e.g. leaving and re-entering the
/// post), the count survives but "did I react to this" is lost, and the
/// like button stops showing active even though the like persisted
/// server-side.
///
/// This papers over that backend response gap — it doesn't fix it. It
/// only knows about reactions made from this device; a reaction made
/// elsewhere won't show as active here until the endpoint actually
/// returns it.
class CommentReactionOverrideStore implements ResettableOnLogout {
  static const _prefsKey = 'comment_reaction_overrides';

  SharedPreferences? _prefs;
  final Map<String, String> _overrides = {};
  Future<void>? _readyFuture;

  Future<void> get ready => _readyFuture ??= _load();

  Future<void> _load() async {
    _prefs = await SharedPreferences.getInstance();
    final raw = _prefs?.getString(_prefsKey);
    if (raw == null) return;
    try {
      final persisted = Map<String, dynamic>.from(jsonDecode(raw) as Map);
      // putIfAbsent, not a blind overwrite — a reaction made after init()
      // started but before this load finished shouldn't be clobbered by
      // the older persisted value.
      persisted.forEach((commentId, action) =>
          _overrides.putIfAbsent(commentId, () => action.toString()));
    } catch (_) {
      // Corrupt/old-shape prefs value — ignore, starts empty.
    }
  }

  void setReaction(String commentId, String action) {
    _overrides[commentId] = action;
    _persist();
  }

  void clearReaction(String commentId) {
    _overrides.remove(commentId);
    _persist();
  }

  String? reactionFor(String commentId) => _overrides[commentId];

  void _persist() {
    _prefs?.setString(_prefsKey, jsonEncode(_overrides));
  }

  @override
  void resetForLogout() {
    _overrides.clear();
    _prefs?.remove(_prefsKey);
  }
}
