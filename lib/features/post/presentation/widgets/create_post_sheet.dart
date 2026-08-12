import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talkam/common/widgets/custom_dialogs.dart';
import 'package:talkam/common/widgets/custom_switch.dart';
import 'package:talkam/common/widgets/image_widget.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/constants/package_exports.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/core/services/image_manipulation/image_manager.dart';
import 'package:talkam/core/theme/pallets.dart';
import 'package:talkam/core/utils/extensions/context_extension.dart';
import 'package:talkam/core/utils/extensions/date_extensions.dart';
import 'package:talkam/core/utils/extensions/int_extension.dart';
import 'package:talkam/core/utils/time_util.dart';
import 'package:talkam/features/post/data/models/create_post_payload.dart';
import 'package:talkam/features/post/data/models/get_categories_response.dart';
import 'package:talkam/features/post/dormain/mixins/refresh_posts_mixin.dart';
import 'package:talkam/features/post/presentation/bloc/create_post/create_post_cubit.dart';
import 'package:talkam/features/post/presentation/bloc/post/post_bloc.dart';
import 'package:talkam/features/post/presentation/widgets/rules_sheet.dart';
import 'package:talkam/features/post/presentation/widgets/tags_picker_widget.dart';
import 'package:talkam/gen/assets.gen.dart';

const _kBodyMaxLength = 500;

/// Opens [CreatePostSheet] as a modal bottom sheet.
Future<void> showCreatePostSheet(BuildContext context) {
  return CustomDialogs.showBottomSheet(
    context,
    const CreatePostSheet(),
    constraints: BoxConstraints(maxHeight: 0.94.sh),
  );
}

class CreatePostSheet extends StatefulWidget {
  const CreatePostSheet({super.key});

  @override
  State<CreatePostSheet> createState() => _CreatePostSheetState();
}

class _CreatePostSheetState extends State<CreatePostSheet>
    with RefreshPostsMixin {
  final bloc = CreatePostCubit(injector.get());
  final _postBloc = PostBloc(injector.get());
  final _titleController = TextEditingController();
  final _bodyController = TextEditingController();

  PostCategory? _selectedCategory;
  List<String> _tags = [];
  bool _schedulePost = false;
  DateTime? _scheduleDate;
  bool _isAnonymous = false;
  File? _stagedImage;

  @override
  void initState() {
    _postBloc.add(const PostEvent.getInterestTopics());
    super.initState();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _bodyController.dispose();
    _postBloc.close();
    super.dispose();
  }

  Future<void> _pickImage() async {
    var image = await ImageManager().pickImageFromGallery();
    if (image != null) setState(() => _stagedImage = image);
  }

  void _comingSoon() => CustomDialogs.showToast("Coming soon");

  Future<void> _pickScheduleDateTime() async {
    final now = DateTime.now();
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: now,
      lastDate: DateTime(now.year + 5),
    );
    if (pickedDate == null || !mounted) return;

    final pickedTime =
        await showTimePicker(context: context, initialTime: TimeOfDay.now());
    if (pickedTime == null) return;

    if (pickedDate.isToday && pickedTime.hour < TimeOfDay.now().hour) {
      CustomDialogs.error("Please select a future time.");
      return;
    }

    setState(() {
      _scheduleDate = DateTime(pickedDate.year, pickedDate.month,
          pickedDate.day, pickedTime.hour, pickedTime.minute);
    });
  }

  void _submit() {
    if (_titleController.text.trim().isEmpty) {
      CustomDialogs.error("Please add a title for your post");
      return;
    }
    if (_selectedCategory == null) {
      CustomDialogs.error("Please select an interest");
      return;
    }
    if (_tags.isEmpty) {
      CustomDialogs.error("Please add at least one tag");
      return;
    }
    if (_schedulePost && _scheduleDate == null) {
      CustomDialogs.error("Please select a schedule date and time");
      return;
    }

    bloc.updatePayload(CreatePostPayload(
      categoryId: _selectedCategory!.id,
      title: _titleController.text.trim(),
      body: _bodyController.text.trim(),
      tags: _tags,
      type: _stagedImage != null ? "Image" : "Text",
      attachments:
          _stagedImage != null ? [Attachment.image(_stagedImage!.path)] : [],
      status: _schedulePost ? "Scheduled" : "Active",
      publishAt: _schedulePost ? _scheduleDate : null,
      isAnonymous: _isAnonymous.toInt,
    ));
    bloc.createPost();
  }

  void _saveDraft() {
    if (_titleController.text.trim().isEmpty) {
      CustomDialogs.error("Please add a title for your post");
      return;
    }
    if (_selectedCategory == null) {
      CustomDialogs.error("Please select an interest");
      return;
    }

    bloc.updatePayload(CreatePostPayload(
      categoryId: _selectedCategory!.id,
      title: _titleController.text.trim(),
      body: _bodyController.text.trim(),
      tags: _tags,
      type: _stagedImage != null ? "Image" : "Text",
      attachments:
          _stagedImage != null ? [Attachment.image(_stagedImage!.path)] : [],
      isAnonymous: _isAnonymous.toInt,
    ));
    bloc.saveDraft();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: bloc,
      child: BlocListener<CreatePostCubit, CreatePostState>(
        listener: (context, state) {
          state.maybeWhen(
            orElse: () {},
            createPostLoading: () => CustomDialogs.showLoading(context),
            createPostFailure: (error) {
              context.pop();
              CustomDialogs.error(error.toString());
            },
            createPostSuccess: (response) {
              refreshPost();
              context.pop();
              CustomDialogs.success("Post created");
            },
            saveDraftLoading: () => CustomDialogs.showLoading(context),
            saveDraftFailure: (error) {
              context.pop();
              CustomDialogs.error(error.toString());
            },
            saveDraftSuccess: (response) {
              context.pop();
              context.pop();
              CustomDialogs.success("Saved as draft");
            },
          );
        },
        child: Container(
          decoration: BoxDecoration(
            color: context.theme.cardColor,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.r),
                topRight: Radius.circular(20.r)),
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
                            text: "Create Post",
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
                    BlocBuilder<PostBloc, PostState>(
                      bloc: _postBloc,
                      builder: (context, state) {
                        final categories = state.maybeWhen(
                          orElse: () => const <PostCategory>[],
                          getInterestTopicsSuccess: (response) => response.data,
                        );
                        return _CategoryChips(
                          categories: categories,
                          selected: _selectedCategory,
                          onSelected: (category) =>
                              setState(() => _selectedCategory = category),
                        );
                      },
                    ),
                    8.verticalSpace,
                    const Align(
                        alignment: Alignment.centerRight,
                        child: _RulesPillButton()),
                    16.verticalSpace,
                    const _FieldLabel("Title"),
                    8.verticalSpace,
                    _OutlinedBox(
                      child: TextField(
                        controller: _titleController,
                        textCapitalization: TextCapitalization.sentences,
                        decoration: const InputDecoration(
                          hintText: "A sharp title for your post works best",
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    16.verticalSpace,
                    _OutlinedBox(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextField(
                            controller: _bodyController,
                            maxLines: 8,
                            minLines: 6,
                            maxLength: _kBodyMaxLength,
                            textCapitalization: TextCapitalization.sentences,
                            onChanged: (_) => setState(() {}),
                            decoration: const InputDecoration(
                              hintText: "What's on your mind",
                              border: InputBorder.none,
                              counterText: "",
                            ),
                          ),
                          if (_stagedImage != null)
                            Padding(
                              padding: EdgeInsets.only(bottom: 8.h),
                              child: Stack(
                                clipBehavior: Clip.none,
                                children: [
                                  ImageWidget(
                                    imageUrl: _stagedImage!.path,
                                    height: 140.h,
                                    width: 1.sw,
                                    borderRadius: BorderRadius.circular(16.r),
                                    imageType: ImageWidgetType.file,
                                  ),
                                  Positioned(
                                    top: -8,
                                    right: -8,
                                    child: InkWell(
                                      onTap: () =>
                                          setState(() => _stagedImage = null),
                                      child: const CircleAvatar(
                                        backgroundColor: Pallets.primary,
                                        radius: 14,
                                        child: Icon(Icons.close,
                                            size: 16, color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          Row(
                            children: [
                              InkWell(
                                onTap: _pickImage,
                                child: ImageWidget(
                                    imageUrl: Assets.images.svgV2.addImageIcon,
                                    size: 20),
                              ),
                              16.horizontalSpace,
                              InkWell(
                                onTap: _comingSoon,
                                child: ImageWidget(
                                    imageUrl: Assets.images.svgV2.text,
                                    size: 20),
                              ),
                              16.horizontalSpace,
                              InkWell(
                                onTap: _comingSoon,
                                child: ImageWidget(
                                    imageUrl: Assets.images.svgV2.gif02,
                                    size: 20),
                              ),
                              16.horizontalSpace,
                              InkWell(
                                onTap: _comingSoon,
                                child: ImageWidget(
                                    imageUrl: Assets
                                        .images.svgV2.rightToLeftListBullet,
                                    size: 20),
                              ),
                              const Spacer(),
                              ValueListenableBuilder(
                                valueListenable: _bodyController,
                                builder: (context, value, _) => TextView(
                                  text: "${value.text.length}/$_kBodyMaxLength",
                                  color: Pallets.grey60,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    16.verticalSpace,
                    TagsPickerWidget(onTagSelected: (tags) => _tags = tags),
                    16.verticalSpace,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const TextView(
                            text: "Schedule this post", fontSize: 16),
                        CustomSwitch(
                          value: _schedulePost,
                          onChanged: (value) {
                            setState(() {
                              _schedulePost = value;
                              if (!value) _scheduleDate = null;
                            });
                          },
                        ),
                      ],
                    ),
                    if (_schedulePost) ...[
                      8.verticalSpace,
                      InkWell(
                        onTap: _pickScheduleDateTime,
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(
                              horizontal: 16.w, vertical: 2.h),
                          constraints: BoxConstraints(minHeight: 55.h),
                          decoration: BoxDecoration(
                            color: Pallets.borderGrey.withValues(alpha: 0.1),
                            border:
                                Border.all(color: Pallets.borderGrey, width: 1),
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: TextView(
                                  text: _scheduleDate != null
                                      ? TimeUtil.formartToDayTime(
                                          _scheduleDate!)
                                      : "Date & Time",
                                  fontSize: 15,
                                  color: _scheduleDate != null
                                      ? context.colorScheme.onSurface
                                      : Pallets.grey60,
                                ),
                              ),
                              const Icon(Icons.keyboard_arrow_down_rounded),
                            ],
                          ),
                        ),
                      ),
                    ],
                    16.verticalSpace,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const TextView(
                            text: "Post Anonymously",
                            fontWeight: FontWeight.w500),
                        8.horizontalSpace,
                        CustomSwitch(
                          value: _isAnonymous,
                          onChanged: (value) =>
                              setState(() => _isAnonymous = value),
                        ),
                      ],
                    ),
                    16.verticalSpace,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: _saveDraft,
                          child: const TextView(
                            text: "Save as Draft",
                            color: Pallets.blueBubbleColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Pallets.blueBubbleColor,
                            shape: const StadiumBorder(),
                            padding: EdgeInsets.symmetric(
                                horizontal: 32.w, vertical: 12.h),
                          ),
                          onPressed: _submit,
                          child: const TextView(
                              text: "Post",
                              color: Colors.white,
                              fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                    16.verticalSpace,
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(12.w),
                      decoration: BoxDecoration(
                        color: Pallets.anonymousBg.withValues(alpha: 0.25),
                        borderRadius: BorderRadius.circular(12.r),
                        border: Border.all(
                            color: Colors.orange.withValues(alpha: 0.4)),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.info_outline,
                              color: Colors.orange, size: 18),
                          8.horizontalSpace,
                          const Expanded(
                            child: TextView(
                              text: "Posting anonymously hides your identity",
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Colors.orange,
                            ),
                          ),
                        ],
                      ),
                    ),
                    12.verticalSpace,
                    const Center(
                      child: TextView(
                        text:
                            "Please be kind and respectful. Moderators review posts.",
                        fontSize: 12,
                        color: Pallets.grey60,
                        align: TextAlign.center,
                      ),
                    ),
                    16.verticalSpace,
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _RulesPillButton extends StatelessWidget {
  const _RulesPillButton();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(100),
      onTap: () => CustomDialogs.showBottomSheet(context, const RulesSheet()),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
        decoration: BoxDecoration(
          color: Pallets.blueBubbleColor.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(100),
          border: Border.all(color: Pallets.blueBubbleColor),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            ImageWidget(
                imageUrl: Assets.images.svgs.rules,
                size: 16,
                color: Pallets.blueBubbleColor),
            6.horizontalSpace,
            const TextView(
              text: "Rules",
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: Pallets.blueBubbleColor,
            ),
          ],
        ),
      ),
    );
  }
}

class _FieldLabel extends StatelessWidget {
  const _FieldLabel(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        TextView(text: text, fontSize: 15, fontWeight: FontWeight.w600),
        const TextView(
            text: " *", color: Pallets.red, fontWeight: FontWeight.w600),
      ],
    );
  }
}

class _OutlinedBox extends StatelessWidget {
  const _OutlinedBox({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
      decoration: BoxDecoration(
        border: Border.all(color: Pallets.grey90),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: child,
    );
  }
}

class _CategoryChips extends StatelessWidget {
  const _CategoryChips({
    required this.categories,
    required this.selected,
    required this.onSelected,
  });

  final List<PostCategory> categories;
  final PostCategory? selected;
  final ValueChanged<PostCategory> onSelected;

  @override
  Widget build(BuildContext context) {
    if (categories.isEmpty) {
      return SizedBox(
        height: 40.h,
        child: Center(child: CustomDialogs.getLoading(size: 24)),
      );
    }

    return SizedBox(
      height: 40.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        separatorBuilder: (context, index) => 8.horizontalSpace,
        itemBuilder: (context, index) {
          final category = categories[index];
          final isSelected = selected?.id == category.id;
          return GestureDetector(
            onTap: () => onSelected(category),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 18.w),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: isSelected
                    ? Pallets.blueBubbleColor.withValues(alpha: 0.08)
                    : Colors.white,
                borderRadius: BorderRadius.circular(100),
                border: Border.all(
                  color: isSelected ? Pallets.blueBubbleColor : Pallets.grey90,
                  width: isSelected ? 1.5 : 1,
                ),
              ),
              child: TextView(
                text: category.name.toString(),
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color:
                    isSelected ? Pallets.blueBubbleColor : Pallets.boldBlackV2,
              ),
            ),
          );
        },
      ),
    );
  }
}
