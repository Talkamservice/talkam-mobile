import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talkam/common/widgets/chips_selector_widget.dart';
import 'package:talkam/common/widgets/custom_button.dart';
import 'package:talkam/common/widgets/custom_dialogs.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/constants/package_exports.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/core/navigation/route_url.dart';
import 'package:talkam/features/post/data/models/get_categories_response.dart';
import 'package:talkam/features/post/presentation/bloc/post/post_bloc.dart';
import 'package:talkam/features/profile/data/models/update_profile_payload.dart';
import 'package:talkam/features/profile/presentation/bloc/profile_bloc/profile_bloc.dart';

class InterestsScreen extends StatefulWidget {
  const InterestsScreen({super.key});

  @override
  State<InterestsScreen> createState() => _InterestsScreenState();
}

class _InterestsScreenState extends State<InterestsScreen> {
  List<PostCategory> selectedInterests = [];

  @override
  void initState() {
    postBloc.add(const PostEvent.getCategories());
    super.initState();
  }

  final postBloc = PostBloc(injector.get());
  final profileBloc = ProfileBloc(injector.get());

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PostBloc, PostState>(
      bloc: postBloc,
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          bottomNavigationBar: BlocListener<ProfileBloc, ProfileState>(
            bloc: profileBloc,
            listener: _listenToProfileBloc,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      const Expanded(child: TextView(text: 'Select at least 3')),
                      TextView(
                        text: '${selectedInterests.length}/3',
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      )
                    ],
                  ),
                  21.verticalSpace,
                  CustomButton(
                    onPressed: selectedInterests.length >= 3
                        ? () {
                            profileBloc.add(UpdateProfileEvent(UpdateProfilePayload(
                              interests: selectedInterests
                                  .map(
                                    (e) => int.tryParse(e.id.toString()) ?? 0,
                                  )
                                  .toList(),
                            )));
                          }
                        : null,
                    child: const TextView(
                      text: 'Next',
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                children: [
                  24.verticalSpace,
                  const TextView(
                    text: 'What are your interests?',
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                  ),
                  8.verticalSpace,
                  const TextView(
                    lineHeight: 1.5,
                    align: TextAlign.center,
                    text: 'We’ll use this to recommend groups you can join.',
                    // fontWeight: FontWeight.w500,
                    // fontSize: 13,
                  ),
                  39.verticalSpace,
                  Expanded(
                      child: state.maybeWhen(
                    getCategoriesSuccess: (response) => LifeChipsList<PostCategory>.multiple(
                        items: response.data,
                        onItemSelected: (p0) {
                          selectedInterests = p0;
                          setState(() {});
                        },
                        initialItems: selectedInterests),
                    getCategoriesLoading: () => Center(
                      child: CustomDialogs.getLoading(size: 40),
                    ),
                    orElse: () => 0.verticalSpace,
                  )),
                  // 43.verticalSpace,
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _listenToProfileBloc(BuildContext context, ProfileState state) {
    if (state is UpdateProfileLoading) {
      CustomDialogs.showLoading(context);
    }
    if (state is UpdateProfileFailure) {
      context.pop();
      CustomDialogs.error(state.error);
    }
    if (state is UpdateProfileSuccess) {
      context.pop();
      CustomDialogs.success("Interest updated");
      context.pushNamed(PageUrl.userNameScreen);
    }
  }
}
