import 'package:flutter/material.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/constants/package_exports.dart';
import 'package:talkam/core/theme/pallets.dart';

/// Dropdown whose option list floats in an overlay anchored to the field,
/// instead of opening a modal bottom sheet like [CustomDropdown] or pushing
/// the rest of the page down like an accordion.
///
/// Supports two modes:
///  * single-select — tapping an option selects it and closes the overlay
///  * multi-select  — options show checkboxes and the overlay stays open
///    until the header is tapped again or the user taps outside it
class InlineSelectField<T> extends StatefulWidget {
  const InlineSelectField({
    super.key,
    this.label,
    required this.hint,
    required this.options,
    required this.labelBuilder,
    this.multiple = false,
    this.value,
    this.values = const [],
    this.onSingleChanged,
    this.onMultipleChanged,
  }) : assert(
          multiple || onSingleChanged != null,
          'onSingleChanged is required in single-select mode',
        );

  final String? label;
  final String hint;
  final List<T> options;
  final String Function(T option) labelBuilder;

  final bool multiple;

  /// Single-select mode.
  final T? value;
  final ValueChanged<T>? onSingleChanged;

  /// Multi-select mode.
  final List<T> values;
  final ValueChanged<List<T>>? onMultipleChanged;

  @override
  State<InlineSelectField<T>> createState() => _InlineSelectFieldState<T>();
}

class _InlineSelectFieldState<T> extends State<InlineSelectField<T>> {
  final LayerLink _layerLink = LayerLink();
  final GlobalKey _fieldKey = GlobalKey();
  OverlayEntry? _overlayEntry;
  bool _expanded = false;

  /// Snapshot of the multi-select checked state while the panel is open.
  ///
  /// The overlay is a separate widget subtree from this field, so it only
  /// repaints when [OverlayEntry.markNeedsBuild] is called explicitly. Bloc
  /// events are processed asynchronously, so reading `widget.values` right
  /// after dispatching one would still show the pre-tap selection — the
  /// checkbox would visually lag a tap behind. Mutating this local copy
  /// synchronously keeps the panel's own rendering instant regardless of how
  /// long the round trip back through the bloc takes.
  late List<T> _localValues;

  String get _displayText {
    if (widget.multiple) {
      return widget.values.isEmpty
          ? widget.hint
          : widget.values.map(widget.labelBuilder).join(', ');
    }
    return widget.value != null
        ? widget.labelBuilder(widget.value as T)
        : widget.hint;
  }

  bool get _hasSelection =>
      widget.multiple ? widget.values.isNotEmpty : widget.value != null;

  @override
  void dispose() {
    _removeOverlay();
    super.dispose();
  }

  void _toggle() => _expanded ? _close() : _open();

  void _open() {
    final box = _fieldKey.currentContext?.findRenderObject() as RenderBox?;
    final width = box?.size.width ?? 0;
    _localValues = List<T>.from(widget.values);

    _overlayEntry = OverlayEntry(
      builder: (context) => Stack(
        children: [
          // Dismiss on outside tap without swallowing taps meant for the
          // page underneath the barrier once the panel itself is closed.
          Positioned.fill(
            child: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: _close,
            ),
          ),
          CompositedTransformFollower(
            link: _layerLink,
            showWhenUnlinked: false,
            targetAnchor: Alignment.bottomLeft,
            followerAnchor: Alignment.topLeft,
            offset: Offset(0, 6.h),
            child: _OptionsPanel<T>(
              width: width,
              options: widget.options,
              labelBuilder: widget.labelBuilder,
              multiple: widget.multiple,
              value: widget.value,
              values: _localValues,
              onOptionTap: _handleOptionTap,
            ),
          ),
        ],
      ),
    );

    Overlay.of(context).insert(_overlayEntry!);
    setState(() => _expanded = true);
  }

  void _close() {
    _removeOverlay();
    if (mounted) setState(() => _expanded = false);
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  void _handleOptionTap(T option) {
    if (widget.multiple) {
      if (_localValues.contains(option)) {
        _localValues.remove(option);
      } else {
        _localValues.add(option);
      }
      // Repaint the panel from the local snapshot immediately — don't wait
      // on the bloc round trip (see the field's doc comment above).
      _overlayEntry?.markNeedsBuild();
      widget.onMultipleChanged?.call(List<T>.from(_localValues));
      return;
    }

    widget.onSingleChanged?.call(option);
    _close();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null) ...[
          TextView(
            text: widget.label!,
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Pallets.boldBlackV2,
          ),
          8.verticalSpace,
        ],
        CompositedTransformTarget(
          link: _layerLink,
          child: GestureDetector(
            key: _fieldKey,
            onTap: _toggle,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14.r),
                border: Border.all(
                  color: Pallets.grey90,
                  width: _expanded ? 1.5 : 1,
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextView(
                      text: _displayText,
                      fontSize: 14.sp,
                      fontWeight:
                          _hasSelection ? FontWeight.w500 : FontWeight.w400,
                      color: _hasSelection ? Pallets.boldBlack : Pallets.grey75,
                    ),
                  ),
                  AnimatedRotation(
                    turns: _expanded ? 0.5 : 0,
                    duration: const Duration(milliseconds: 200),
                    child: const Icon(
                      Icons.keyboard_arrow_down_rounded,
                      color: Pallets.grey400,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

/// The floating card itself — rendered inside the [OverlayEntry], detached
/// from the field's own layout so it draws over whatever sits below it on
/// the page instead of shoving that content downward.
class _OptionsPanel<T> extends StatelessWidget {
  const _OptionsPanel({
    required this.width,
    required this.options,
    required this.labelBuilder,
    required this.multiple,
    required this.value,
    required this.values,
    required this.onOptionTap,
  });

  final double width;
  final List<T> options;
  final String Function(T option) labelBuilder;
  final bool multiple;
  final T? value;
  final List<T> values;
  final ValueChanged<T> onOptionTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 6,
      shadowColor: Colors.black.withValues(alpha: 0.15),
      borderRadius: BorderRadius.circular(14.r),
      child: Container(
        width: width,
        constraints: BoxConstraints(maxHeight: 260.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(color: Pallets.grey90, width: 1.5),
        ),
        child: ListView.separated(
          shrinkWrap: true,
          padding: EdgeInsets.symmetric(vertical: 4.h),
          itemCount: options.length,
          separatorBuilder: (_, __) =>
              Divider(height: 1, color: Pallets.grey90),
          itemBuilder: (context, index) {
            final option = options[index];
            final isSelected =
                multiple ? values.contains(option) : value == option;

            return InkWell(
              onTap: () => onOptionTap(option),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                child: Row(
                  children: [
                    if (multiple) ...[
                      _Checkbox(checked: isSelected),
                      10.horizontalSpace,
                    ],
                    Expanded(
                      child: TextView(
                        text: labelBuilder(option),
                        fontSize: 14,
                        fontWeight:
                            isSelected ? FontWeight.w700 : FontWeight.w500,
                        color: Pallets.boldBlackV2,
                      ),
                    ),
                    if (!multiple && isSelected)
                      Icon(Icons.check_rounded,
                          size: 18.sp, color: Pallets.blueBubbleColor),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _Checkbox extends StatelessWidget {
  const _Checkbox({required this.checked});

  final bool checked;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 20.w,
      height: 20.w,
      decoration: BoxDecoration(
        color: checked ? Pallets.blueBubbleColor : Colors.white,
        borderRadius: BorderRadius.circular(5.r),
        border: Border.all(
          color: checked ? Pallets.blueBubbleColor : Pallets.grey90,
          width: 1.5,
        ),
      ),
      child: checked
          ? Icon(Icons.check_rounded, size: 14.sp, color: Colors.white)
          : null,
    );
  }
}
