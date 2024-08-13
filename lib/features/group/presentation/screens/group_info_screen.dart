import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:talkam/common/widgets/image_widget.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/navigation/route_url.dart';
import 'package:talkam/core/theme/pallets.dart';
import 'package:talkam/core/utils/extensions/context_extension.dart';
import 'package:talkam/features/group/presentation/tabs/group_media_tab.dart';
import 'package:talkam/features/group/presentation/tabs/group_posts_tab.dart';
import 'package:talkam/features/group/presentation/widgets/group_app_bar.dart';
import 'package:talkam/features/home/presentation/screens/home_screen.dart';
import 'package:talkam/features/search/data/models/get_group_response.dart';
import 'package:talkam/gen/assets.gen.dart';

class GroupInfoScreen extends StatefulWidget {
  const GroupInfoScreen({super.key, required this.group});

  final TalkamGroup group;

  @override
  State<GroupInfoScreen> createState() => _GroupInfoScreenState();
}

class _GroupInfoScreenState extends State<GroupInfoScreen> {
  final tabItems = [
    TabItemModel(imagePath: Assets.images.svgs.icfeatured, tittle: "Posts"),
    TabItemModel(imagePath: Assets.images.svgs.icTrending, tittle: "Media"),
  ];
  int selecteIndex = 0;
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        foregroundColor: Pallets.white,
        backgroundColor: Pallets.primary,
        onPressed: () {
          context.pushNamed(PageUrl.createGroupScreen);
        },
        child: const Icon(Icons.add),
      ),
      body: DefaultTabController(
        length: 2,
        child: NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) => [
                  SliverToBoxAdapter(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const GroupInfoAppBar(),
                        10.verticalSpace,
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.0),
                          child: GroupOverViewSection(),
                        ),
                        10.verticalSpace,
                      ],
                    ),
                  )
                ],
            body: Column(
              children: [
                Container(
                  color: context.colorScheme.surface,
                  width: 1.sw,
                  child: Center(
                    child: TabBar(
                        padding: EdgeInsets.zero,
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
                          (index) => Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Tab(
                              child: Row(
                                children: [
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
                          ),
                        ).toList()),
                  ),
                ),
                Container(
                  color: Pallets.grey90,
                  height: 1,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: PageView(
                      controller: _pageController,
                      physics: const NeverScrollableScrollPhysics(),
                      onPageChanged: (int index) {
                        // setState(() {});
                      },
                      children: const [GroupPostsTab(), GroupMediaTab()],
                    ),
                  ),
                )
              ],
            )),
      ),
    );
  }
}

class GroupOverViewSection extends StatelessWidget {
  const GroupOverViewSection({super.key, this.showAbout = true});

  final bool? showAbout;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            ImageWidget(
              imageUrl: Assets.images.png.sports.path,
              size: 40,
              fit: BoxFit.cover,
            ),
            10.horizontalSpace,
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextView(
                    text: "Dating Advice",
                    fontSize: 16,
                  ),
                  // 2.verticalSpace,
                  TextView(
                    text: "3.7K Followers",
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                ],
              ),
            ),
            if (showAbout!)
              TextButton(
                  style: TextButton.styleFrom(
                      backgroundColor: Pallets.borderGrey.withOpacity(0.2),
                      shape: const StadiumBorder(
                          side: BorderSide(color: Pallets.borderGrey)),
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 10)),
                  onPressed: () {
                    context.pushNamed(PageUrl.groupDetailsScreen);
                    // CustomDialogs.showBottomSheet(context, const RulesSheet());
                  },
                  child: Row(
                    children: [
                      ImageWidget(imageUrl: Assets.images.svgs.infoCircle),
                      10.horizontalSpace,
                      const TextView(
                        text: "About",
                        fontSize: 14,
                        // color: context.colorScheme.onSurface,
                        fontWeight: FontWeight.w600,
                      ),
                    ],
                  ))
          ],
        ),
        13.verticalSpace,
        const TextView(
          text:
              "We’re a small group of people seeking to help the next person with dating advice and counsel. Please be kind.",
        )
      ],
    );
  }
}
