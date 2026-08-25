import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talkam/common/widgets/custom_appbar.dart';
import 'package:talkam/common/widgets/custom_dialogs.dart';
import 'package:talkam/common/widgets/error_widget.dart';
import 'package:talkam/common/widgets/image_widget.dart';
import 'package:talkam/common/widgets/subscribe_button.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/constants/package_exports.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/core/navigation/route_url.dart';
import 'package:talkam/core/theme/pallets.dart';
import 'package:talkam/features/authentication/data/models/auth_response.dart';
import 'package:talkam/features/messaging/data/models/get_conversations_response.dart';
import 'package:talkam/features/messaging/presentation/screens/chat_screen.dart';
import 'package:talkam/features/profile/presentation/bloc/follow_cubit/follow_cubit.dart';
import 'package:talkam/features/profile/presentation/bloc/user_profile_cubit/user_profile_cubit.dart';
import 'package:talkam/features/profile/presentation/screens/user_profile_tabs/user_profile_comments_tab.dart';
import 'package:talkam/features/profile/presentation/screens/user_profile_tabs/user_profile_posts_tab.dart';
import 'package:talkam/features/components/talkam_tab_bar.dart';
import 'package:talkam/features/profile/presentation/widgets/user_profile_actions.dart';
import 'package:talkam/gen/assets.gen.dart';

enum _ProfileTabOptions {
  posts,
  comments;

  String get title {
    switch (this) {
      case posts:
        return "Post";
      case comments:
        return "Comments";
    }
  }
}

class UserProfileScreen extends StatefulWidget {
  UserProfileScreen({super.key, required this.userId});

  String userId;

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  _ProfileTabOptions _selectedTab = _ProfileTabOptions.posts;
  final PageController _pageController = PageController();
  TalkamUser _talkamUser = TalkamUser.forTest();
  var userName;

  final _followCubit = injector.get<FollowCubit>();
  bool _isFollowing = false;

  @override
  void initState() {
    injector.get<UserProfileCubit>().fetchUserProfile(widget.userId);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _followCubit.close();
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
            widget.userId = _talkamUser.id.toString();
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
            actions: [
              if (userName != null)
                IconButton(
                    onPressed: () async {
                      var refresh = await CustomDialogs.showBottomSheet(
                          context,
                          shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.vertical(top: Radius.circular(15)),
                          ),
                          UserProfileActions(
                            user: _talkamUser,
                          ));

                      if (refresh ?? false) {
                        injector
                            .get<UserProfileCubit>()
                            .fetchUserProfile(widget.userId, reload: false);
                      }
                    },
                    icon: const Icon(Icons.more_vert)),
            ],
          ),
          backgroundColor: Colors.white,
          body: SafeArea(
            child: state.maybeWhen(
                profileLoading: () =>
                    Center(child: CustomDialogs.getLoading(size: 50)),
                getProfileError: (e) => AppErrorWidget(
                      message: e,
                      onTap: () => injector
                          .get<UserProfileCubit>()
                          .fetchUserProfile(widget.userId),
                    ),
                orElse: () {
                  if (_talkamUser.isBlocked) {
                    return Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextView(
                            text: "@${_talkamUser.username} is Blocked",
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                          ),
                          10.verticalSpace,
                          const TextView(
                              text:
                                  "Unblock them to view their activities and posts."),
                          60.verticalSpace,
                        ],
                      ),
                    );
                  }

                  if (_talkamUser.status.toLowerCase() == "banned") {
                    return Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextView(
                            text: "@${_talkamUser.username} is Banned",
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                          ),
                          10.verticalSpace,
                          const TextView(
                              text:
                                  "You can view their profile when their account is re-activated"),
                          60.verticalSpace,
                        ],
                      ),
                    );
                  }

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding:
                            EdgeInsets.only(top: 20.h, right: 16.w, left: 16.w),
                        child: _buildHeader(),
                      ),
                      24.verticalSpace,
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        physics: const BouncingScrollPhysics(),
                        padding: EdgeInsets.symmetric(horizontal: 8.w),
                        child: Row(
                          children: _ProfileTabOptions.values.map((tabOption) {
                            return Padding(
                              padding: EdgeInsets.symmetric(horizontal: 12.w),
                              child: TalkamTabBar(
                                key: Key(tabOption.title),
                                useExpandedAsParent: false,
                                title: tabOption.title,
                                indicatorWidth: null,
                                isSelected: tabOption == _selectedTab,
                                onTap: () {
                                  setState(() => _selectedTab = tabOption);
                                  _pageController.jumpToPage(tabOption.index);
                                },
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 6.0.h),
                        child:
                            const Divider(height: 1, color: Pallets.borderGrey),
                      ),
                      Expanded(
                        child: PageView(
                          controller: _pageController,
                          onPageChanged: (int index) {
                            setState(() {
                              _selectedTab = _ProfileTabOptions.values[index];
                            });
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

  /// Vertical avatar/name/handle layout matching the signed-in user's own
  /// `ProfileScreen`, plus a Follow toggle and the existing "Send a message"
  /// action.
  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ImageWidget(
          width: 80.w,
          height: 80.w,
          canPreview: true,
          fit: BoxFit.cover,
          shape: BoxShape.circle,
          imageUrl: _talkamUser.avatar ?? Assets.images.svgs.user,
        ),
        12.verticalSpace,
        Row(
          children: [
            TextView(
              text: _talkamUser.name.isNotEmpty
                  ? _talkamUser.name
                  : _talkamUser.username,
              fontWeight: FontWeight.w700,
              fontSize: 20,
              color: Pallets.boldBlackV2,
            ),
            if (_talkamUser.activeSubscription != null) ...[
              6.horizontalSpace,
              ImageWidget(
                size: 20,
                canPreview: false,
                imageUrl: Assets.images.svgs.blueThick,
              ),
            ],
          ],
        ),
        4.verticalSpace,
        TextView(
          text: "@${_talkamUser.username}",
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: Pallets.grey400,
        ),
        16.verticalSpace,
        Row(
          children: [
            BlocListener<FollowCubit, FollowState>(
              bloc: _followCubit,
              listener: (context, state) {
                state.maybeWhen(
                  orElse: () {},
                  success: (following) =>
                      setState(() => _isFollowing = following),
                  failure: (error) => CustomDialogs.error(error),
                );
              },
              child: SubscribeButton(
                color: _isFollowing ? Pallets.grey60 : Pallets.blueBubbleColor,
                onTap: () => _followCubit.toggleFollow(widget.userId),
                child: TextView(
                  text: _isFollowing ? "Following" : "Follow",
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
            10.horizontalSpace,
            InkWell(
              onTap: () {
                var user = _talkamUser;

                context.pushNamed(PageUrl.chatScreen,
                    extra: ChatScreenParam(
                        user: ConversationUser(
                            id: user.id,
                            name: user.name,
                            avatar: user.avatar,
                            email: user.email,
                            username: user.username)));
              },
              child: Container(
                height: 40.h,
                padding: EdgeInsets.symmetric(horizontal: 14.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(56),
                  border: Border.all(color: Pallets.borderGrey),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ImageWidget(imageUrl: Assets.images.svgs.messageBubbles),
                    4.horizontalSpace,
                    const TextView(text: "Send a message")
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
