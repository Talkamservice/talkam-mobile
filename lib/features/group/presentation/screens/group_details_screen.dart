import 'package:flutter/material.dart';
import 'package:talkam/common/widgets/custom_appbar.dart';
import 'package:talkam/common/widgets/image_widget.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/constants/package_exports.dart';
import 'package:talkam/core/theme/pallets.dart';
import 'package:talkam/core/utils/extensions/context_extension.dart';
import 'package:talkam/features/group/presentation/tabs/group_members_tab.dart';
import 'package:talkam/features/group/presentation/tabs/group_rules_tab.dart';
import 'package:talkam/features/group/presentation/tabs/groups_about_tab.dart';
import 'package:talkam/features/group/presentation/widgets/group_details_header.dart';
import 'package:talkam/features/home/presentation/screens/home_screen.dart';
import 'package:talkam/gen/assets.gen.dart';

class GroupDetailsScreen extends StatefulWidget {
  const GroupDetailsScreen({super.key});

  @override
  State<GroupDetailsScreen> createState() => _GroupDetailsScreenState();
}

class _GroupDetailsScreenState extends State<GroupDetailsScreen> {
  final tabItems = [
    TabItemModel(imagePath: Assets.images.svgs.icfeatured, tittle: "Rules"),
    TabItemModel(imagePath: Assets.images.svgs.icTrending, tittle: "Members"),
    TabItemModel(imagePath: Assets.images.svgs.icTrending, tittle: "About"),
  ];
  int selecteIndex = 0;
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colorScheme.surface,
      appBar: CustomAppBar(
        showDivider: true,
        bgColor: context.colorScheme.surface,
        leadingWidth: 40,
        tittle: Row(
          children: [
            ImageWidget(imageUrl: Assets.images.png.sports.path),
            11.horizontalSpace,
            const TextView(
              text: "Dating Advice",
              fontSize: 18,
              fontWeight: FontWeight.w700,
            )
          ],
        ),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert))
        ],
      ),
      body: DefaultTabController(
        length: 3,
        child: NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return [
                const SliverToBoxAdapter(
                  child: Column(
                    children: [
                      GroupDetailsHeader(),

                      Divider(),
                    ],
                  ),
                )
              ];
            },
            body: Column(
              children: [
                Container(
                  color: context.colorScheme.surface,
                  width: 1.sw,
                  child: Center(
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
                      children: const [
                        GroupRulesTab(),
                        GroupMembersTab(),
                        GroupsAboutTab()
                      ],
                    ),
                  ),
                )
              ],
            )),
      ),
    );
  }
}

ButtonStyle outlinedButtonStyle() {
  return TextButton.styleFrom(
      backgroundColor: Pallets.borderGrey.withOpacity(0.1),
      shape: const StadiumBorder(side: BorderSide(color: Pallets.borderGrey)),
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 10));
}
