import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:talkam/common/widgets/custom_appbar.dart';
import 'package:talkam/common/widgets/custom_dialogs.dart';
import 'package:talkam/common/widgets/error_widget.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/common/widgets/image_widget.dart';
import 'package:talkam/common/widgets/subscribe_button.dart';
import 'package:talkam/core/mock/mock_home_data.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/core/theme/pallets.dart';
import 'package:talkam/core/utils/extensions/context_extension.dart';
import 'package:talkam/features/group/presentation/blocs/group_post_cubit/group_post_cubit.dart';
import 'package:talkam/features/group/presentation/blocs/groups_cubit/groups_cubit.dart';
import 'package:talkam/features/group/presentation/screens/refresh_group_listener.dart';
import 'package:talkam/features/group/presentation/tabs/groups_about_tab.dart';
import 'package:talkam/features/group/presentation/tabs/group_posts_tab.dart';
import 'package:talkam/features/group/presentation/tabs/groups_rules_tab.dart';
import 'package:talkam/features/home/presentation/screens/home_screen.dart';
import 'package:talkam/features/post/presentation/widgets/create_post_sheet.dart';
import 'package:talkam/features/group/presentation/widgets/group_details_header.dart';
import 'package:talkam/gen/assets.gen.dart';

class GroupInfoScreen extends StatefulWidget {
  const GroupInfoScreen({super.key, required this.groupId});

  final String groupId;

  @override
  State<GroupInfoScreen> createState() => _GroupInfoScreenState();
}

class _GroupInfoScreenState extends State<GroupInfoScreen>
    with SingleTickerProviderStateMixin {
  final tabItems = [
    TabItemModel(imagePath: Assets.images.svgs.icfeatured, tittle: "Trending"),
    TabItemModel(imagePath: Assets.images.svgs.icTrending, tittle: "About"),
    TabItemModel(imagePath: Assets.images.svgs.icTrending, tittle: "Rules"),
  ];
  int selecteIndex = 0;
  final PageController _pageController = PageController();
  final bloc = GroupsCubit(injector.get());
  final groupPostCubit = GroupPostCubit(injector.get());
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);

    bloc.getGroup(widget.groupId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshGroupListener(
      onRefresh: () {
        bloc.getGroup(widget.groupId);
      },
      child: Scaffold(
        backgroundColor: context.colorScheme.surface,
        floatingActionButton: FloatingActionButton(
          foregroundColor: Pallets.white,
          backgroundColor: Pallets.blueBubbleColor,
          shape: const CircleBorder(),
          onPressed: () {
            showCreatePostSheet(context);
          },
          child: const Icon(Icons.add, color: Colors.white),
        ),
        body: BlocConsumer<GroupsCubit, GroupsState>(
          bloc: bloc,
          listener: (context, state) {
            state.maybeWhen(
              orElse: () => null,
              getGroupSuccess: (response) {
                response = response;
              },
            );
          },
          builder: (context, state) {
            return state.maybeWhen(
              orElse: () => 0.verticalSpace,
              getGroupLoading: () {
                return Scaffold(
                  appBar: const CustomAppBar(),
                  body: Center(
                    child: CustomDialogs.getLoading(size: 50),
                  ),
                );
              },
              getGroupFailure: (error) {
                return Scaffold(
                  appBar: const CustomAppBar(),
                  body: AppErrorWidget(
                    message: error,
                    onTap: () {
                      bloc.getGroup(widget.groupId);
                    },
                  ),
                );
              },
              getGroupSuccess: (response) {
                return NestedScrollView(
                  headerSliverBuilder: (context, innerBoxIsScrolled) => [
                    SliverToBoxAdapter(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GroupDetailsHeader(
                            group: response,
                            onFollowUpdated: () {
                              bloc.getGroup(widget.groupId, refresh: false);
                            },
                          ),
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
                          child: Padding(
                            padding: const EdgeInsets.only(
                              top: 4,
                              bottom: 0,
                            ),
                            child: TabBar(
                                padding: EdgeInsets.zero,
                                controller: _tabController,
                                tabAlignment: TabAlignment.center,
                                indicatorColor: Pallets.blueBubbleColor,
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
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16.0),
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
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ).toList()),
                          ),
                        ),
                      ),
                      BlocProvider.value(
                        value: groupPostCubit,
                        child: Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 5),
                            child: PageView(
                              controller: _pageController,
                              onPageChanged: (int index) {
                                _tabController.animateTo(index);
                                selecteIndex = index;

                                setState(() {});
                              },
                              children: [
                                GroupPostsTab(
                                  group: response,
                                ),
                                GroupsAboutTab(
                                  data: response,
                                ),
                                GroupsRulesTab(
                                  data: response,
                                )
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
