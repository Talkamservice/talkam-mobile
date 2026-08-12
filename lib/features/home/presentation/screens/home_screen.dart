import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talkam/common/widgets/image_widget.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/constants/package_exports.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/core/navigation/route_url.dart';
import 'package:talkam/core/services/firebase/remote_config_service.dart';
import 'package:talkam/core/theme/pallets.dart';
import 'package:talkam/core/utils/extensions/context_extension.dart';
import 'package:talkam/core/utils/guest_user_helper.dart';
import 'package:talkam/features/home/presentation/bloc/drawer/drawer_cubit.dart';
import 'package:talkam/features/home/presentation/screens/for_you_screen.dart';
import 'package:talkam/features/home/presentation/screens/trending_screen.dart';
import 'package:talkam/features/mood_check/presentation/bloc/mood_check_cubit.dart';
import 'package:talkam/features/mood_check/presentation/widgets/mood_check_dialog.dart';
import 'package:talkam/features/notifications/presentation/bloc/notification_bloc.dart';
import 'package:talkam/features/notifications/presentation/widgets/announcements_carousel.dart';
import 'package:talkam/features/notifications/presentation/widgets/notification_icon.dart';
import 'package:talkam/features/post/presentation/bloc/post/post_bloc.dart';
import 'package:talkam/features/profile/presentation/bloc/connections_summary_cubit/connections_summary_cubit.dart';
import 'package:talkam/features/profile/presentation/bloc/profile_bloc/profile_bloc.dart';
import 'package:talkam/features/subscription/utils/subscription_helper.dart';
import 'package:talkam/gen/assets.gen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  final PageController _pageController = PageController();
  final tabItems = [
    TabItemModel(imagePath: Assets.images.svgs.icfeatured, tittle: "For You"),
    TabItemModel(imagePath: Assets.images.svgs.icTrending, tittle: "Trending"),
  ];

  int selecteIndex = 0;

  late TabController _tabController;
  final _moodCheckCubit = injector.get<MoodCheckCubit>();

  @override
  void initState() {
    injector.get<NotificationsBloc>().add(GetNotificationsStatsEvent());
    injector.get<NotificationsBloc>().add(const GetAnnouncementsEvent());
    injector.get<PostBloc>().add(const PostEvent.getCategories(refresh: true));
    // Prefetched here so the follow counts are already available by the
    // time the drawer is opened, instead of fetching on every open.
    injector.get<ConnectionsSummaryCubit>().fetchCounts();

    _tabController = TabController(length: 2, vsync: this);
    WidgetsBinding.instance
        .addPostFrameCallback((_) => _moodCheckCubit.checkShouldShow());
    super.initState();
  }

  @override
  void dispose() {
    _moodCheckCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<MoodCheckCubit, MoodCheckState>(
      bloc: _moodCheckCubit,
      listener: (context, state) {
        if (state is MoodCheckShouldShow) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (_) => MoodCheckDialog(cubit: _moodCheckCubit),
          );
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              const HomeAppBar(),
              const AnnouncementsCarousel(),
              Container(
                color: Pallets.grey90,
                height: 1,
              ),
              Container(
                color: context.colorScheme.surface,
                width: 1.sw,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.only(
                      // top: 16,
                      bottom: 0,
                    ),
                    child: TabBar(
                        tabAlignment: TabAlignment.center,
                        indicatorColor: context.colorScheme.primary,
                        indicatorSize: TabBarIndicatorSize.label,
                        indicatorWeight: 3,
                        controller: _tabController,
                        onTap: (value) {
                          _pageController.jumpToPage(value);
                          setState(() {});
                        },
                        tabs: List.generate(
                          tabItems.length,
                          (index) => Tab(
                            child: Row(
                              children: [
                                ImageWidget(
                                  imageUrl: tabItems[index].imagePath,
                                  color: selecteIndex == index
                                      ? context.colorScheme.primary
                                      : Pallets.grey,
                                ),
                                8.horizontalSpace,
                                TextView(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                  text: tabItems[index].tittle,
                                  color: selecteIndex == index
                                      ? context.colorScheme.onSurface
                                      : Pallets.grey60,
                                  // fontWeight: isSelected ? FontWeight.w500 : FontWeight.w400,
                                ),
                              ],
                            ),
                          ),
                        ).toList()),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.zero,
                  child: PageView(
                    controller: _pageController,

                    // physics: const NeverScrollableScrollPhysics(),
                    onPageChanged: (int index) {
                      _tabController.animateTo(index);
                      selecteIndex = index;
                      setState(() {});
                    },
                    children: const [
                      ForYouScreen(),
                      TrendingScreen(),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileBloc, ProfileState>(
      bloc: injector.get(),
      listener: (context, state) {},
      builder: (context, state) {
        return Container(
          color: context.colorScheme.surface,
          child: Padding(
            padding: const EdgeInsets.only(top: 10, left: 1, right: 18),
            child: Column(
              children: [
                if (subscriptionEnabled)
                  GuestUserHelper.guestUserWidget(
                    guestWidget: 0.verticalSpace,
                    widget: TalkamSubscriptionWidget(
                      subscribedUserWidget: 0.verticalSpace,
                      freemiumUserWidget: Padding(
                        padding: const EdgeInsets.only(left: 16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            SizedBox(
                              height: 30,
                              child: TextButton(
                                  style: TextButton.styleFrom(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 4, horizontal: 10),
                                      backgroundColor: Pallets.blueBubbleColor,
                                      foregroundColor: Pallets.white,
                                      shape: const StadiumBorder()),
                                  onPressed: () {
                                    context
                                        .pushNamed(PageUrl.subscriptionScreen);
                                  },
                                  child: const TextView(
                                    text: "Upgrade to TalkAM plus",
                                    fontSize: 12,
                                  )),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                14.verticalSpace,
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            context.read<DrawerCubit>().closeDrawer();
                            context.read<DrawerCubit>().openDrawer();
                            /**/
                          },
                          icon: ImageWidget(imageUrl: Assets.images.svgV2.menu),
                        ),
                        ImageWidget(
                          imageUrl: Assets.images.svgs.appIcon,
                          size: 28,
                        ),
                        const SizedBox(width: 4),
                        ImageWidget(
                          imageUrl: Assets.images.svgs.appIconTalkamText,
                          size: 14,
                        ),
                      ],
                    ),
                    const Spacer(),
                    ImageWidget(
                      imageUrl: Assets.images.svgV2.searchIcon,
                      onTap: () {
                        context.pushNamed(
                          PageUrl.searchResultScreen,
                          extra: '',
                        );
                      },
                    ),
                    16.horizontalSpace,
                    const NotificationIcon(),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  bool get subscriptionEnabled =>
      RemoteConfigsService.getBool(RemoteConfigKeys.SUBSCRIPTION_ENABLED) ??
      false;
}

class TabItemModel {
  String imagePath;
  String tittle;

  TabItemModel({required this.imagePath, required this.tittle});
}
