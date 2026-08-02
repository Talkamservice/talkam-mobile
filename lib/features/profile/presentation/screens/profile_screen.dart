import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:talkam/common/widgets/custom_appbar.dart';
import 'package:talkam/common/widgets/custom_dialogs.dart';
import 'package:talkam/common/widgets/error_widget.dart';
import 'package:talkam/common/widgets/image_widget.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/constants/package_exports.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/core/navigation/route_url.dart';
import 'package:talkam/core/services/firebase/remote_config_service.dart';
import 'package:talkam/core/theme/pallets.dart';
import 'package:talkam/features/authentication/data/models/auth_response.dart';
import 'package:talkam/features/profile/presentation/bloc/profile_bloc/profile_bloc.dart';
import 'package:talkam/features/profile/presentation/bloc/profile_screen_cubit/profile_screen_cubit.dart';
import 'package:talkam/features/profile/presentation/screens/tabs/profile_comments_tab.dart';
import 'package:talkam/features/profile/presentation/screens/tabs/profile_posts_tab.dart';
import 'package:talkam/features/profile/presentation/screens/tabs/profile_upvotes_tab.dart';
import 'package:talkam/features/components/talkam_tab_bar.dart';
import 'package:talkam/features/profile/presentation/screens/user_profile_tabs/user_media_tab.dart';
import 'package:talkam/features/profile/presentation/widgets/my_profile_sheet.dart';
import 'package:talkam/features/subscription/presentation/widgets/subscription_plan_card.dart';
import 'package:talkam/features/subscription/utils/subscription_helper.dart';
import 'package:talkam/gen/assets.gen.dart';

enum _ProfileTabOptions {
  posts,
  comments,
  upVotes,
  media;

  String get title {
    switch (this) {
      case posts:
        return "Posts";

      case comments:
        return "Comments";

      case upVotes:
        return "Upvotes";
      case media:
        return "Media";
    }
  }
}

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  _ProfileTabOptions _selectedTab = _ProfileTabOptions.posts;
  final PageController _pageController = PageController();
  TalkamUser _talkamUser = TalkamUser.forTest();

  @override
  void initState() {
    injector.get<ProfileScreenCubit>().fetchUserProfile();
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileScreenCubit, ProfileScreenState>(
      bloc: injector.get<ProfileScreenCubit>(),
      listener: (context, state) {
        state.maybeWhen(
          loaded: (TalkamUser talkAmUser) {
            _talkamUser = talkAmUser;
            setState(() {});
          },
          orElse: () {},
        );
      },
      builder: (context, state) {
        return Scaffold(
          body: SafeArea(
            child: state.maybeWhen(
                loading: () => Center(child: CustomDialogs.getLoading(size: 50)),
                error: () => AppErrorWidget(
                      onTap: () {
                        injector.get<ProfileScreenCubit>().fetchUserProfile();
                      },
                    ),
                orElse: () {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BlocBuilder<ProfileBloc, ProfileState>(
                        bloc: injector.get(),
                        builder: (context, state) {
                          return Padding(
                            padding: EdgeInsets.only(top: 20.h, right: 16.w, left: 16.w),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ImageWidget(
                                  width: 80.w,
                                  height: 80.w,
                                  canPreview: true,
                                  fit: BoxFit.scaleDown,
                                  shape: BoxShape.circle,
                                  imageUrl: injector.get<ProfileBloc>().appUser?.avatar ?? Assets.images.svgs.user,
                                ),
                                10.horizontalSpace,
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(top: 12.0.h),

                                      child: Row(

                                        crossAxisAlignment: CrossAxisAlignment.center,

                                        children: [
                                          TextView(
                                            text: injector.get<ProfileBloc>().appUser?.username ?? "",
                                            fontWeight: FontWeight.w700,
                                            fontSize: 16,
                                            color: Pallets.boldBlackV2,
                                          ),

                                          5.horizontalSpace,
                                          TalkamSubscriptionWidget(subscribedUserWidget:   ImageWidget(
                                          size: 20,
                                            canPreview: false,


                                            imageUrl:  Assets.images.svgs.blueThick,
                                          ), )
                                        ],
                                      ),
                                    ),
                                    8.verticalSpace,
                                    if(subscriptionEnabled)
                                    TalkamSubscriptionWidget(
                                      subscribedUserWidget: 0.verticalSpace,
                                      freemiumUserWidget: InkWell(
                                        onTap:(){
                                          context.pushNamed(PageUrl.subscriptionScreen);

                                        },
                                        child: Container(

                                          padding:const EdgeInsets.all(5),
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(22), border: Border.all(color: Pallets.lightBlue), gradient: blueWhiteGradient),

                                          child: Row(
                                            children: [
                                              ImageWidget(imageUrl: Assets.images.svgs.blueThick,size: 16,),
                                              3.horizontalSpace,
                                              const TextView(
                                                  fontSize: 10,
                                                  text: "Subscribe to TalkAM plus")
                                            ],
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                const Spacer(),
                                IconButton(
                                    onPressed: () {
                                      CustomDialogs.showBottomSheet(context, MyProfileSheet());
                                    },
                                    icon: const Icon(Icons.more_vert_rounded))
                              ],
                            ),
                          );
                        },
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 24.h, left: 13.w),
                        child: Row(
                          children: [
                            ..._ProfileTabOptions.values.map((tabOption) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                child: TalkamTabBar(
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
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: PageView(
                            controller: _pageController,
                            onPageChanged: (int index) {
                              _selectedTab = index == 0
                                  ? _ProfileTabOptions.posts
                                  : index == 1
                                      ? _ProfileTabOptions.comments
                                      : index == 2
                                          ? _ProfileTabOptions.upVotes
                                          : _ProfileTabOptions.media;
                              setState(() {});
                            },
                            children: [
                              const ProfilePostTab(
                                key: PageStorageKey(_ProfileTabOptions.posts),
                              ),
                              const ProfileCommentsTab(
                                key: PageStorageKey(_ProfileTabOptions.comments),
                              ),
                              const ProfileUpvotesTab(
                                key: PageStorageKey(_ProfileTabOptions.upVotes),
                              ),
                              UserProfileMediaTab(
                                key: const PageStorageKey(_ProfileTabOptions.media),
                                userId: _talkamUser.id.toString(),
                              ),
                            ],
                          ),
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
  bool get subscriptionEnabled => RemoteConfigsService.getBool(RemoteConfigKeys.SUBSCRIPTION_ENABLED) ?? false;

}
