import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:talkam/common/widgets/image_widget.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/constants/package_exports.dart';
import 'package:talkam/core/theme/pallets.dart';
import 'package:talkam/core/utils/extensions/context_extension.dart';
import 'package:talkam/features/home/presentation/screens/featured_screen.dart';
import 'package:talkam/features/home/presentation/screens/home_screen.dart';
import 'package:talkam/features/home/presentation/screens/recent_screen.dart';
import 'package:talkam/features/home/presentation/screens/trending_screen.dart';
import 'package:talkam/features/post/presentation/screens/featured_post_by_category_screen.dart';
import 'package:talkam/features/post/presentation/screens/recent_post_by_category_screen.dart';
import 'package:talkam/features/post/presentation/screens/trending_post_by_category_screen.dart';
import 'package:talkam/gen/assets.gen.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  final PageController _pageController = PageController();
  final tabItems = [
    HomeTabItemModel(
        imagePath: Assets.images.svgs.icfeatured, tittle: "Featured"),
    HomeTabItemModel(
        imagePath: Assets.images.svgs.icTrending, tittle: "Trending"),
    HomeTabItemModel(imagePath: Assets.images.svgs.icNew, tittle: "Recent"),
  ];

  int selecteIndex = 0;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return [
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    Container(
                      height: 200.h,
                      padding: EdgeInsets.all(16),
                      width: 1.sw,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage(
                                  Assets.images.jpegs.football.path))),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          40.verticalSpace,
                          Row(
                            children: [
                              ImageWidget(
                                imageUrl: Assets.images.svgs.arrowLeft,
                                color: Pallets.white,
                              ),
                              Spacer(),
                              TextButton(
                                  style: TextButton.styleFrom(
                                      backgroundColor: Pallets.primary,
                                      foregroundColor: Pallets.white,
                                      shape: StadiumBorder()),
                                  onPressed: () {},
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.add,
                                        color: Pallets.white,
                                      ),
                                      10.horizontalSpace,
                                      TextView(text: "Follow"),
                                    ],
                                  )),
                              17.horizontalSpace,
                              Icon(
                                Icons.info_outline,
                                color: Pallets.white,
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    10.verticalSpace,
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 14.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              ImageWidget(
                                  size: 50,
                                  fit: BoxFit.cover,
                                  imageUrl: Assets.images.png.mancity.path),
                              10.horizontalSpace,
                              Expanded(
                                child: const Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    TextView(
                                      text: "Sports",
                                      fontSize: 16,
                                    ),
                                    TextView(
                                      text: "3.7k Followers",
                                      fontSize: 12,
                                    ),
                                  ],
                                ),
                              ),
                              TextButton(
                                  style: TextButton.styleFrom(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 8),
                                      shape: StadiumBorder(
                                          side: BorderSide(
                                              color: Pallets.grey75))),
                                  onPressed: () {},
                                  child: Row(
                                    children: [
                                      ImageWidget(
                                          imageUrl: Assets.images.svgs.rules),
                                      9.horizontalSpace,
                                      TextView(text: "Rules")
                                    ],
                                  ))
                            ],
                          ),
                          21.verticalSpace,
                          Wrap(
                            spacing: 4,
                            runSpacing: 8,
                            children: List.generate(
                              4,
                              (index) => Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100.r),
                                    border: Border.all(
                                      width: 1,
                                      color: Pallets.borderGrey,
                                    )),
                                child: TextView(text: "Sports"),
                              ),
                            ),
                          ),
                          15.verticalSpace,
                        ],
                      ),
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
                  ],
                ),
              )
            ];
          },
          body: Column(
            children: [
              Expanded(
                child: PageView(
                  controller: _pageController,
                  physics: const NeverScrollableScrollPhysics(),
                  onPageChanged: (int index) {
                    // setState(() {});
                  },
                  children: const [
                    FeaturedPostByCategoryScreen(),
                    TrendingPostByCategoryScreen(),
                    RecentPostByCategoryScreen(),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
