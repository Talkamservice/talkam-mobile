import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talkam/common/widgets/image_widget.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/constants/package_exports.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/core/navigation/route_url.dart';
import 'package:talkam/core/theme/pallets.dart';
import 'package:talkam/core/utils/extensions/context_extension.dart';
import 'package:talkam/core/utils/guest_user_helper.dart';
import 'package:talkam/features/group/presentation/blocs/groups_cubit/groups_cubit.dart';
import 'package:talkam/features/group/presentation/tabs/group_explore_tab.dart';
import 'package:talkam/features/group/presentation/tabs/group_recent_tab.dart';
import 'package:talkam/features/group/presentation/tabs/my_groups_tab.dart';
import 'package:talkam/features/home/presentation/bloc/drawer/drawer_cubit.dart';
import 'package:talkam/features/home/presentation/screens/home_screen.dart';
import 'package:talkam/gen/assets.gen.dart';

enum _GroupsTabOptions {
  recent,
  explore,
  myGroups;


  String get title {
    switch (this) {
      case recent:
        return "Recent";

      case explore:
        return "Explore";
        case myGroups:
        return "My Groups";

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

class _GroupsScreenState extends State<GroupsScreen>  with SingleTickerProviderStateMixin {

  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  final tabItems = [
    TabItemModel(imagePath: Assets.images.svgs.icfeatured, tittle: "Recent"),
    TabItemModel(imagePath: Assets.images.svgs.icTrending, tittle: "Explore"),
    TabItemModel(imagePath: Assets.images.svgs.icTrending, tittle: "My Groups"),
  ];
  int selecteIndex = 0;
  final PageController _pageController = PageController();

  final bloc = GroupsCubit(injector.get());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [

          const GroupsAppBar(),

          // const Divider(
          //   indent: 0,
          //   height: 2,
          // ),
          2.verticalSpace,
          Container(
            color: context.colorScheme.surface,
            width: 1.sw,
            child: Center(
              child: TabBar(
                  tabAlignment: TabAlignment.center,
                  indicatorColor: context.colorScheme.primary,
                  indicatorSize: TabBarIndicatorSize.label,
                  controller: _tabController,
                  indicatorWeight: 3,
                  onTap: (value) {
                    selecteIndex = value;
                    _pageController.jumpToPage(value);
                    setState(() {});
                  },
                  tabs: List.generate(
                    tabItems.length,
                    (index) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
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
              child: BlocConsumer<GroupsCubit, GroupsState>(
                bloc: bloc,
                listener: (context, state) {},
                builder: (context, state) {

                  return PageView(
                    controller: _pageController,
                    // physics: const NeverScrollableScrollPhysics(),
                    onPageChanged: (int index) {

                      _tabController.animateTo(index);
                      selecteIndex = index;
                      setState(() {});

                      // setState(() {});
                    },
                    children: const [
                      GroupRecentTab(),
                      GroupExploreTab(),
                      MyGroupsTab(),
                    ],
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}

class GroupsAppBar extends StatelessWidget {
  const GroupsAppBar({super.key});

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
            const TextView(
              text: "Groups",
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
            const Spacer(),
            20.horizontalSpace,
            GuestUserHelper.guestUserWidget(
              widget: InkWell(
                onTap: () {
                  context.pushNamed(PageUrl.createGroupScreen);
                },
                child: ImageWidget(
                  imageUrl: Assets.images.svgs.groupsAdd,
                  onTap: () {
                    context.pushNamed(PageUrl.createGroupScreen);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
