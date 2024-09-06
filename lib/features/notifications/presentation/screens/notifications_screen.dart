import 'package:flutter/material.dart';
import 'package:talkam/common/widgets/custom_appbar.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/constants/package_exports.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/core/theme/pallets.dart';
import 'package:talkam/core/utils/extensions/context_extension.dart';
import 'package:talkam/features/notifications/presentation/bloc/notification_bloc.dart';
import 'package:talkam/features/notifications/presentation/screens/post_activities.dart';
import 'package:talkam/features/notifications/presentation/screens/conversations_tab.dart';
import 'package:talkam/features/notifications/presentation/screens/system_admin.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> with SingleTickerProviderStateMixin {
  final PageController _pageController = PageController();
  final tabItems = [
    TabItemModel2(tittle: "Post activities"),
    TabItemModel2(tittle: "Conversations"),
    TabItemModel2(tittle: "System admin"),
  ];

  int selecteIndex = 0;
  late TabController _tabController;

  final bloc = NotificationsBloc(injector.get(), injector.get());

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    bloc.add(GetNotificationsEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        leadingWidth: 25,
        elevation: 0,
        tittle: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const TextView(
              text: "Notifications",
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
            const Spacer(),
            20.horizontalSpace,
            TextButton(
              onPressed: () {
                bloc.add(const ReadAllNotificationEvent());
              },
              child: const TextView(
                color: Color(0xff212121),
                text: "Mark all as read",
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        centerTile: false,
        showDivider: true,
      ),
      body: DefaultTabController(
        length: 2,
        child: SafeArea(
            child: Column(
          children: [
            Container(
              color: Colors.transparent,
              width: 1.sw,
              child: Center(
                child: Column(
                  children: [
                    TabBar(
                      tabAlignment: TabAlignment.start,
                      indicatorColor: context.colorScheme.primary,
                      indicatorSize: TabBarIndicatorSize.label,
                      indicatorWeight: 3,
                      isScrollable: true,
                      controller: _tabController,
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
                              8.horizontalSpace,
                              TextView(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                text: tabItems[index].tittle,
                                color: selecteIndex == index ? Pallets.grey60 : Pallets.grey60,
                              ),
                            ],
                          ),
                        ),
                      ).toList(),
                    ),
                    Container(
                      color: Pallets.grey90,
                      height: 1,
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: PageView(
                controller: _pageController,
                // physics: const NeverScrollableScrollPhysics(),
                onPageChanged: (int index) {
                  // setState(() {});
                  _tabController.animateTo(index);
                  selecteIndex = index;
                  setState(() {});
                },
                children: const [
                  PostActivitiesTab(),
                  ConversationsTab(),
                  SystemAdminTab(),
                ],
              ),
            )
          ],
        )),
      ),
    );
  }
}

class TabItemModel2 {
  String tittle;

  TabItemModel2({required this.tittle});
}
