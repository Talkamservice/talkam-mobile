import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/utils/extensions/context_extension.dart';
import 'package:talkam/features/components/talkam_tab_bar.dart';
import 'package:talkam/features/post/presentation/widgets/select_category_sheet.dart';
import 'package:talkam/features/post/presentation/widgets/select_group_tab.dart';

enum _CategoryTabOptions {
  subcategories,
  groups,
  ;

  String get title {
    switch (this) {
      case _CategoryTabOptions.subcategories:
        return "Categories";
      case _CategoryTabOptions.groups:
        return "Groups";
    }
  }
}

class CategoryGroupsSheet extends StatefulWidget {
  const CategoryGroupsSheet({super.key});

  @override
  State<CategoryGroupsSheet> createState() => _CategoryGroupsSheetState();
}

class _CategoryGroupsSheetState extends State<CategoryGroupsSheet> {
  _CategoryTabOptions _selectedTab = _CategoryTabOptions.subcategories;
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 0.8.sh,
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
          color: context.theme.cardColor,
          borderRadius: const BorderRadius.only(
              topRight: Radius.circular(20), topLeft: Radius.circular(20))),
      child: Column(
        children: [
          16.verticalSpace,
          Row(
            children: [
              const Expanded(
                child: TextView(
                  text: "Select sub-category or group",
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
              IconButton(
                  onPressed: () {
                    context.pop();
                  },
                  icon: const Icon(Icons.close))
            ],
          ),
          const Divider(
            thickness: 1,
          ),
          Row(
            children: [
              ..._CategoryTabOptions.values.map((tabOption) {
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
              }),
            ],
          ),
          16.verticalSpace,
          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: (int index) {
                _selectedTab = index == 0
                    ? _CategoryTabOptions.subcategories
                    : _CategoryTabOptions.groups;
                setState(() {});
              },
              children: const [SelectCategoryTab(), SelectGroupTab()],
            ),
          )
        ],
      ),
    );
  }
}
