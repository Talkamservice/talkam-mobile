import 'package:talkam/features/post/data/models/get_comments_response.dart';

/// One reply, anywhere in a comment's reply tree, positioned for rendering
/// at a single flat indentation tier under its root comment.
class FlattenedReply {
  const FlattenedReply({
    required this.comment,
    required this.structuralParent,
    required this.showReplyArrow,
    required this.isLast,
  });

  final PostComment comment;

  /// The exact [PostComment] node whose `children` list contained this
  /// reply — i.e. who it actually replies to. Comment-identity-exact,
  /// unlike `commentReplyTo` (a username/name string that could collide
  /// between two different people).
  final PostComment structuralParent;

  /// True when [structuralParent] is itself a reply, not the root comment —
  /// the only case the reference design shows a "▸ target" annotation for.
  /// A plain first-level reply (structuralParent == root) never shows one.
  final bool showReplyArrow;

  /// True for the last row across the whole flattened list, not just the
  /// last among immediate siblings — used to close off the threading line.
  final bool isLast;
}

/// Flattens a comment's entire reply tree (arbitrary depth) into one
/// ordered list, all meant to render at the same visual indentation.
///
/// Walks depth-first, pre-order: each reply is emitted immediately before
/// its own sub-replies, so a reply and whatever replies to *it* stay
/// adjacent in the rendered list. A global sort by [PostComment.createdAt]
/// would scatter a reply away from its own sub-replies and make the
/// "▸ target" annotation point at something far up/down the list.
List<FlattenedReply> flattenReplies(PostComment root) {
  final flattened = <FlattenedReply>[];

  void visit(PostComment node) {
    for (final child in node.children) {
      flattened.add(FlattenedReply(
        comment: child,
        structuralParent: node,
        showReplyArrow: node.id != root.id,
        isLast: false, // corrected below once the full list is known
      ));
      visit(child);
    }
  }

  visit(root);

  return [
    for (var i = 0; i < flattened.length; i++)
      FlattenedReply(
        comment: flattened[i].comment,
        structuralParent: flattened[i].structuralParent,
        showReplyArrow: flattened[i].showReplyArrow,
        isLast: i == flattened.length - 1,
      ),
  ];
}
