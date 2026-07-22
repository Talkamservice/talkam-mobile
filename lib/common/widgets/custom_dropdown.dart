import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/theme/pallets.dart';

/// A modern dropdown that opens a styled bottom sheet instead of the
/// default Material dropdown overlay.
class CustomDropdown<T> extends StatefulWidget {
  final String? label;
  final String hint;
  final T? value;
  final List<DropdownMenuItem<T>> items;
  final ValueChanged<T?> onChanged;
  final String? Function(T?)? validator;

  const CustomDropdown({
    super.key,
    this.label,
    required this.hint,
    this.value,
    required this.items,
    required this.onChanged,
    this.validator,
  });

  @override
  State<CustomDropdown<T>> createState() => _CustomDropdownState<T>();
}

class _CustomDropdownState<T> extends State<CustomDropdown<T>> {
  T? _selected;

  @override
  void initState() {
    super.initState();
    _selected = widget.value;
  }

  String get _displayText {
    if (_selected == null) return '';
    final match = widget.items.firstWhere(
      (item) => item.value == _selected,
      orElse: () => widget.items.first,
    );
    // Extract the text from the child widget
    if (match.child is Text) return (match.child as Text).data ?? '';
    return _selected.toString();
  }

  void _openSheet() async {
    final result = await showModalBottomSheet<T>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => _DropdownSheet<T>(
        items: widget.items,
        selected: _selected,
        label: widget.label,
      ),
    );

    if (result != null) {
      setState(() => _selected = result);
      widget.onChanged(result);
    }
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
        FormField<T>(
          validator: (val) => widget.validator?.call(_selected),
          builder: (field) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: _openSheet,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: 16.w, vertical: 14.h),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14.r),
                      border: Border.all(
                        color: field.hasError
                            ? Pallets.errorRed
                            : Pallets.grey90,
                        width: field.hasError ? 1.5 : 1,
                      ),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            _selected != null ? _displayText : widget.hint,
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: _selected != null
                                  ? Pallets.boldBlack
                                  : Pallets.grey75,
                              fontWeight: _selected != null
                                  ? FontWeight.w500
                                  : FontWeight.w400,
                            ),
                          ),
                        ),
                        AnimatedRotation(
                          turns: 0,
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
                if (field.hasError)
                  Padding(
                    padding: EdgeInsets.only(top: 6.h, left: 12.w),
                    child: Text(
                      field.errorText!,
                      style: TextStyle(
                        color: Pallets.errorRed,
                        fontSize: 12.sp,
                      ),
                    ),
                  ),
              ],
            );
          },
        ),
      ],
    );
  }
}

class _DropdownSheet<T> extends StatefulWidget {
  final List<DropdownMenuItem<T>> items;
  final T? selected;
  final String? label;

  const _DropdownSheet({
    required this.items,
    this.selected,
    this.label,
  });

  @override
  State<_DropdownSheet<T>> createState() => _DropdownSheetState<T>();
}

class _DropdownSheetState<T> extends State<_DropdownSheet<T>> {
  T? _hovered;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 12.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24.r),
          topRight: Radius.circular(24.r),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle bar
          Padding(
            padding: EdgeInsets.only(top: 12.h, bottom: 8.h),
            child: Container(
              width: 40.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: Pallets.grey90,
                borderRadius: BorderRadius.circular(4.r),
              ),
            ),
          ),

          // Title
          if (widget.label != null)
            Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
              child: Align(
                alignment: Alignment.centerLeft,
                child: TextView(
                  text: widget.label!,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Pallets.boldBlackV2,
                ),
              ),
            ),

          Divider(height: 1, color: Pallets.grey90, thickness: 1),

          // Items list
          ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.45,
            ),
            child: ListView.separated(
              shrinkWrap: true,
              padding: EdgeInsets.symmetric(vertical: 8.h),
              itemCount: widget.items.length,
              separatorBuilder: (_, __) => Divider(
                height: 1,
                indent: 20.w,
                endIndent: 20.w,
                color: Pallets.grey90.withOpacity(0.5),
              ),
              itemBuilder: (context, index) {
                final item = widget.items[index];
                final isSelected = item.value == widget.selected;

                // Extract label text
                String label = item.value.toString();
                if (item.child is Text) {
                  label = (item.child as Text).data ?? label;
                }

                return InkWell(
                  onTap: () => Navigator.of(context).pop(item.value),
                  splashColor:
                      Pallets.blueBubbleColor.withOpacity(0.05),
                  highlightColor:
                      Pallets.blueBubbleColor.withOpacity(0.04),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: 20.w, vertical: 16.h),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            label,
                            style: TextStyle(
                              fontSize: 15.sp,
                              fontWeight: isSelected
                                  ? FontWeight.w700
                                  : FontWeight.w500,
                              color: isSelected
                                  ? Pallets.blueBubbleColor
                                  : Pallets.boldBlackV2,
                            ),
                          ),
                        ),
                        if (isSelected)
                          Container(
                            width: 22.w,
                            height: 22.w,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Pallets.blueBubbleColor,
                            ),
                            child: Icon(
                              Icons.check,
                              color: Colors.white,
                              size: 13.sp,
                            ),
                          ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          SizedBox(height: MediaQuery.of(context).viewInsets.bottom + 24.h),
        ],
      ),
    );
  }
}
