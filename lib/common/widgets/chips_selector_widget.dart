import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/theme/pallets.dart';
import 'package:talkam/core/utils/extensions/context_extension.dart';

class LifeChipsList<T> extends StatefulWidget {
  const LifeChipsList({
    Key? key,
    required this.items,
    required this.onItemSelected,
    required this.initialItems,
    required this.selectionMode,
    this.tittle,
  }) : assert(selectionMode != null);

  final List<T> items;
  final Function(dynamic)
      onItemSelected; // Can be List<T> for multiple, T for choice
  final List<T> initialItems;
  final SelectionMode selectionMode;
  final String? tittle;

  factory LifeChipsList.multiple(
          {required List<T> items,
          required Function(dynamic) onItemSelected,
          required List<T> initialItems,
          String? tittle}) =>
      LifeChipsList(
        items: items,
        onItemSelected: onItemSelected,
        initialItems: initialItems,
        selectionMode: SelectionMode.multiple,
        tittle: tittle,
      );

  factory LifeChipsList.choice(
          {required List<T> items,
          required Function(dynamic) onItemSelected,
          required T initialItem, // C
          String? tittle
          // an be null for no initial selection
          }) =>
      LifeChipsList(
        items: items,
        onItemSelected: onItemSelected,
        initialItems: initialItem != null ? [initialItem] : [],
        selectionMode: SelectionMode.choice,
        tittle: tittle,
      );

  @override
  State<LifeChipsList<T>> createState() => _LifeChipsListState<T>();
}

class _LifeChipsListState<T> extends State<LifeChipsList<T>> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (widget.tittle != null)
          TextView(
            text: widget.tittle!,
            fontWeight: FontWeight.w500,
          ),
        if (widget.tittle != null) 10.verticalSpace,
        Wrap(
          clipBehavior: Clip.none,
          spacing: 12.w,
          runSpacing: 16.h,
          alignment: WrapAlignment.center,
          children: List.generate(
            widget.items.length,
            (index) => CustomChip(
              // hasImage: hasImage,
              title: widget.items[index].toString(),
              selected: widget.selectionMode == SelectionMode.multiple
                  ? widget.initialItems.contains(widget.items[index])
                  : widget.initialItems.length == 1 &&
                      widget.initialItems[0] == widget.items[index],
              onTap: () {
                if (widget.selectionMode == SelectionMode.multiple) {
                  if (widget.initialItems.contains(widget.items[index])) {
                    widget.initialItems.removeWhere(
                        (element) => element == widget.items[index]);
                  } else {
                    widget.initialItems.add(widget.items[index]);
                  }
                  widget.onItemSelected(widget.initialItems);
                } else {
                  if (widget.initialItems.isNotEmpty &&
                      widget.initialItems[0] == widget.items[index]) {
                    return; // Already selected in choice mode
                  }
                  widget.initialItems.clear();
                  widget.initialItems.add(widget.items[index]);
                  widget.onItemSelected(widget.items[index]);
                }
                setState(() {});
              },
              selectionMode: widget.selectionMode,
            ),
          ),
        ),
      ],
    );
  }
}

enum SelectionMode { multiple, choice }

class CustomChip extends StatelessWidget {
  const CustomChip({
    super.key,
    this.onTap,
    required this.title,
    this.selected = false,
    this.selectionMode = SelectionMode.multiple,
  });

  final VoidCallback? onTap;
  final String title;
  final bool selected;
  final SelectionMode? selectionMode;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        // margin: const EdgeInsets.all(5),
        padding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 12.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          border: Border.all(
              width: 1, color: selected ? Pallets.primary : Pallets.grey60),
          color: selected ? Pallets.primary.withOpacity(0.1) : null,
        ),
        duration: const Duration(milliseconds: 400),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            5.horizontalSpace,
            TextView(
              text: title,
              fontSize: 13,
              color: context.colorScheme.onSurface,
              // fontSize: 14,
            ),
            if (selectionMode == SelectionMode.multiple)
              Container(
                child: Row(
                  children: [
                    8.horizontalSpace,
                    Container(
                      height: 16,
                      width: 1.w,
                      color: Pallets.grey60,
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: 10.w,
                      ),
                      child: Icon(
                        selected ? Icons.close : Icons.add,
                        color: selected ? Pallets.primary : Pallets.grey60,
                        size: 18,
                      ),
                    )
                  ],
                ),
              )
          ],
        ),
      ),
    );
  }
}
