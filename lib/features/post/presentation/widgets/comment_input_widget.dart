import 'dart:ffi';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
import 'package:talkam/features/messaging/presentation/widgets/chat_emoji_widget.dart';
import 'package:talkam/features/post/data/models/get_comments_response.dart';
import 'package:talkam/features/post/data/models/get_posts_response.dart';
import 'package:talkam/features/post/data/models/save_comment_payload.dart';
import 'package:talkam/features/post/presentation/screens/post_details_screen.dart';
import 'package:talkam/features/profile/presentation/bloc/profile_bloc/profile_bloc.dart';
import 'package:talkam/features/search/presentation/blocs/search/search_cubit.dart';
import 'package:talkam/features/search/presentation/widget/search_user_dialog.dart';
import 'package:talkam/features/subscription/presentation/widgets/talkam_subscription_prompt.dart';
import 'package:talkam/features/subscription/utils/subscription_helper.dart';
import 'package:talkam/gen/assets.gen.dart';

import 'package:emoji_picker_flutter/emoji_picker_flutter.dart'; // Import the emoji picker package
import 'package:flutter/material.dart';

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
  bool _showMentionDialog = false;
  bool _isEmojiVisible = false; // Flag to show/hide emoji picker
  final formKey = GlobalKey<FormState>();
  late final ScrollController _scrollController;

  var searchBloc = SearchCubit(injector.get());

  bool canCommentAnonymously = true;

  @override
  void initState() {
    _scrollController = ScrollController();
    myFocusNode.addListener(
      () {
        //  if(myFocusNode.hasFocus){
        //
        // setState(() {
        //   _isEmojiVisible
        // });
        //  }
      },
    );
    super.initState();
  }

  void _submitComment() {
    // if (formKey.currentState?.validate() ?? false ) {

    if (_commentController.text.isNotEmpty || stagedFile != null) {
      widget.onCommentSubmitted(SaveCommentPayload(
        postId: widget.postId,
        parentId: widget.parentComment,
        replyComment: widget.replyComment,
        comment: _commentController.text,
        attachment: stagedFile?.path,
        isAnonymous: _isAnonymous.toInt,
      ));
      myFocusNode.unfocus();
      _commentController.clear();
      stagedFile = null;
      _isAnonymous= false;
      canCommentAnonymously = true;
      _isEmojiVisible = false; // Close emoji picker after comment submission
      setState(() {});
    }

    // }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: context.theme.cardColor),
      child: BlocProvider.value(
        value: searchBloc,
        child: Column(
          children: [
            Visibility(
              visible: _showMentionDialog,
              child: SearchUserDialog(onUserSelected: _onUserSelected),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: ImageWidget(
                      imageUrl: injector.get<ProfileBloc>().appUser?.avatar ?? Assets.images.png.woman.path,
                      size: 36,
                      fit: BoxFit.cover,
                    ),
                  ),
                  8.horizontalSpace,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextFormField(
                          focusNode: myFocusNode,
                          controller: _commentController,
                          maxLines: 8,
                          minLines: 1,
                          textCapitalization: TextCapitalization.sentences,
                          validator: RequiredValidator(errorText: "Field is required").call,
                          onChanged: (text) {
                            var splitted = text.split(' ');
                            if (splitted.last.contains('@')) {
                              setState(() {
                                _showMentionDialog = true;
                              });
                            } else if (splitted.last.endsWith(' ') || text.isEmpty) {
                              setState(() {
                                _showMentionDialog = false;
                              });
                            }
                            if (_showMentionDialog) {
                              var search = _commentController.text.substring(_commentController.text.lastIndexOf("@") + 1);
                              searchBloc.searchForUser(search);
                            }
                          },
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
                            InkWell(
                              onTap: () {
                                toggleEmojiPicker(); // Show/hide emoji picker
                              },
                              child: Icon(_isEmojiVisible ? Icons.keyboard : Icons.emoji_emotions_outlined, size: 20, color: Pallets.grey),
                            ),
                            16.horizontalSpace,
                            AnonymousSwitcher(
                              value: _isAnonymous,
                              onChanged: (value) {
                                onChanged(value);
                              },
                            ),
                            const Spacer(),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
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
                                height: 170,
                                width: 1.sw,
                                borderRadius: BorderRadius.circular(16),
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
                ],
              ),
            ),
            if (!canCommentAnonymously)
              TalkamSubscriptionPrompt(
                // tittle: "You have used up your free anonymous comments, to comment anonymously without limit, ",
                onReturnFromSubscription: () {
                  canCommentAnonymously = SubscriptionHelper.canCommentAnonymously;
                  setState(() {});
                },
              ),
            // Emoji Picker
            Offstage(
              offstage: !_isEmojiVisible,
              child: CustomEmojiPicker(textEditingController: _commentController, scrollController: _scrollController),
            )
          ],
        ),
      ),
    );
  }

  void onChanged(bool value) {
    if (SubscriptionHelper.canPostAnonymously) {
      setState(() {
        _isAnonymous = value;
      });

      // widget.onIsAnonymousChanged(_isAnonymous);
    }

    if (!SubscriptionHelper.isSubscribed) {
      canCommentAnonymously = false;
    }


    // if (!value) {
    //   canCommentAnonymously = true;
    // }
    setState(() {});
  }

  void toggleEmojiPicker() {
    setState(() {
      _isEmojiVisible = !_isEmojiVisible;
      // FocusScope.of(context).unfocus(); // Close the keyboard

      if (!_isEmojiVisible) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          myFocusNode.requestFocus();
        });
      } else {
        myFocusNode.unfocus();
      }
    });
  }

  void selectImage() async {
    var image = await ImageManager().pickImageFromGallery();
    if (image != null) {
      stagedFile = image;
      setState(() {});
    }
  }

  void _onUserSelected(String username) {
    setState(() {
      _showMentionDialog = false;
    });

    final text = _commentController.text;
    final cursorPos = _commentController.selection.baseOffset;
    final atIndex = text.lastIndexOf('@', cursorPos);

    if (atIndex != -1) {
      final newText = text.replaceRange(atIndex, cursorPos, '@$username');
      _commentController.value = TextEditingValue(
        text: newText,
        selection: TextSelection.collapsed(offset: atIndex + username.length + 1),
      );
    }
  }
}
