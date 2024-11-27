import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talkam/common/widgets/custom_appbar.dart';
import 'package:talkam/common/widgets/custom_dialogs.dart';
import 'package:talkam/common/widgets/image_widget.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/constants/package_exports.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/core/theme/pallets.dart';
import 'package:talkam/core/utils/extensions/context_extension.dart';
import 'package:talkam/features/group/dormain/model/group_overview_data.dart';
import 'package:talkam/features/group/presentation/tabs/group_members_tab.dart';
import 'package:talkam/features/group/presentation/tabs/group_rules_tab.dart';
import 'package:talkam/features/group/presentation/tabs/groups_about_tab.dart';
import 'package:talkam/features/group/presentation/widgets/group_action_sheet.dart';
import 'package:talkam/features/group/presentation/widgets/group_details_header.dart';
import 'package:talkam/features/home/presentation/screens/home_screen.dart';
import 'package:talkam/features/notifications/presentation/bloc/notification_bloc.dart';
import 'package:talkam/features/notifications/presentation/bloc/notification_bloc.dart';
import 'package:talkam/features/search/data/models/get_group_response.dart';
import 'package:talkam/gen/assets.gen.dart';

class GroupDetailsScreenParam {
  final bool isPreview;
  GroupGuidlineTabData rulesData;
  GroupMembersTabData membersData;
  GroupOverViewData overview;
  GroupAboutData about;

  GroupDetailsScreenParam({required this.isPreview, required this.rulesData, required this.membersData, required this.overview, required this.about});
}

class GroupDetailsScreen extends StatefulWidget {
  const GroupDetailsScreen({super.key, required this.group});

  final TalkamGroup group;

  @override
  State<GroupDetailsScreen> createState() => _GroupDetailsScreenState();
}

class _GroupDetailsScreenState extends State<GroupDetailsScreen> with SingleTickerProviderStateMixin {
  final tabItems = [
    TabItemModel(imagePath: Assets.images.svgs.icfeatured, tittle: "Rules"),
    TabItemModel(imagePath: Assets.images.svgs.icTrending, tittle: "Members"),
    TabItemModel(imagePath: Assets.images.svgs.icTrending, tittle: "About"),
  ];
  int selecteIndex = 0;
  final PageController _pageController = PageController();

  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

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
            ImageWidget(
              imageUrl: widget.group.image!,
              borderRadius: BorderRadius.circular(100),
            ),
            11.horizontalSpace,
            TextView(
              text: widget.group.name!,
              fontSize: 18,
              fontWeight: FontWeight.w700,
            )
          ],
        ),
        actions: [
          if (!(widget.group.isReported ?? false))
            IconButton(
                onPressed: () {
                  CustomDialogs.showBottomSheet(
                      context,
                      GroupActionSheet(
                        group: widget.group,
                      ));
                },
                icon: const Icon(Icons.more_vert))
        ],
      ),
      body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    GroupDetailsHeader(
                      group: widget.group,
                    ),
                    const Divider(),
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
                      controller: _tabController,
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
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Tab(
                            child: BlocConsumer<NotificationsBloc, NotificationsState>(
                              bloc: injector.get<NotificationsBloc>(),
                              listener: (context, state) {},
                              builder: (context, state) {
                                final stat = injector.get<NotificationsBloc>().stats;
                                return Row(
                                  children: [
                                    Stack(
                                      clipBehavior: Clip.none,

                                      children: [
                                        TextView(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600,
                                          text: tabItems[index].tittle,
                                          color: selecteIndex == index ? context.colorScheme.onSurface : Pallets.grey60,
                                          // fontWeight: isSelected ? FontWeight.w500 : FontWeight.w400,
                                        ),


                                        if(index== 1)
                                        if (stat.totalRequests != 0)
                                          Positioned(
                                            top: -8,
                                            right: -10,
                                            child: CircleAvatar(
                                              radius: 8,
                                              backgroundColor: Colors.red,
                                              foregroundColor: Colors.white,
                                              child: TextView(
                                                text: stat.totalRequests.toString(),
                                                fontSize: 8,
                                              ),
                                            ),
                                          ),
                                      ],
                                    ),
                                  ],
                                );
                              },
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

                    // physics: const NeverScrollableScrollPhysics(),
                    onPageChanged: (int index) {
                      // setState(() {});

                      _tabController.animateTo(index);
                      selecteIndex = index;
                      setState(() {});
                    },
                    children: [
                      GroupRulesTab(
                        group: widget.group,
                      ),
                      GroupMembersTab(
                        group: widget.group,
                      ),
                      GroupsAboutTab(
                        data: widget.group,
                      )
                    ],
                  ),
                ),
              )
            ],
          )),
    );
  }
}

ButtonStyle outlinedButtonStyle() {
  return TextButton.styleFrom(
      backgroundColor: Pallets.borderGrey.withOpacity(0.1),
      shape: const StadiumBorder(side: BorderSide(color: Pallets.borderGrey)),
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 10));
}
