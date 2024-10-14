import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:talkam/common/widgets/custom_dialogs.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/core/theme/pallets.dart';
import 'package:talkam/features/post/presentation/widgets/add_tags_sheet.dart';

class TagsPickerWidget extends StatefulWidget {
  const TagsPickerWidget({super.key, required this.onTagSelected});

  final Function(List<String> selectedTags) onTagSelected;

  @override
  State<TagsPickerWidget> createState() => _TagsPickerWidgetState();
}

class _TagsPickerWidgetState extends State<TagsPickerWidget> {
  List<String> selectedTags = [];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            TextView(
              text: "Tags",
              fontSize: 15.sp,
              fontWeight: FontWeight.w600,
            ),
            TextView(
              text: "*",
              fontSize: 15.sp,
              color: Pallets.red,
              fontWeight: FontWeight.w600,
            )
          ],
        ),
        8.verticalSpace,
        InkWell(
          onTap: () {
            selectTags(context);
          },
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 16),
            decoration: BoxDecoration(
                color: Pallets.borderGrey.withOpacity(0.1), border: Border.all(color: Pallets.borderGrey, width: 1), borderRadius: BorderRadius.circular(10)),
            height: 55,
            width: 1.sw,
            child: Row(
              children: [
                Expanded(
                    child: selectedTags.isNotEmpty
                        ? Wrap(
                            children: selectedTags
                                .map(
                                  (e) => Padding(
                                    padding: const EdgeInsets.only(right: 8.0),
                                    child: Chip(
                                      label: TextView(text: e),
                                      onDeleted: () {
                                        selectedTags.remove(e);
                                        setState(() {});
                                        widget.onTagSelected(selectedTags);
                                      },
                                    ),
                                  ),
                                )
                                .toList(),
                          )
                        : TextView(text: "Add at least one tag", style: TextStyle(color: Pallets.grey75, fontSize: 15.sp, fontWeight: FontWeight.w500))),
                10.horizontalSpace,
                const Icon(Icons.keyboard_arrow_down_rounded)
              ],
            ),
          ),
        )
      ],
    );
  }

  void selectTags(BuildContext context) async {
    List<String>? tags = await CustomDialogs.showBottomSheet(
        context,
        AddTagsSheet(
          initialTAgs: selectedTags,
        ));
    if (tags != null && tags.isNotEmpty) {
      selectedTags = tags;
      selectedTags = tags;
      logger.w(selectedTags.length);
    }
    widget.onTagSelected(selectedTags);
    setState(() {});
  }
}
