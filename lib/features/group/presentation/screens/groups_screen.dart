import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talkam/common/widgets/image_widget.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/constants/package_exports.dart';
import 'package:talkam/core/theme/pallets.dart';
import 'package:talkam/core/utils/extensions/context_extension.dart';
import 'package:talkam/features/components/talkam_tab_bar.dart';
import 'package:talkam/features/group/presentation/tabs/group_explore_tab.dart';
import 'package:talkam/features/group/presentation/tabs/group_recent_tab.dart';
import 'package:talkam/features/home/presentation/bloc/drawer/drawer_cubit.dart';
import 'package:talkam/gen/assets.gen.dart';

enum _GroupsTabOptions {
  recent,
  explore;

  String get title {
    switch (this) {
      case recent:
        return "Recent";

      case explore:
        return "Explore";

      default:
        return "";
    }
  }
}

class GroupsScreen extends StatefulWidget {
  const GroupsScreen({super.key});

  @override
  State<GroupsScreen> createState() => _GroupsScreenState();
}

class _GroupsScreenState extends State<GroupsScreen> {
  _GroupsTabOptions _selectedTab = _GroupsTabOptions.recent;
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: Padding(
          padding: const EdgeInsets.only(top: 40, left: 16, right: 16),
          child: Row(
            children: [
              IconButton(
                onPressed: () {
                  context.read<DrawerCubit>().closeDrawer();
                  context.read<DrawerCubit>().openDrawer();
                },
                icon: Icon(
                  Icons.menu_outlined,
                  color: context.colorScheme.onSurface,
                ),
              ),
              TextView(
                text: "Groups",
                fontSize: 18.sp,
                fontWeight: FontWeight.w700,
              ),
              const Spacer(),
              ImageWidget(imageUrl: Assets.images.svgs.groupsAdd),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(height: 1.0, color: Pallets.borderGrey),
            Padding(
              padding: EdgeInsets.only(top: 24.h, left: 13.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ..._GroupsTabOptions.values.map((tabOption) {
                    return Expanded(
                      child: TalkamTabBar(
                        key: Key(tabOption.title),
                        useExpandedAsParent: false,
                        title: tabOption.title,
                        isSelected: tabOption == _selectedTab,
                        onTap: () {
                          setState(() {
                            _selectedTab = tabOption;
                            _pageController.jumpToPage(tabOption.index);
                          });
                        },
                      ),
                    );
                  })
                ],
              ),
            ),
            Container(height: 1.0, color: Pallets.borderGrey),
            Expanded(
              child: PageView(
                controller: _pageController,
                onPageChanged: (int index) {
                  _selectedTab = index == 0 ? _GroupsTabOptions.recent : _GroupsTabOptions.explore;
                  setState(() {});
                },
                children: const [
                  GroupRecentTab(
                    key: PageStorageKey(_GroupsTabOptions.recent),
                  ),
                  GroupExploreTab(
                    key: PageStorageKey(_GroupsTabOptions.explore),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
