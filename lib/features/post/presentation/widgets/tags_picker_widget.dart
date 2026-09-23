import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:talkam/common/widgets/custom_dialogs.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/core/theme/pallets.dart';
import 'package:talkam/features/post/presentation/widgets/add_tags_sheet.dart';

import 'add_tags_sheet_2.dart';

class TagsPickerWidget extends StatefulWidget {
  const TagsPickerWidget({super.key, required this.onTagSelected});

  final Function(List<String> selectedTags) onTagSelected;

  @override
  State<TagsPickerWidget> createState() => _TagsPickerWidgetState();
}

class _TagsPickerWidgetState extends State<TagsPickerWidget> {
  List<String> selectedTags = [];
  final ScrollController _tagsScrollController = ScrollController();

  // Only fade the edge that actually has more content hidden behind it —
  // e.g. scrolled all the way to the last pill, the right edge shows it
  // in full rather than fading it out.
  bool _canScrollLeft = false;
  bool _canScrollRight = false;

  @override
  void initState() {
    super.initState();
    _tagsScrollController.addListener(_updateFadeState);
    WidgetsBinding.instance.addPostFrameCallback((_) => _updateFadeState());
  }

  @override
  void dispose() {
    _tagsScrollController.removeListener(_updateFadeState);
    _tagsScrollController.dispose();
    super.dispose();
  }

  void _updateFadeState() {
    if (!_tagsScrollController.hasClients) return;
    final position = _tagsScrollController.position;
    final canScrollLeft = position.pixels > 0;
    final canScrollRight = position.pixels < position.maxScrollExtent;
    if (canScrollLeft != _canScrollLeft || canScrollRight != _canScrollRight) {
      setState(() {
        _canScrollLeft = canScrollLeft;
        _canScrollRight = canScrollRight;
      });
    }
  }

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

            constraints: const BoxConstraints(minHeight: 55, ),
            width: 1.sw,
            child: Row(
              children: [
                Expanded(
                    child: selectedTags.isNotEmpty
                        ? ShaderMask(
                            shaderCallback: (bounds) => LinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              colors: [
                                _canScrollLeft
                                    ? Colors.transparent
                                    : Colors.white,
                                Colors.white,
                                Colors.white,
                                _canScrollRight
                                    ? Colors.transparent
                                    : Colors.white,
                              ],
                              stops: const [0.0, 0.06, 0.94, 1.0],
                            ).createShader(bounds),
                            blendMode: BlendMode.dstIn,
                            child: SingleChildScrollView(
                              controller: _tagsScrollController,
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: selectedTags
                                    .map(
                                      (e) => Padding(
                                        padding:
                                            const EdgeInsets.only(right: 8.0),
                                        child: Chip(
                                          label: TextView(text: e),
                                          onDeleted: () {
                                            selectedTags.remove(e);
                                            setState(() {});
                                            widget
                                                .onTagSelected(selectedTags);
                                            WidgetsBinding.instance
                                                .addPostFrameCallback(
                                                    (_) => _updateFadeState());
                                          },
                                        ),
                                      ),
                                    )
                                    .toList(),
                              ),
                            ),
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
        AddTagsSheet2(
          initialTags: selectedTags,
        ));
    if (tags != null && tags.isNotEmpty) {
      selectedTags = tags;
      selectedTags = tags;
      logger.w(selectedTags.length);
    }
    widget.onTagSelected(selectedTags);
    setState(() {});
    WidgetsBinding.instance.addPostFrameCallback((_) => _updateFadeState());
  }
}
