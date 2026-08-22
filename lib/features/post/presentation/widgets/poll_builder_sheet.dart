import 'package:flutter/material.dart';
import 'package:talkam/common/widgets/custom_dialogs.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/constants/package_exports.dart';
import 'package:talkam/core/theme/pallets.dart';
import 'package:talkam/core/utils/extensions/context_extension.dart';
import 'package:talkam/features/post/data/models/create_post_payload.dart';
import 'package:talkam/features/post/presentation/widgets/time_picker_button.dart';

const _kMinOptions = 2;
const _kMaxOptions = 4;

/// Opens the poll-builder sheet and returns the built [Poll], or null if
/// dismissed without completing it. Same rounded-top/drag-handle styling as
/// [CreatePostSheet] — the real create-post endpoint already accepts a
/// `poll` field, this just gives it a real UI (`PostPollWidget` was a dead
/// `Placeholder()`; the actual poll *display* on a post already works via
/// `PostContent`'s `PollsWidget`).
Future<Poll?> showPollBuilderSheet(BuildContext context, {Poll? initial}) {
  return CustomDialogs.showBottomSheet<Poll>(
    context,
    PollBuilderSheet(initial: initial),
    constraints: BoxConstraints(maxHeight: 0.85.sh),
  );
}

class PollBuilderSheet extends StatefulWidget {
  const PollBuilderSheet({super.key, this.initial});

  final Poll? initial;

  @override
  State<PollBuilderSheet> createState() => _PollBuilderSheetState();
}

class _PollBuilderSheetState extends State<PollBuilderSheet> {
  late final List<TextEditingController> _optionControllers =
      widget.initial != null
          ? widget.initial!.options
              .map((o) => TextEditingController(text: o))
              .toList()
          : [TextEditingController(), TextEditingController()];

  int _days = 1;
  int _hours = 0;

  @override
  void initState() {
    super.initState();
    if (widget.initial != null) {
      final total = Duration(minutes: widget.initial!.duration.toInt());
      _days = total.inDays;
      _hours = total.inHours.remainder(24);
    }
  }

  @override
  void dispose() {
    for (final c in _optionControllers) {
      c.dispose();
    }
    super.dispose();
  }

  void _addOption() {
    if (_optionControllers.length >= _kMaxOptions) return;
    setState(() => _optionControllers.add(TextEditingController()));
  }

  void _removeOption(int index) {
    if (_optionControllers.length <= _kMinOptions) return;
    setState(() => _optionControllers.removeAt(index).dispose());
  }

  Future<void> _selectDays() async {
    final picked = await CustomDialogs.showBottomSheet<int>(
      context,
      _NumberPickerSheet(title: "Days", max: 14, current: _days),
    );
    if (picked != null) setState(() => _days = picked);
  }

  Future<void> _selectHours() async {
    final picked = await CustomDialogs.showBottomSheet<int>(
      context,
      _NumberPickerSheet(title: "Hours", max: 23, current: _hours),
    );
    if (picked != null) setState(() => _hours = picked);
  }

  void _submit() {
    final options =
        _optionControllers.map((c) => c.text.trim()).toList(growable: false);
    if (options.any((o) => o.isEmpty)) {
      CustomDialogs.error("Please fill in every poll option");
      return;
    }
    if (options.toSet().length != options.length) {
      CustomDialogs.error("Poll options must be unique");
      return;
    }
    final durationMinutes = Duration(days: _days, hours: _hours).inMinutes;
    if (durationMinutes <= 0) {
      CustomDialogs.error("Please set a poll duration");
      return;
    }
    Navigator.of(context).pop(Poll(
      type: "Text",
      options: options,
      duration: durationMinutes.toDouble(),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.theme.cardColor,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.r), topRight: Radius.circular(20.r)),
      ),
      child: SafeArea(
        top: false,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                10.verticalSpace,
                Center(
                  child: Container(
                    width: 36.w,
                    height: 4.h,
                    decoration: BoxDecoration(
                        color: Pallets.grey90,
                        borderRadius: BorderRadius.circular(2)),
                  ),
                ),
                16.verticalSpace,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const TextView(
                        text: "Create a Poll",
                        fontSize: 20,
                        fontWeight: FontWeight.w700),
                    InkWell(
                      onTap: () => Navigator.of(context).pop(),
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        child: Icon(Icons.close,
                            color: context.colorScheme.onSurface),
                      ),
                    ),
                  ],
                ),
                16.verticalSpace,
                Row(
                  children: [
                    const TextView(
                        text: "Options",
                        fontSize: 15,
                        fontWeight: FontWeight.w600),
                    const TextView(
                        text: " *",
                        color: Pallets.red,
                        fontWeight: FontWeight.w600),
                  ],
                ),
                8.verticalSpace,
                ...List.generate(_optionControllers.length, (index) {
                  return Padding(
                    padding: EdgeInsets.only(bottom: 12.h),
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 16.w, vertical: 4.h),
                            decoration: BoxDecoration(
                              border: Border.all(color: Pallets.grey90),
                              borderRadius: BorderRadius.circular(16.r),
                            ),
                            child: TextField(
                              controller: _optionControllers[index],
                              textCapitalization: TextCapitalization.sentences,
                              decoration: InputDecoration(
                                hintText: "Choice ${index + 1}",
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ),
                        if (_optionControllers.length > _kMinOptions) ...[
                          8.horizontalSpace,
                          InkWell(
                            onTap: () => _removeOption(index),
                            child:
                                const Icon(Icons.close, color: Pallets.grey60),
                          ),
                        ],
                      ],
                    ),
                  );
                }),
                if (_optionControllers.length < _kMaxOptions)
                  InkWell(
                    borderRadius: BorderRadius.circular(100),
                    onTap: _addOption,
                    child: Container(
                      width: double.infinity,
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(vertical: 10.h),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        border: Border.all(color: Pallets.grey90),
                      ),
                      child: const TextView(
                          text: "+ Add option", fontWeight: FontWeight.w700),
                    ),
                  ),
                16.verticalSpace,
                const Divider(thickness: 1),
                16.verticalSpace,
                Row(
                  children: [
                    const Expanded(
                      child: TextView(
                          text: "Poll duration", fontWeight: FontWeight.w600),
                    ),
                    TimePickerButton(
                      title: "$_days${_days == 1 ? " Day" : " Days"}",
                      onPressed: _selectDays,
                    ),
                    10.horizontalSpace,
                    TimePickerButton(
                      title: "$_hours${_hours == 1 ? " Hour" : " Hours"}",
                      onPressed: _selectHours,
                    ),
                  ],
                ),
                24.verticalSpace,
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Pallets.blueBubbleColor,
                      shape: const StadiumBorder(),
                      padding: EdgeInsets.symmetric(vertical: 14.h),
                    ),
                    onPressed: _submit,
                    child: TextView(
                      text: widget.initial != null ? "Update Poll" : "Add Poll",
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                16.verticalSpace,
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _NumberPickerSheet extends StatelessWidget {
  const _NumberPickerSheet(
      {required this.title, required this.max, required this.current});

  final String title;
  final int max;
  final int current;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 0.5.sh,
      decoration: BoxDecoration(
        color: context.theme.cardColor,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.r), topRight: Radius.circular(20.r)),
      ),
      child: SafeArea(
        top: false,
        child: Column(
          children: [
            16.verticalSpace,
            TextView(text: title, fontSize: 16, fontWeight: FontWeight.w700),
            8.verticalSpace,
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                itemCount: max + 1,
                itemBuilder: (context, index) {
                  final isSelected = index == current;
                  return InkWell(
                    onTap: () => Navigator.of(context).pop(index),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextView(
                        text: "$index $title",
                        fontWeight:
                            isSelected ? FontWeight.w700 : FontWeight.w500,
                        color: isSelected
                            ? Pallets.blueBubbleColor
                            : Pallets.boldBlackV2,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
