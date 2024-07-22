import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:talkam/common/widgets/image_widget.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/constants/dialog_texts.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/core/services/image_manipulation/image_manager.dart';
import 'package:talkam/core/theme/pallets.dart';
import 'package:talkam/core/utils/extensions/context_extension.dart';
import 'package:talkam/core/utils/extensions/int_extension.dart';
import 'package:talkam/features/post/data/models/get_comments_response.dart';
import 'package:talkam/features/post/data/models/get_posts_response.dart';
import 'package:talkam/features/post/data/models/save_comment_payload.dart';
import 'package:talkam/features/post/presentation/screens/post_details_screen.dart';
import 'package:talkam/features/profile/presentation/bloc/profile_bloc/profile_bloc.dart';
import 'package:talkam/gen/assets.gen.dart';

class CommentInputWidget extends StatefulWidget {
  const CommentInputWidget({
    Key? key,
    required this.onCommentSubmitted,
    required this.postId,
    this.replyingComment,
    this.parentComment,
    this.replyComment,
  }) : super(key: key);

  final int postId;
  final PostComment? replyingComment;
  final int? parentComment;
  final int? replyComment;

  final Function(SaveCommentPayload comment) onCommentSubmitted;

  @override
  State<CommentInputWidget> createState() => _CommentInputWidgetState();
}

class _CommentInputWidgetState extends State<CommentInputWidget> {
  final TextEditingController _commentController = TextEditingController();
  bool _isAnonymous = false;
  final myFocusNode = FocusNode();
  File? stagedFile;
  final formKey = GlobalKey<FormState>();

  void _submitComment() {
    if (formKey.currentState?.validate() ?? false) {
      widget.onCommentSubmitted(SaveCommentPayload(
          postId: widget.postId,
          parentId: widget.parentComment,
          replyComment: widget.replyComment,
          comment: _commentController.text,
          attachment: stagedFile?.path,
          isAnonymous: _isAnonymous.toInt));
      myFocusNode.unfocus();
      _commentController.clear();
      stagedFile = null;
      setState(() {});
    }
    // Clear the text field after submitting}
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: context.theme.cardColor),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: ImageWidget(
                    imageUrl: injector.get<ProfileBloc>().appUser?.avatar ??
                        Assets.images.png.woman.path,
                    size: 36,
                    fit: BoxFit.cover,
                  ),
                ),
                8.horizontalSpace,
                Expanded(
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextFormField(
                          focusNode: myFocusNode,
                          controller: _commentController,
                          maxLines: 8,
                          minLines: 1,
                          validator:
                              RequiredValidator(errorText: "Field is required")
                                  .call,
                          decoration: const InputDecoration(
                            hintText: "Leave a comment ...",

                            border: InputBorder.none, // Remove default border
                            contentPadding: EdgeInsets.symmetric(vertical: 10),
                          ),
                        ),
                        8.verticalSpace,
                        Row(
                          children: [
                            InkWell(
                              onTap: () {
                                selectImage();
                              },
                              child: ImageWidget(
                                imageUrl: Assets.images.svgs.image03,
                                size: 24,
                              ),
                            ),
                            16.horizontalSpace,
                            ImageWidget(
                              imageUrl: Assets.images.svgs.gif,
                              size: 24,
                            ),
                            16.horizontalSpace,
                            AnonymousSwitcher(
                              value: _isAnonymous,
                              onChanged: (value) {
                                setState(() {
                                  _isAnonymous = value;
                                });
                              },
                            ),
                            const Spacer(),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 10),
                                backgroundColor: context.colorScheme.primary,
                                shape: const StadiumBorder(),
                              ),
                              onPressed: _submitComment,
                              child: const Text("Comment"),
                            ),
                          ],
                        ),
                        16.verticalSpace,
                        if (stagedFile != null)
                          Stack(
                            clipBehavior: Clip.none,
                            children: [
                              ImageWidget(
                                imageUrl: stagedFile!.path,
                                height: 70,
                                width: 1.sw,
                                imageType: ImageWidgetType.file,
                              ),
                              Positioned(
                                top: -10,
                                right: -10,
                                child: InkWell(
                                  onTap: () {
                                    stagedFile = null;
                                    setState(() {});
                                  },
                                  child: const CircleAvatar(
                                    backgroundColor: Pallets.primary,
                                    radius: 16,
                                    child: Icon(
                                      Icons.remove,
                                      color: Pallets.white,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          AnimatedCrossFade(
            firstChild: Container(
              width: 1.sw,
              padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                color: Pallets.anonymousBg,
              ),
              child: const TextView(
                text: anonymousCommentText,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
            secondChild: 0.verticalSpace,
            crossFadeState: anonymousCrossFadeState,
            duration: const Duration(milliseconds: 400),
          )
        ],
      ),
    );
  }

  CrossFadeState get anonymousCrossFadeState {
    return _isAnonymous ? CrossFadeState.showFirst : CrossFadeState.showSecond;
  }

  void selectImage() async {
    var image = await ImageManager().pickImageFromGallery();

    if (image != null) {
      stagedFile = image;
      setState(() {});
    }
  }
}
