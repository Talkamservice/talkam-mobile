import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talkam/common/widgets/custom_dialogs.dart';
import 'package:talkam/common/widgets/rich_composer_controller.dart';
import 'package:talkam/common/widgets/custom_switch.dart';
import 'package:talkam/common/widgets/image_widget.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/constants/package_exports.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/core/navigation/route_url.dart';
import 'package:talkam/core/services/image_manipulation/image_manager.dart';
import 'package:talkam/core/theme/pallets.dart';
import 'package:talkam/core/utils/extensions/context_extension.dart';
import 'package:talkam/core/utils/extensions/date_extensions.dart';
import 'package:talkam/core/utils/extensions/int_extension.dart';
import 'package:talkam/core/utils/time_util.dart';
import 'package:talkam/features/post/data/models/create_post_payload.dart';
import 'package:talkam/features/post/data/models/get_categories_response.dart';
import 'package:talkam/features/post/data/models/get_posts_response.dart';
import 'package:talkam/features/post/dormain/mixins/refresh_posts_mixin.dart';
import 'package:talkam/features/post/presentation/bloc/composer_editor_cubit/composer_editor_cubit.dart';
import 'package:talkam/features/post/presentation/bloc/create_post/create_post_cubit.dart';
import 'package:talkam/features/post/presentation/bloc/post/post_bloc.dart';
import 'package:talkam/features/post/presentation/widgets/emoji_composer_sheet.dart';
import 'package:talkam/features/post/presentation/widgets/mention_suggestions_panel.dart';
import 'package:talkam/features/post/presentation/widgets/poll_builder_sheet.dart';
import 'package:talkam/features/post/presentation/widgets/rules_sheet.dart';
import 'package:talkam/features/post/presentation/widgets/select_group_tab.dart';
import 'package:talkam/features/post/presentation/widgets/style_toggle_chip.dart';
import 'package:talkam/features/post/presentation/widgets/tags_picker_widget.dart';
import 'package:talkam/features/search/data/models/get_group_response.dart';
import 'package:talkam/gen/assets.gen.dart';

const _kBodyMaxLength = 500;
const _kTitleMaxLength = 40;

/// Opens [CreatePostSheet] as a modal bottom sheet. Pass [group] to
/// pre-attach a group (e.g. when opened from that group's own FAB) — still
/// freely changeable/clearable in the sheet, not locked. Pass [draft] to
/// open it pre-filled with an existing draft's content instead of blank —
/// "Post" then publishes that draft and "Save as Draft" updates it in
/// place, rather than either creating a separate new post/draft.
Future<void> showCreatePostSheet(BuildContext context,
    {TalkamGroup? group, TalkamPost? draft}) {
  FocusManager.instance.primaryFocus?.unfocus();
  return CustomDialogs.showBottomSheet(
    context,
    CreatePostSheet(group: group, draft: draft),
    constraints: BoxConstraints(maxHeight: 0.94.sh),
  );
}

class CreatePostSheet extends StatefulWidget {
  const CreatePostSheet({super.key, this.group, this.draft});

  final TalkamGroup? group;
  final TalkamPost? draft;

  @override
  State<CreatePostSheet> createState() => _CreatePostSheetState();
}

class _CreatePostSheetState extends State<CreatePostSheet>
    with RefreshPostsMixin {
  final bloc = CreatePostCubit(injector.get());
  final _postBloc = PostBloc(injector.get());
  final _titleController = TextEditingController();
  final _bodyController = RichComposerController();
  late final _bodyEditor = ComposerEditorCubit(_bodyController);
  final _scrollController = ScrollController();

  PostCategory? _selectedCategory;
  TalkamGroup? _selectedGroup;
  List<String> _tags = [];
  bool _schedulePost = false;
  DateTime? _scheduleDate;
  bool _isAnonymous = false;
  File? _stagedImage;
  Poll? _poll;

  /// The draft's own already-uploaded image, if it has one — kept separate
  /// from [_stagedImage] (always a local file) so an edit that doesn't
  /// touch the image can still resubmit it untouched, and so the preview
  /// can tell a network URL apart from a freshly-picked local file.
  String? _existingAttachmentUrl;

  bool _hasReachedMaxLength = false;
  bool _titleHasReachedMaxLength = false;

  bool get _isEditingDraft => widget.draft != null;

  @override
  void initState() {
    _selectedGroup = widget.group ?? widget.draft?.group;
    _postBloc.add(const PostEvent.getInterestTopics());
    _bodyController.addListener(_checkMaxLength);
    _titleController.addListener(_checkTitleMaxLength);

    final draft = widget.draft;
    if (draft != null) {
      _titleController.text = draft.title?.toString() ?? '';
      _bodyController.text = draft.body ?? '';
      _selectedCategory = draft.category;
      _tags = List.of(draft.tags);
      _isAnonymous = draft.isAnonymous.toBool;
      _schedulePost = draft.status == "Scheduled" && draft.publishAt != null;
      _scheduleDate = _schedulePost ? draft.publishAt as DateTime : null;
      final attachment = draft.attachments.whereType<Attachment>().firstOrNull;
      if (attachment != null) _existingAttachmentUrl = attachment.url;
    }
    super.initState();
  }

  Future<void> _pickGroup() async {
    FocusScope.of(context).unfocus();
    final group = await CustomDialogs.showBottomSheet<TalkamGroup>(
      context,
      const SelectGroupTab(),
    );
    if (group != null && mounted) {
      setState(() => _selectedGroup = group);
    }
  }

  void _checkMaxLength() {
    final length = _bodyController.text.characters.length;
    if (length >= _kBodyMaxLength) {
      if (!_hasReachedMaxLength) {
        _hasReachedMaxLength = true;
        CustomDialogs.showToast(
          "You have reached the maximum character limit of $_kBodyMaxLength characters",
        );
      }
    } else {
      _hasReachedMaxLength = false;
    }
  }

  void _checkTitleMaxLength() {
    final length = _titleController.text.characters.length;
    if (length >= _kTitleMaxLength) {
      if (!_titleHasReachedMaxLength) {
        _titleHasReachedMaxLength = true;
        HapticFeedback.vibrate();
        CustomDialogs.showToast(
          "You have reached the maximum character limit of $_kTitleMaxLength characters",
        );
      }
    } else {
      _titleHasReachedMaxLength = false;
    }
  }

  @override
  void dispose() {
    _bodyController.removeListener(_checkMaxLength);
    _titleController.removeListener(_checkTitleMaxLength);
    _titleController.dispose();
    _bodyEditor.close();
    _bodyController.dispose();
    bloc.close();
    _postBloc.close();
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final image = await ImageManager().pickImageFromGallery();
    if (image != null && mounted) {
      setState(() {
        _stagedImage = image;
        _existingAttachmentUrl = null;
        _poll = null;
      });
    }
  }

  void _comingSoon() => CustomDialogs.showToast("Coming soon");

  Future<void> _openPoll() async {
    _bodyEditor.closeMoreOptions();
    final poll = await showPollBuilderSheet(context, initial: _poll);
    if (poll != null && mounted) {
      setState(() {
        _poll = poll;
        _stagedImage = null;
      });
    }
  }

  void _openEmoji() {
    _bodyEditor.closeMoreOptions();
    showEmojiComposerSheet(context, _bodyController);
  }

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
    if (pickedTime == null || !mounted) return;

    if (pickedDate.isToday && pickedTime.hour < TimeOfDay.now().hour) {
      CustomDialogs.error("Please select a future time.");
      return;
    }

    setState(() {
      _scheduleDate = DateTime(pickedDate.year, pickedDate.month,
          pickedDate.day, pickedTime.hour, pickedTime.minute);
    });
  }

  /// The freshly-picked image if there is one, otherwise the draft's own
  /// already-uploaded image if it still has one, otherwise none.
  List<Attachment> get _attachmentsPayload => _stagedImage != null
      ? [Attachment.image(_stagedImage!.path)]
      : _existingAttachmentUrl != null
          ? [Attachment.image(_existingAttachmentUrl!)]
          : [];

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

    final payload = CreatePostPayload(
      categoryId: _selectedCategory!.id,
      groupId: _selectedGroup?.id,
      title: _titleController.text.trim(),
      body: _bodyController.text.trim(),
      tags: _tags,
      type: _poll != null ? "Poll" : (_stagedImage != null ? "Image" : "Text"),
      attachments: _attachmentsPayload,
      poll: _poll,
      status: _schedulePost ? "Scheduled" : "Active",
      publishAt: _schedulePost ? _scheduleDate : null,
      isAnonymous: _isAnonymous.toInt,
    );
    if (_isEditingDraft) {
      bloc.publishDraft(widget.draft!.id, payload);
    } else {
      bloc.updatePayload(payload);
      bloc.createPost();
    }
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

    final payload = CreatePostPayload(
      categoryId: _selectedCategory!.id,
      groupId: _selectedGroup?.id,
      title: _titleController.text.trim(),
      body: _bodyController.text.trim(),
      tags: _tags,
      type: _stagedImage != null ? "Image" : "Text",
      attachments: _attachmentsPayload,
      isAnonymous: _isAnonymous.toInt,
      // Deliberately unset (not "Active") so updating a draft's content
      // doesn't accidentally publish it — matches DraftsCubit.updateDraft.
      status: _isEditingDraft ? null : "Active",
    );
    if (_isEditingDraft) {
      bloc.updateDraft(widget.draft!.id, payload);
    } else {
      bloc.updatePayload(payload);
      bloc.saveDraft();
    }
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
              context.pop(); // dismiss loading dialog
              context.pop(); // dismiss bottom sheet
              CustomDialogs.success(
                  _isEditingDraft ? "Draft published" : "Post created");
            },
            saveDraftLoading: () => CustomDialogs.showLoading(context),
            saveDraftFailure: (error) {
              context.pop();
              CustomDialogs.error(error.toString());
            },
            saveDraftSuccess: (response) {
              context.pop();
              context.pop();
              CustomDialogs.success(
                  _isEditingDraft ? "Draft saved" : "Saved as draft");
            },
          );
        },
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: context.theme.cardColor,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.r),
                topRight: Radius.circular(20.r)),
          ),
          child: SafeArea(
            top: false,
            child: SingleChildScrollView(
              controller: _scrollController,
              physics: const ClampingScrollPhysics(),
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              child: SizedBox(
                width: double.infinity,
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
                              color: Pallets.grey60,
                              borderRadius: BorderRadius.circular(2)),
                        ),
                      ),
                      16.verticalSpace,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextView(
                              text:
                                  _isEditingDraft ? "Edit Draft" : "Create Post",
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
                            getInterestTopicsSuccess: (response) =>
                                response.data,
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
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          _GroupSelectorPill(
                            group: _selectedGroup,
                            onTap: _pickGroup,
                            onClear: () =>
                                setState(() => _selectedGroup = null),
                          ),
                          8.horizontalSpace,
                          const _DraftsPillButton(),
                          8.horizontalSpace,
                          const _RulesPillButton(),
                        ],
                      ),
                      16.verticalSpace,
                      const _FieldLabel("Title"),
                      8.verticalSpace,
                      _OutlinedBox(
                        child: TextField(
                          controller: _titleController,
                          textCapitalization: TextCapitalization.sentences,
                          maxLength: _kTitleMaxLength,
                          decoration: InputDecoration(
                            isDense: true,
                            contentPadding: EdgeInsets.symmetric(vertical: 8.h),
                            hintText: "A sharp title for your post works best",
                            hintStyle: const TextStyle(
                              color: Pallets.grey60,
                              fontSize: 14,
                            ),
                            border: InputBorder.none,
                            counterText: "",
                          ),
                        ),
                      ),
                      16.verticalSpace,
                      RepaintBoundary(
                        child: _OutlinedBox(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextField(
                                controller: _bodyController,
                                maxLines: 8,
                                minLines: 6,
                                maxLength: _kBodyMaxLength,
                                textCapitalization:
                                    TextCapitalization.sentences,
                                decoration: const InputDecoration(
                                  isDense: true,
                                  contentPadding:
                                      EdgeInsets.symmetric(vertical: 8),
                                  hintText: "What's on your mind",
                                  border: InputBorder.none,
                                  counterText: "",
                                ),
                              ),
                              MentionSuggestionsPanel(editor: _bodyEditor),
                              if (_stagedImage != null ||
                                  _existingAttachmentUrl != null)
                                Padding(
                                  padding: EdgeInsets.only(bottom: 8.h),
                                  child: Stack(
                                    clipBehavior: Clip.none,
                                    children: [
                                      ImageWidget(
                                        imageUrl: _stagedImage?.path ??
                                            _existingAttachmentUrl!,
                                        height: 140.h,
                                        width: 1.sw,
                                        borderRadius:
                                            BorderRadius.circular(16.r),
                                        imageType: _stagedImage != null
                                            ? ImageWidgetType.file
                                            : ImageWidgetType.network,
                                      ),
                                      Positioned(
                                        top: -8,
                                        right: -8,
                                        child: InkWell(
                                          onTap: () => setState(() {
                                            _stagedImage = null;
                                            _existingAttachmentUrl = null;
                                          }),
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
                              if (_poll != null)
                                Padding(
                                  padding: EdgeInsets.only(bottom: 8.h),
                                  child: _PollPreview(
                                    poll: _poll!,
                                    onEdit: () async {
                                      final poll = await showPollBuilderSheet(
                                          context,
                                          initial: _poll);
                                      if (poll != null && mounted) {
                                        setState(() => _poll = poll);
                                      }
                                    },
                                    onRemove: () =>
                                        setState(() => _poll = null),
                                  ),
                                ),
                              BlocBuilder<ComposerEditorCubit,
                                  ComposerEditorState>(
                                bloc: _bodyEditor,
                                builder: (context, editorState) =>
                                    SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      InkWell(
                                        onTap: _pickImage,
                                        child: ImageWidget(
                                            imageUrl: Assets
                                                .images.svgV2.addImageIcon,
                                            size: 20),
                                      ),
                                      16.horizontalSpace,
                                      InkWell(
                                        canRequestFocus: false,
                                        onTap: _bodyEditor.toggleStyleOptions,
                                        child: ImageWidget(
                                          imageUrl: Assets.images.svgV2.text,
                                          size: 20,
                                          color: editorState.showStyleOptions
                                              ? Pallets.blueBubbleColor
                                              : null,
                                        ),
                                      ),
                                      AnimatedSize(
                                        duration:
                                            const Duration(milliseconds: 200),
                                        curve: Curves.easeOut,
                                        alignment: Alignment.centerLeft,
                                        clipBehavior: Clip.hardEdge,
                                        child: !editorState.showStyleOptions
                                            ? const SizedBox(height: 28)
                                            : Row(
                                                children: [
                                                  8.horizontalSpace,
                                                  StyleToggleChip(
                                                    label: "B",
                                                    active: editorState
                                                        .isBoldActive,
                                                    onTap:
                                                        _bodyEditor.toggleBold,
                                                  ),
                                                  8.horizontalSpace,
                                                  StyleToggleChip(
                                                    label: "I",
                                                    active: editorState
                                                        .isItalicActive,
                                                    fontStyle: FontStyle.italic,
                                                    onTap: _bodyEditor
                                                        .toggleItalic,
                                                  ),
                                                ],
                                              ),
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
                                        canRequestFocus: false,
                                        onTap: _bodyEditor.toggleBulletLine,
                                        child: ImageWidget(
                                          imageUrl: Assets.images.svgV2
                                              .rightToLeftListBullet,
                                          size: 20,
                                          color: editorState.isBulletLineActive
                                              ? Pallets.blueBubbleColor
                                              : null,
                                        ),
                                      ),
                                      16.horizontalSpace,
                                      InkWell(
                                        onTap: _openPoll,
                                        child: const Icon(
                                            Icons.bar_chart_rounded,
                                            size: 20,
                                            color: Pallets
                                                .blueBubbleColor),
                                      ),
                                      16.horizontalSpace,
                                      InkWell(
                                        onTap: _openEmoji,
                                        child: const Icon(
                                            Icons
                                                .emoji_emotions_outlined,
                                            size: 20,
                                            color: Pallets
                                                .blueBubbleColor),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Row(
                                children: [
                                  const Spacer(),
                                  ValueListenableBuilder(
                                    valueListenable: _bodyController,
                                    builder: (context, value, _) => TextView(
                                      text:
                                          "${value.text.characters.length}/$_kBodyMaxLength",
                                      color: Pallets.grey60,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      16.verticalSpace,
                      TagsPickerWidget(
                        initialTags: _tags,
                        onTagSelected: (tags) => _tags = tags,
                      ),
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
                              border: Border.all(
                                  color: Pallets.borderGrey, width: 1),
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
      ),
    );
  }
}

/// Optional "attach this post to a group" pill, same visual language as
/// [_DraftsPillButton]/[_RulesPillButton]. Freely editable even when
/// pre-filled from a group's own FAB — never locked.
class _GroupSelectorPill extends StatelessWidget {
  const _GroupSelectorPill({
    required this.group,
    required this.onTap,
    required this.onClear,
  });

  final TalkamGroup? group;
  final VoidCallback onTap;
  final VoidCallback onClear;

  @override
  Widget build(BuildContext context) {
    final group = this.group;
    return Flexible(
      child: InkWell(
        borderRadius: BorderRadius.circular(100),
        onTap: onTap,
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
              Icon(Icons.groups_outlined,
                  size: 16.w, color: Pallets.blueBubbleColor),
              6.horizontalSpace,
              Flexible(
                child: TextView(
                  text: group?.name ?? "Add to group",
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Pallets.blueBubbleColor,
                  maxLines: 1,
                  textOverflow: TextOverflow.ellipsis,
                ),
              ),
              if (group != null) ...[
                6.horizontalSpace,
                InkWell(
                  onTap: onClear,
                  child: Icon(Icons.close,
                      size: 14.w, color: Pallets.blueBubbleColor),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _DraftsPillButton extends StatelessWidget {
  const _DraftsPillButton();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(100),
      onTap: () {
        FocusScope.of(context).unfocus();
        context.pushNamed(PageUrl.draftsListScreen);
      },
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
            Icon(Icons.drafts_outlined,
                size: 16.w, color: Pallets.blueBubbleColor),
            6.horizontalSpace,
            const TextView(
              text: "Drafts",
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

class _RulesPillButton extends StatelessWidget {
  const _RulesPillButton();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(100),
      onTap: () {
        FocusScope.of(context).unfocus();
        CustomDialogs.showBottomSheet(context, const RulesSheet());
      },
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

class _PollPreview extends StatelessWidget {
  const _PollPreview(
      {required this.poll, required this.onEdit, required this.onRemove});

  final Poll poll;
  final VoidCallback onEdit;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onEdit,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: Pallets.blueBubbleColor.withValues(alpha: 0.06),
          borderRadius: BorderRadius.circular(12.r),
          border:
              Border.all(color: Pallets.blueBubbleColor.withValues(alpha: 0.4)),
        ),
        child: Row(
          children: [
            const Icon(Icons.bar_chart_rounded,
                color: Pallets.blueBubbleColor, size: 20),
            10.horizontalSpace,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const TextView(
                      text: "Poll attached",
                      fontSize: 13,
                      fontWeight: FontWeight.w700),
                  2.verticalSpace,
                  TextView(
                    text:
                        "${poll.options.length} options • ${TimeUtil.formatPollDuration(poll.duration.toInt())}",
                    fontSize: 12,
                    color: Pallets.grey60,
                  ),
                ],
              ),
            ),
            InkWell(
              onTap: onRemove,
              child: const Icon(Icons.close, color: Pallets.grey60, size: 18),
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
      mainAxisSize: MainAxisSize.min,
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
        color: context.theme.cardColor,
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
        width: double.infinity,
        child: const Center(
          child: SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor:
                  AlwaysStoppedAnimation<Color>(Pallets.blueBubbleColor),
            ),
          ),
        ),
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
