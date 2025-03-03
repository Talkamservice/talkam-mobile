import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talkam/common/widgets/custom_dialogs.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/constants/dialog_texts.dart';
import 'package:talkam/core/constants/package_exports.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/core/navigation/route_url.dart';
import 'package:talkam/core/theme/pallets.dart';
import 'package:talkam/core/utils/extensions/context_extension.dart';
import 'package:talkam/features/post/data/models/get_categories_response.dart';
import 'package:talkam/features/post/dormain/mixins/refresh_posts_mixin.dart';
import 'package:talkam/features/post/presentation/bloc/create_post/create_post_cubit.dart';
import 'package:talkam/features/post/presentation/screens/create_post_form.dart';
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

  bool canPostAnonymously = false;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => bloc,
      child: Scaffold(
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
        body: BlocListener<CreatePostCubit, CreatePostState>(
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
                context.goNamed(PageUrl.homeScreen);

                CustomDialogs.success("Post created");
              },
            );
          },
          child: CreatePostForm(
            onValidated: (payload) {
              bloc.createPost();
            },
          ),
        ),
      ),
    );
  }

  CrossFadeState get anonymousCrossFadeState {
    return isAnonymous ? CrossFadeState.showFirst : CrossFadeState.showSecond;
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
                fontSize: 14,
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
