import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:talkam/common/widgets/custom_appbar.dart';
import 'package:talkam/core/navigation/route_url.dart';
import 'package:talkam/core/theme/pallets.dart';
import 'package:talkam/features/profile/presentation/screens/tabs/profile_posts_tab.dart';
import 'package:talkam/features/profile/presentation/widgets/profile_tab_bar.dart';
import 'package:talkam/features/search/presentation/screens/groups_result_tab.dart';
import 'package:talkam/features/search/presentation/screens/post_search_result_tab.dart';
import 'package:talkam/gen/assets.gen.dart';

enum _SearchTabOptions {
  posts,
  groups,
  media;

  String get title {
    switch (this) {
      case posts:
        return "Posts";

      case groups:
        return "Groups";

      case media:
        return "Media";
    }
  }
}

class SearchResultScreen extends StatefulWidget {
  const SearchResultScreen({super.key, required this.query});

  final String query;

  @override
  State<SearchResultScreen> createState() => _SearchResultScreenState();
}

class _SearchResultScreenState extends State<SearchResultScreen> {
  _SearchTabOptions _selectedTab = _SearchTabOptions.posts;
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        padding: EdgeInsets.all(0.0),
        tittleText: "champions league",
        centerTile: false,
        showDivider: false,
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 24.h, left: 13.w),
            child: Row(
              children: [
                ..._SearchTabOptions.values.map((tabOption) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
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
                    ? _SearchTabOptions.posts
                    : index == 1
                        ? _SearchTabOptions.groups
                        : _SearchTabOptions.media;
                setState(() {});
              },
              children: [
                const PostSearchResultTab(),
                const GroupsResultTab(),
                Container(),
              ],
            ),
          )
        ],
      ),
    );
  }

  //
  // @override
  // void initState() {
  //   injector.get<ProfileScreenCubit>().fetchUserProfile();
  //   super.initState();
  // }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
