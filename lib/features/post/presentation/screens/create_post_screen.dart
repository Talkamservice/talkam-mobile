import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:talkam/common/widgets/custom_dialogs.dart';
import 'package:talkam/common/widgets/outlined_form_field.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/constants/dialog_texts.dart';
import 'package:talkam/core/constants/package_exports.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/core/navigation/route_url.dart';
import 'package:talkam/core/theme/pallets.dart';
import 'package:talkam/core/utils/_utils.dart';
import 'package:talkam/core/utils/extensions/context_extension.dart';
import 'package:talkam/core/utils/extensions/int_extension.dart';
import 'package:talkam/features/post/data/models/create_post_payload.dart';
import 'package:talkam/features/post/data/models/get_categories_response.dart';
import 'package:talkam/features/post/dormain/mixins/refresh_posts_mixin.dart';
import 'package:talkam/features/post/presentation/bloc/create_post/create_post_cubit.dart';
import 'package:talkam/features/post/presentation/widgets/create_poll_form.dart';
import 'package:talkam/features/post/presentation/widgets/create_post_header.dart';
import 'package:talkam/features/post/presentation/widgets/media_post_form.dart';
import 'package:talkam/features/post/presentation/widgets/schedule_post_form.dart';
import 'package:talkam/features/post/presentation/widgets/text_post_form.dart';
import 'package:talkam/features/search/data/models/get_group_response.dart';

enum PostType { text, file, poll }

class CreatePostScreen extends StatefulWidget {
  const CreatePostScreen({super.key});

  @override
  State<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> with RefreshPostsMixin {
  PostType postType = PostType.text;
  bool schedulePost = false;
  bool isAnonymous = false;
  var bloc = CreatePostCubit(injector.get());
  PostCategory? selectedCategory;
  TalkamGroup? selectedGroup;
  DateTime? scheduleDate;
  final tittleController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => bloc,
      child: BlocConsumer<CreatePostCubit, CreatePostState>(
        listener: _listenToCreatePostCubit,
        builder: (context, state) {
          return Scaffold(
            backgroundColor: context.theme.cardColor,
            bottomNavigationBar: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AnimatedCrossFade(
                  firstChild: Container(
                    width: 1.sw,
                    padding: const EdgeInsets.all(10),
                    decoration: const BoxDecoration(
                      color: Pallets.anonymousBg,
                    ),
                    child: const TextView(
                      text: anonymousPostText,
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
            appBar: const CreatePostAppBar(),
            body: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    CreatePostHeader(
                      onPostTypeChanged: (PostType type) {
                        postType = type;
                        setState(() {});
                      },
                      onIsAnonymousChanged: (bool val) {
                        isAnonymous = val;
                        setState(() {});
                      },
                      onCategorySelected: (PostCategory category) {
                        selectedCategory = category;
                      },
                      onGroupSelected: (TalkamGroup group) {
                        selectedCategory = group.category;
                        selectedGroup = group;
                        setState(() {});
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: OutlinedFormField(
                          placeHolder: postType == PostType.poll ? "Post title / Question" : "Post title",
                          fillColor: Pallets.borderGrey.withOpacity(0.1),
                          textCapitalization: TextCapitalization.sentences,
                          radius: 4,
                          filled: true,
                          maxLength: 80,
                          controller: tittleController,
                          validator: RequiredValidator(errorText: "Field is required").call,
                          onChange: (d) {
                            setState(() {});
                          },
                          showRequiredAsterics: true,
                          hint: "A sharp title for your post works best."),
                    ),
                    16.verticalSpace,
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: switch (postType) {
                        PostType.text => const TextPostForm(),
                        PostType.file => const MediaPostForm(),
                        PostType.poll => const CreatePollForm(),
                      },
                    ),
                    SchedulePostForm(
                      schedulePost: schedulePost,
                      onChanged: (val) {
                        schedulePost = val;
                        setState(() {});
                        if (!val) {
                          scheduleDate = null;
                        }
                      },
                      onScheduleDateSelected: (date) {
                        scheduleDate = date;
                      },
                    ),
                    70.verticalSpace
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  CrossFadeState get anonymousCrossFadeState {
    return isAnonymous ? CrossFadeState.showFirst : CrossFadeState.showSecond;
  }

  void _listenToCreatePostCubit(BuildContext context, CreatePostState state) {
    state.maybeWhen(
      orElse: () => null,
      validateFormsState: () {
        formKey.currentState?.validate();
      },
      validateFormsSuccessState: () {
        if (formKey.currentState?.validate() ?? false) {
          if (selectedCategory == null) {
            CustomDialogs.error("Please select a category");
          } else {
            if (schedulePost && scheduleDate == null) {
              CustomDialogs.error("Please select scheduled time and date");
            } else {
              context.read<CreatePostCubit>().updatePayload(CreatePostPayload(
                  categoryId: selectedCategory!.id,
                  publishAt: scheduleDate,
                  groupId: selectedGroup?.id!,
                  isAnonymous: isAnonymous.toInt,
                  title: tittleController.text,
                  type: postType.name.capitalizeFirst == "File" ? null : postType.name.capitalizeFirst));
              logger.w(context.read<CreatePostCubit>().createPostPayload.toJson());
              context.read<CreatePostCubit>().createPost();
            }
          }
        }
      },
      createPostLoading: () => CustomDialogs.showLoading(context),
      createPostFailure: (error) {
        context.pop();
        CustomDialogs.error(error.toString());
      },
      createPostSuccess: (response) {
        refreshPost();
        context.goNamed(PageUrl.homeScreen);

        CustomDialogs.success("Post created");
      },
    );
  }
}

class CreatePostAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CreatePostAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      foregroundColor: context.colorScheme.onSurface,
      elevation: 0,
      title: const TextView(
        text: "Create Post",
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
      actions: [
        // TextButton(
        //     onPressed: () {},
        //     child: const TextView(
        //       text: "Drafts",
        //       fontSize: 16,
        //       fontWeight: FontWeight.w700,
        //     )),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextButton(
              style: TextButton.styleFrom(
                  padding: EdgeInsets.zero, shape: const StadiumBorder(), backgroundColor: context.colorScheme.primary, foregroundColor: Pallets.white),
              onPressed: () async {
                context.read<CreatePostCubit>().validateForms();
              },
              child: const TextView(
                text: "Post",
                fontSize: 16,
                fontWeight: FontWeight.w700,
              )),
        ),
        10.horizontalSpace,
      ],
      leading: IconButton(
          style: TextButton.styleFrom(
            foregroundColor: context.colorScheme.onSurface,
          ),
          onPressed: () {
            context.pop();
          },
          icon: Icon(
            Icons.close,
            color: context.colorScheme.onSurface,
          )),
    );
  }

  @override
  Size get preferredSize => Size(1.sw, kToolbarHeight);
}
