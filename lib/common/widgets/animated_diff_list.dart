import 'package:flutter/material.dart';

/// A list that animates item insertion/removal by diffing [items] (by
/// [keyOf]) against what it last rendered, instead of instantly swapping
/// the whole list like a plain `ListView.builder` would. Feed it a new
/// list the same way you'd feed `ListView.builder` — callers never call
/// `insertItem`/`removeItem` themselves; this widget owns all
/// `AnimatedList` bookkeeping internally.
///
/// Only handles pure add/remove — a kept item that also changed position
/// between builds stays wherever it currently sits rather than animating
/// a move, since group lists here only ever gain/lose members, not
/// reorder.
class AnimatedDiffList<T> extends StatefulWidget {
  const AnimatedDiffList({
    super.key,
    required this.items,
    required this.keyOf,
    required this.itemBuilder,
    this.duration = const Duration(milliseconds: 300),
    this.scrollDirection = Axis.vertical,
    this.padding,
    this.physics,
    this.shrinkWrap = false,
  });

  final List<T> items;
  final Object Function(T item) keyOf;
  final Widget Function(BuildContext context, T item, int index) itemBuilder;
  final Duration duration;
  final Axis scrollDirection;
  final EdgeInsetsGeometry? padding;
  final ScrollPhysics? physics;
  final bool shrinkWrap;

  @override
  State<AnimatedDiffList<T>> createState() => _AnimatedDiffListState<T>();
}

class _AnimatedDiffListState<T> extends State<AnimatedDiffList<T>> {
  final _listKey = GlobalKey<AnimatedListState>();
  late List<T> _current;

  @override
  void initState() {
    super.initState();
    _current = List.of(widget.items);
  }

  @override
  void didUpdateWidget(covariant AnimatedDiffList<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    _applyDiff(widget.items);
  }

  void _applyDiff(List<T> newItems) {
    final newKeys = newItems.map(widget.keyOf).toSet();

    // Removals first, walking backwards so removing one doesn't shift the
    // index of ones still to come.
    for (var i = _current.length - 1; i >= 0; i--) {
      if (!newKeys.contains(widget.keyOf(_current[i]))) {
        final removed = _current.removeAt(i);
        _listKey.currentState?.removeItem(
          i,
          (context, animation) => _fade(animation,
              widget.itemBuilder(context, removed, i)),
          duration: widget.duration,
        );
      }
    }

    // Then insertions, walking the new list in order so each insert
    // lands at the position it actually belongs in.
    for (var i = 0; i < newItems.length; i++) {
      final key = widget.keyOf(newItems[i]);
      final alreadyPresent =
          i < _current.length && widget.keyOf(_current[i]) == key;
      if (!alreadyPresent && !_current.any((e) => widget.keyOf(e) == key)) {
        _current.insert(i, newItems[i]);
        _listKey.currentState?.insertItem(i, duration: widget.duration);
      }
    }
  }

  Widget _fade(Animation<double> animation, Widget child) {
    return FadeTransition(
      opacity: animation,
      child: SizeTransition(
        sizeFactor: animation,
        axis: widget.scrollDirection,
        child: child,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedList(
      key: _listKey,
      scrollDirection: widget.scrollDirection,
      padding: widget.padding,
      physics: widget.physics,
      shrinkWrap: widget.shrinkWrap,
      initialItemCount: _current.length,
      itemBuilder: (context, index, animation) {
        return _fade(animation, widget.itemBuilder(context, _current[index], index));
      },
    );
  }
}
