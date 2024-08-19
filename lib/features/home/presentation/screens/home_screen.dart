import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talkam/common/widgets/image_widget.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/constants/package_exports.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/core/navigation/route_url.dart';
import 'package:talkam/core/services/data/session_manager.dart';
import 'package:talkam/core/theme/pallets.dart';
import 'package:talkam/core/utils/extensions/context_extension.dart';
import 'package:talkam/core/utils/guest_user_helper.dart';
import 'package:talkam/features/home/presentation/bloc/drawer/drawer_cubit.dart';
import 'package:talkam/features/home/presentation/screens/featured_screen.dart';
import 'package:talkam/features/home/presentation/screens/recent_screen.dart';
import 'package:talkam/features/home/presentation/screens/trending_screen.dart';
import 'package:talkam/features/profile/presentation/bloc/profile_bloc/profile_bloc.dart';
import 'package:talkam/gen/assets.gen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PageController _pageController = PageController();
  final tabItems = [
    TabItemModel(imagePath: Assets.images.svgs.icfeatured, tittle: "Featured"),
    TabItemModel(imagePath: Assets.images.svgs.icTrending, tittle: "Trending"),
    TabItemModel(imagePath: Assets.images.svgs.icNew, tittle: "Recent"),
  ];

  int selecteIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 3,
        child: SafeArea(
          child: Column(
            children: [
              const HomeAppBar(),
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
                      top: 16,
                      bottom: 0,
                    ),
                    child: TabBar(
                        tabAlignment: TabAlignment.center,
                        indicatorColor: context.colorScheme.primary,
                        indicatorSize: TabBarIndicatorSize.label,
                        indicatorWeight: 3,
                        onTap: (value) {
                          selecteIndex = value;
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
              Container(
                color: Pallets.grey90,
                height: 1,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: PageView(
                    controller: _pageController,
                    physics: const NeverScrollableScrollPhysics(),
                    onPageChanged: (int index) {
                      // setState(() {});
                    },
                    children: const [
                      FeaturedScreen(),
                      TrendingScreen(),
                      RecentScreen(),
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
    return Container(
      color: context.colorScheme.surface,
      child: Padding(
        padding: const EdgeInsets.only(top: 20, left: 1, right: 18),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            IconButton(
                onPressed: () {
                  context.read<DrawerCubit>().closeDrawer();
                  context.read<DrawerCubit>().openDrawer();
/**/
                },
                icon: Icon(
                  Icons.menu_outlined,
                  color: context.colorScheme.onSurface,
                )),
            ImageWidget(imageUrl: Assets.images.svgs.logo2),
            const Spacer(),
            InkWell(
              onTap: () {
                // context.goNamed(PageUrl.onboardingIntro);

                context.pushNamed(PageUrl.notificationScreen);
              },
              child: ImageWidget(
                imageUrl: Assets.images.svgs.notification,
                onTap: () {
                  context.pushNamed(PageUrl.notificationScreen);
                },
              ),
            ),
            20.horizontalSpace,

            GuestUserHelper.guestUserWidget(
                widget: ImageWidget(
              imageUrl: injector.get<ProfileBloc>().appUser?.avatar ??
                  Assets.images.svgs.uploadAvatar,
              size: 40,
              onTap: () {
                context.pushNamed(PageUrl.profileScreen);
              },
            )),

            // InkWell(
            //   onTap: () {
            //     // context.pushNamed(PageUrl.notifications);
            //   },
            //   child: SessionManager.instance.isLoggedIn
            //       ? ImageWidget(
            //           imageUrl: injector.get<ProfileBloc>().appUser?.avatar ?? Assets.images.svgs.uploadAvatar,
            //           size: 40,
            //           onTap: () {
            //             context.pushNamed(PageUrl.profileScreen);
            //           },
            //         )
            //       : ImageWidget(
            //           imageUrl: injector.get<ProfileBloc>().appUser?.avatar ?? Assets.images.svgs.profile,
            //           onTap: () {},
            //         ),
            // ),
          ],
        ),
      ),
    );
  }
}

class TabItemModel {
  String imagePath;
  String tittle;

  TabItemModel({required this.imagePath, required this.tittle});
}
