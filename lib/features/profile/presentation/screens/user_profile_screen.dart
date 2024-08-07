import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:talkam/common/widgets/custom_appbar.dart';
import 'package:talkam/common/widgets/custom_dialogs.dart';
import 'package:talkam/common/widgets/image_widget.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/constants/package_exports.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/core/navigation/route_url.dart';
import 'package:talkam/core/theme/pallets.dart';
import 'package:talkam/features/authentication/data/models/auth_response.dart';
import 'package:talkam/features/profile/presentation/bloc/profile_screen_cubit/profile_screen_cubit.dart';
import 'package:talkam/features/profile/presentation/bloc/user_profile_cubit/user_profile_cubit.dart';
import 'package:talkam/features/profile/presentation/screens/tabs/profile_comments_tab.dart';
import 'package:talkam/features/profile/presentation/screens/tabs/profile_posts_tab.dart';
import 'package:talkam/features/profile/presentation/screens/tabs/profile_upvotes_tab.dart';
import 'package:talkam/features/profile/presentation/screens/user_profile_tabs/user_profile_comments_tab.dart';
import 'package:talkam/features/profile/presentation/screens/user_profile_tabs/user_profile_posts_tab.dart';
import 'package:talkam/features/profile/presentation/screens/user_profile_tabs/user_profile_upvotes_tab.dart';
import 'package:talkam/features/profile/presentation/widgets/profile_tab_bar.dart';
import 'package:talkam/gen/assets.gen.dart';

enum _ProfileTabOptions {
  posts,
  comments,
  upVotes;

  String get title {
    switch (this) {
      case posts:
        return "Posts";

      case comments:
        return "Comments";

      case upVotes:
        return "Upvotes";
    }
  }
}

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key, required this.userId});

  final String userId;

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  _ProfileTabOptions _selectedTab = _ProfileTabOptions.posts;
  final PageController _pageController = PageController();
  TalkamUser _talkamUser = TalkamUser.forTest();
  var userName;

  @override
  void initState() {
    injector.get<UserProfileCubit>().fetchUserProfile(widget.userId);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserProfileCubit, UserProfileState>(
      bloc: injector.get<UserProfileCubit>(),
      listener: (context, state) {
        state.maybeWhen(
          profileLoaded: (TalkamUser talkAmUser) {
            _talkamUser = talkAmUser;
            userName = _talkamUser.username;
            setState(() {});
          },
          orElse: () {},
        );
      },
      builder: (context, state) {
        return Scaffold(
          appBar: CustomAppBar(
            padding: const EdgeInsets.all(0.0),
            tittleText: userName ?? "",
            centerTile: false,
            showDivider: true,
            actions: const [
              // Padding(
              //   padding: EdgeInsets.only(right: 10.w),
              //   child: GestureDetector(
              //     onTap: () {
              //       context.pushNamed(PageUrl.settingsScreen);
              //     },
              //     child: SvgPicture.asset(
              //       Assets.images.svgs.icSetting,
              //     ),
              //   ),
              // )
            ],
          ),
          body: SafeArea(
            child: state.maybeWhen(
                profileLoading: () =>
                    Center(child: CustomDialogs.getLoading(size: 50)),
                getProfileError: () => const SizedBox(),
                orElse: () {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding:
                            EdgeInsets.only(top: 20.h, right: 16.w, left: 16.w),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ImageWidget(
                              width: 80.w,
                              height: 80.w,
                              shape: BoxShape.circle,
                              canPreview: true,
                              fit: BoxFit.cover,
                              imageUrl:
                                  _talkamUser.avatar ?? Assets.images.svgs.user,
                            ),
                            10.horizontalSpace,
                            Padding(
                              padding: EdgeInsets.only(top: 12.0.h),
                              child: TextView(
                                text: _talkamUser.username,
                                fontWeight: FontWeight.w600,
                                color: Pallets.boldBlackV2,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 24.h, left: 13.w),
                        child: Row(
                          children: [
                            ..._ProfileTabOptions.values.map((tabOption) {
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: ProfileTabBar(
                                  key: Key(tabOption.title),
                                  useExpandedAsParent: false,
                                  title: tabOption.title,
                                  isSelected: tabOption == _selectedTab,
                                  onTap: () {
                                    _selectedTab = tabOption;
                                    _pageController.jumpToPage(tabOption.index);
                                    setState(() {});
                                  },
                                ),
                              );
                            })
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 6.0.h),
                        child: Container(height: 1, color: Pallets.borderGrey),
                      ),
                      Expanded(
                        child: PageView(
                          controller: _pageController,
                          onPageChanged: (int index) {
                            _selectedTab = index == 0
                                ? _ProfileTabOptions.posts
                                : index == 1
                                    ? _ProfileTabOptions.comments
                                    : _ProfileTabOptions.upVotes;
                            setState(() {});
                          },
                          children: [
                            UserProfilePostTab(
                              key: const PageStorageKey(
                                  _ProfileTabOptions.posts),
                              userId: widget.userId,
                            ),
                            UserProfileCommentsTab(
                              key: const PageStorageKey(
                                  _ProfileTabOptions.comments),
                              userID: widget.userId,
                            ),
                            UserProfileUpvotesTab(
                              key: const PageStorageKey(
                                  _ProfileTabOptions.upVotes),
                              userId: widget.userId,
                            ),
                          ],
                        ),
                      )
                    ],
                  );
                }),
          ),
        );
      },
    );
  }
}
