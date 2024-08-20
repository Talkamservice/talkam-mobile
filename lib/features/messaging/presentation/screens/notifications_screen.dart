import 'package:flutter/material.dart';
import 'package:talkam/common/widgets/custom_appbar.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/constants/package_exports.dart';
import 'package:talkam/core/theme/pallets.dart';
import 'package:talkam/core/utils/extensions/context_extension.dart';
import 'package:talkam/features/messaging/presentation/widgets/tabs/all.dart';
import 'package:talkam/features/messaging/presentation/widgets/tabs/messages.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  final PageController _pageController = PageController();
  final tabItems = [
    TabItemModel2(tittle: "All"),
    TabItemModel2(tittle: "Mentions"),
  ];

  int selecteIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        leadingWidth: 25,
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
            const TextView(
              color: Color(0xff212121),
              text: "Mark as read",
              fontSize: 16,
              fontWeight: FontWeight.w500,
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
                      tabAlignment: TabAlignment.center,
                      indicator: UnderlineTabIndicator(
                        borderSide: BorderSide(
                          width: 4,
                          color: context.colorScheme.primary,
                        ),
                        insets: const EdgeInsets.only(
                          left: 10.0,
                        ),
                      ),
                      indicatorSize: TabBarIndicatorSize.tab,

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
                                color: selecteIndex == index
                                    ? Pallets.grey60
                                    : Pallets.grey60,
                              ),
                            ],
                          ),
                        ),
                      ).toList(),
                    ),
                    SizedBox(
                      width: 1.sw,
                      child: const Divider(
                        thickness: 1,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: PageView(
                  controller: _pageController,
                  physics: const NeverScrollableScrollPhysics(),
                  onPageChanged: (int index) {
                    // setState(() {});
                  },
                  children: const [
                    AllTab(),
                    Messages(),
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

class TabItemModel2 {
  String tittle;

  TabItemModel2({required this.tittle});
}
