import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:talkam/core/services/data/resettable_on_logout.dart';

/// Client-side memory of which posts the current user has reacted to.
///
/// Confirmed from raw responses (2026-09-30) that both `GET
/// /api/v2/user/posts/{id}` (post details) and, very likely, the
/// Featured/Recent/Trending feed endpoints never populate `reaction` for
/// the current user — `likes_count` is correct, `reaction` comes back
/// null even for a post the user has actually liked. Mirrors
/// [CommentReactionOverrideStore]'s reasoning exactly; see its doc
/// comment for the fuller explanation. Kept as a separate store (not a
/// shared one keyed by "kind") since post ids and comment ids are
/// unrelated id spaces.
///
/// Papers over the backend gap — doesn't fix it. Only knows about
/// reactions made from this device.
class PostReactionOverrideStore implements ResettableOnLogout {
  static const _prefsKey = 'post_reaction_overrides';

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
      persisted.forEach((postId, action) =>
          _overrides.putIfAbsent(postId, () => action.toString()));
    } catch (_) {
      // Corrupt/old-shape prefs value — ignore, starts empty.
    }
  }

  void setReaction(String postId, String action) {
    _overrides[postId] = action;
    _persist();
  }

  void clearReaction(String postId) {
    _overrides.remove(postId);
    _persist();
  }

  String? reactionFor(String postId) => _overrides[postId];

  void _persist() {
    _prefs?.setString(_prefsKey, jsonEncode(_overrides));
  }

  @override
  void resetForLogout() {
    _overrides.clear();
    _prefs?.remove(_prefsKey);
  }
}
