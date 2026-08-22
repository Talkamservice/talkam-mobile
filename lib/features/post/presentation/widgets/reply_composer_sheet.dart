import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talkam/common/widgets/custom_dialogs.dart';
import 'package:talkam/common/widgets/rich_composer_controller.dart';
import 'package:talkam/common/widgets/custom_switch.dart';
import 'package:talkam/common/widgets/image_widget.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/constants/package_exports.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/core/services/image_manipulation/image_manager.dart';
import 'package:talkam/core/theme/pallets.dart';
import 'package:talkam/core/utils/extensions/context_extension.dart';
import 'package:talkam/core/utils/extensions/int_extension.dart';
import 'package:talkam/features/post/data/models/save_comment_payload.dart';
import 'package:talkam/features/post/presentation/bloc/composer_editor_cubit/composer_editor_cubit.dart';
import 'package:talkam/features/post/presentation/widgets/emoji_composer_sheet.dart';
import 'package:talkam/features/post/presentation/widgets/style_toggle_chip.dart';
import 'package:talkam/features/profile/presentation/bloc/profile_bloc/profile_bloc.dart';
import 'package:talkam/gen/assets.gen.dart';

const _kReplyMaxLength = 500;

/// Bottom-sheet reply composer: quotes the post/comment being replied to,
/// then a "Post your reply" input with an image/formatting toolbar and an
/// anonymous toggle. Replaces the always-visible inline comment box.
class ReplyComposerSheet extends StatefulWidget {
  const ReplyComposerSheet({
    super.key,
    required this.avatarUrl,
    required this.posterName,
    this.isVerified = false,
    required this.timeAgo,
    this.title,
    required this.body,
    required this.replyingToUsername,
    required this.postId,
    this.parentId,
    this.replyComment,
  });

  final String avatarUrl;
  final String posterName;
  final bool isVerified;
  final String timeAgo;
  final String? title;
  final String body;
  final String replyingToUsername;
  final int postId;
  final int? parentId;
  final int? replyComment;

  @override
  State<ReplyComposerSheet> createState() => _ReplyComposerSheetState();
}

class _ReplyComposerSheetState extends State<ReplyComposerSheet> {
  final _controller = RichComposerController();
  late final _editor = ComposerEditorCubit(_controller);
  bool _isAnonymous = false;
  File? _stagedImage;

  @override
  void dispose() {
    _editor.close();
    _controller.dispose();
    super.dispose();
  }

  void _submit() {
    if (_controller.text.trim().isEmpty) return;
    Navigator.of(context).pop(
      SaveCommentPayload(
        postId: widget.postId,
        parentId: widget.parentId,
        replyComment: widget.replyComment,
        comment: _controller.text.trim(),
        attachment: _stagedImage?.path,
        isAnonymous: _isAnonymous.toInt,
      ),
    );
  }

  Future<void> _pickImage() async {
    var image = await ImageManager().pickImageFromGallery();
    if (image != null) setState(() => _stagedImage = image);
  }

  void _comingSoon() => CustomDialogs.showToast("Coming soon");

  void _openEmoji() {
    _editor.closeMoreOptions();
    showEmojiComposerSheet(context, _controller);
  }

  @override
  Widget build(BuildContext context) {
    final myAvatar = injector.get<ProfileBloc>().appUser?.avatar;

    return Container(
      decoration: BoxDecoration(
        color: context.theme.cardColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.r),
          topRight: Radius.circular(20.r),
        ),
      ),
      child: SafeArea(
        top: false,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              10.verticalSpace,
              Container(
                width: 36.w,
                height: 4.h,
                decoration: BoxDecoration(
                    color: Pallets.grey90,
                    borderRadius: BorderRadius.circular(2)),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                child: Row(
                  children: [
                    InkWell(
                      onTap: () => Navigator.of(context).pop(),
                      child: Icon(Icons.close,
                          color: context.colorScheme.onSurface),
                    ),
                    const Spacer(),
                    ValueListenableBuilder(
                      valueListenable: _controller,
                      builder: (context, value, _) {
                        final canSubmit = value.text.trim().isNotEmpty;
                        return ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Pallets.blueBubbleColor,
                            disabledBackgroundColor:
                                Pallets.blueBubbleColor.withValues(alpha: 0.4),
                            shape: const StadiumBorder(),
                            padding: EdgeInsets.symmetric(
                                horizontal: 24.w, vertical: 10.h),
                          ),
                          onPressed: canSubmit ? _submit : null,
                          child: const TextView(
                              text: "Reply",
                              color: Colors.white,
                              fontWeight: FontWeight.w700),
                        );
                      },
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    // Thread line centered on avatar (avatar size 36, center at 18)
                    Positioned(
                      left: 17.5,
                      top: 36,
                      bottom: 0,
                      child: Container(width: 1, color: Pallets.grey90),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipOval(
                          child:
                              ImageWidget(imageUrl: widget.avatarUrl, size: 36),
                        ),
                        12.horizontalSpace,
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(bottom: 12.h),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    TextView(
                                        text: widget.posterName,
                                        fontWeight: FontWeight.w700),
                                    if (widget.isVerified) ...[
                                      4.horizontalSpace,
                                      Icon(Icons.verified,
                                          size: 14.sp,
                                          color: Pallets.blueBubbleColor),
                                    ],
                                    const Spacer(),
                                    TextView(
                                        text: widget.timeAgo,
                                        color: Pallets.grey60,
                                        fontSize: 12),
                                  ],
                                ),
                                4.verticalSpace,
                                if (widget.title?.isNotEmpty ?? false)
                                  TextView(
                                      text: widget.title!,
                                      fontWeight: FontWeight.w700),
                                TextView(
                                  text: widget.body,
                                  maxLines: 2,
                                  textOverflow: TextOverflow.ellipsis,
                                  color: Pallets.grey400,
                                ),
                                8.verticalSpace,
                                TextView(
                                  text:
                                      "Replying to @${widget.replyingToUsername}",
                                  color: Pallets.blueBubbleColor,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 13,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipOval(
                      child: ImageWidget(
                          imageUrl: myAvatar ?? Assets.images.svgs.dummyUser,
                          size: 36),
                    ),
                    12.horizontalSpace,
                    Expanded(
                      child: TextField(
                        controller: _controller,
                        autofocus: true,
                        maxLines: 5,
                        minLines: 1,
                        maxLength: _kReplyMaxLength,
                        textCapitalization: TextCapitalization.sentences,
                        decoration: const InputDecoration(
                          hintText: "Post your reply",
                          border: InputBorder.none,
                          counterText: "",
                          contentPadding: EdgeInsets.symmetric(vertical: 8),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              if (_stagedImage != null)
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
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
                          onTap: () => setState(() => _stagedImage = null),
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
              const Divider(height: 24),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: BlocBuilder<ComposerEditorCubit, ComposerEditorState>(
                    bloc: _editor,
                    builder: (context, editorState) => SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          InkWell(
                            onTap: _pickImage,
                            child: ImageWidget(
                                imageUrl: Assets.images.svgV2.addImageIcon,
                                size: 20),
                          ),
                          16.horizontalSpace,
                          InkWell(
                            canRequestFocus: false,
                            onTap: _editor.toggleStyleOptions,
                            child: ImageWidget(
                              imageUrl: Assets.images.svgV2.text,
                              size: 20,
                              color: editorState.showStyleOptions
                                  ? Pallets.blueBubbleColor
                                  : null,
                            ),
                          ),
                          AnimatedSize(
                            duration: const Duration(milliseconds: 200),
                            curve: Curves.easeOut,
                            child: !editorState.showStyleOptions
                                ? const SizedBox(height: 28)
                                : Row(
                                    children: [
                                      8.horizontalSpace,
                                      StyleToggleChip(
                                        label: "B",
                                        active: editorState.isBoldActive,
                                        onTap: _editor.toggleBold,
                                      ),
                                      8.horizontalSpace,
                                      StyleToggleChip(
                                        label: "I",
                                        active: editorState.isItalicActive,
                                        fontStyle: FontStyle.italic,
                                        onTap: _editor.toggleItalic,
                                      ),
                                    ],
                                  ),
                          ),
                          16.horizontalSpace,
                          InkWell(
                            onTap: _comingSoon,
                            child: ImageWidget(
                                imageUrl: Assets.images.svgV2.gif02, size: 20),
                          ),
                          16.horizontalSpace,
                          InkWell(
                            canRequestFocus: false,
                            onTap: _editor.toggleBulletLine,
                            child: ImageWidget(
                              imageUrl:
                                  Assets.images.svgV2.rightToLeftListBullet,
                              size: 20,
                              color: editorState.isBulletLineActive
                                  ? Pallets.blueBubbleColor
                                  : null,
                            ),
                          ),
                          16.horizontalSpace,
                          InkWell(
                            canRequestFocus: false,
                            onTap: _editor.toggleMoreOptions,
                            child: Icon(Icons.add_circle_outline,
                                size: 22,
                                color: editorState.showMoreOptions
                                    ? Pallets.blueBubbleColor
                                    : Pallets.grey60),
                          ),
                          AnimatedSize(
                            duration: const Duration(milliseconds: 200),
                            curve: Curves.easeOut,
                            child: !editorState.showMoreOptions
                                ? const SizedBox(height: 28)
                                : Row(
                                    children: [
                                      8.horizontalSpace,
                                      InkWell(
                                        onTap: _openEmoji,
                                        child: const Icon(
                                            Icons.emoji_emotions_outlined,
                                            size: 20,
                                            color: Pallets.blueBubbleColor),
                                      ),
                                    ],
                                  ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Row(
                  children: [
                    const Spacer(),
                    ValueListenableBuilder(
                      valueListenable: _controller,
                      builder: (context, value, _) => TextView(
                        text:
                            "${value.text.characters.length}/$_kReplyMaxLength",
                        color: Pallets.grey60,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const TextView(
                        text: "Post Anonymously", fontWeight: FontWeight.w500),
                    8.horizontalSpace,
                    CustomSwitch(
                      value: _isAnonymous,
                      onChanged: (value) =>
                          setState(() => _isAnonymous = value),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
