import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:talkam/common/widgets/image_widget.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/constants/package_exports.dart';
import 'package:talkam/core/theme/pallets.dart';
import 'package:talkam/core/utils/extensions/context_extension.dart';
import 'package:talkam/features/home/presentation/screens/home_screen.dart';
import 'package:talkam/features/post/data/models/get_categories_response.dart';
import 'package:talkam/features/post/presentation/screens/featured_post_by_category_screen.dart';
import 'package:talkam/features/post/presentation/screens/recent_post_by_category_screen.dart';
import 'package:talkam/features/post/presentation/screens/trending_post_by_category_screen.dart';
import 'package:talkam/features/post/presentation/widgets/categories_screen_header.dart';
import 'package:talkam/gen/assets.gen.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key, required this.category});

  final PostCategory category;

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  final PageController _pageController = PageController();
  final tabItems = [
    TabItemModel(
        imagePath: Assets.images.svgs.icfeatured, tittle: "Featured"),
    TabItemModel(
        imagePath: Assets.images.svgs.icTrending, tittle: "Trending"),
    TabItemModel(imagePath: Assets.images.svgs.icNew, tittle: "Recent"),
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
                    CategoriesScreenHeader(category: widget.category),
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
                    4.verticalSpace,
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
                  children: [
                    FeaturedPostByCategoryScreen(
                      categoryId: widget.category.id.toString(),
                    ),
                    TrendingPostByCategoryScreen(
                      categoryId: widget.category.id.toString(),
                    ),
                    RecentPostByCategoryScreen(
                      categoryId: widget.category.id.toString(),
                    ),
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
