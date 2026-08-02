import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:talkam/common/widgets/custom_dialogs.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/core/services/data/session_manager.dart';
import 'package:talkam/core/theme/pallets.dart';
import 'package:talkam/core/utils/guest_user_helper.dart';
import 'package:talkam/features/home/presentation/bloc/drawer/drawer_cubit.dart';
import 'package:talkam/features/home/presentation/widgets/app_drawer.dart';
import 'package:talkam/features/post/dormain/mixins/refresh_posts_mixin.dart';
import 'package:talkam/features/post/presentation/widgets/create_post_sheet.dart';
import 'package:talkam/gen/assets.gen.dart';

/// Shell branch indices — see the StatefulShellRoute in routes.dart. Search
/// (1), Groups (2) and Messaging (3) stay real, reachable branches; they're
/// just no longer represented in the bottom bar itself (see Part B of the
/// redesign — Search moved to the top app bar, Groups/Messages are reachable
/// from the sidebar).
const int _kHomeBranch = 0;
const int _kGroupsBranch = 2;
const int _kMessagingBranch = 3;
const int _kWellnessBranch = 4;
const int _kCalendarBranch = 5;
const int _kEarningsBranch = 6;
const int _kProfileBranch = 7;

class BasePage extends StatefulWidget {
  const BasePage({
    super.key,
    this.passedIndex = 0,
    required this.navigationShell,
  });

  final int passedIndex;

  final StatefulNavigationShell navigationShell;

  @override
  State createState() => _BasePageState();
}

class _BasePageState extends State<BasePage> with RefreshPostsMixin {
  final GlobalKey<FormState> dialogKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> baseScaffoldKey = GlobalKey<ScaffoldState>();

  bool get _isTherapist => SessionManager.instance.isTherapistAccount;

  @override
  void dispose() {
    dialogKey.currentState?.dispose();
    super.dispose();
  }

  void _goBranch(int index) {
    if (index == _kHomeBranch && index == widget.navigationShell.currentIndex) {
      refreshPost();
    }
    widget.navigationShell.goBranch(index,
        initialLocation: index == widget.navigationShell.currentIndex);
    setState(() {});
  }

  void _goBranchFromDrawer(int index) {
    Navigator.of(context).pop();
    _goBranch(index);
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (val) {
        CustomDialogs.showConfirmDialog(
          context,
          tittle: "Exit",
          message: "Are you sure you want to exit",
          onYes: () {
            SystemNavigator.pop();
          },
          onCancel: () {
            Navigator.pop(context);
          },
        );
      },
      child: Scaffold(
        key: baseScaffoldKey,
        extendBody: true,
        drawer: AppDrawer(
          onMessagesTap: () => _goBranchFromDrawer(_kMessagingBranch),
          onGroupsTap: () => _goBranchFromDrawer(_kGroupsBranch),
        ),
        body: BlocConsumer<DrawerCubit, DrawerState>(
          listener: (context, state) {
            state.maybeWhen(
              openDrawer: () => _openDrawer(),
              closeDrawer: () => _closeDrawer,
              orElse: () => null,
            );
          },
          builder: (BuildContext context, DrawerState state) {
            return widget.navigationShell;
          },
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Pallets.blueBubbleColor,
          onPressed: () => GuestUserHelper.handleGuestUserAction(
            message: "Login or Signup to create post",
            action: () => showCreatePostSheet(context),
          ),
          child: const Icon(Icons.add, color: Colors.white),
        ),
        bottomNavigationBar: WillPopScope(
          onWillPop: () async {
            CustomDialogs.showConfirmDialog(
              context,
              tittle: "Exit",
              message: "Are you sure you want to exit",
              onYes: () {
                SystemNavigator.pop();
              },
              onCancel: () {
                Navigator.pop(context);
              },
            );

            return false;
          },
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(top: BorderSide(color: Pallets.grey90, width: 1)),
            ),
            child: SafeArea(
              top: false,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 10.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _NavIcon(
                      iconPath: Assets.images.svgV2.userMultipleInActive,
                      selected:
                          widget.navigationShell.currentIndex == _kHomeBranch,
                      onTap: () => _goBranch(_kHomeBranch),
                    ),
                    _NavIcon(
                      iconPath: Assets.images.svgV2.brainInActive,
                      selected: widget.navigationShell.currentIndex ==
                          _kWellnessBranch,
                      onTap: () => _goBranch(_kWellnessBranch),
                    ),
                    _NavIcon(
                      iconPath: Assets.images.svgV2.calendarInActive,
                      selected: widget.navigationShell.currentIndex ==
                          _kCalendarBranch,
                      onTap: () => _goBranch(_kCalendarBranch),
                    ),
                    if (_isTherapist)
                      _NavIcon(
                        iconPath: Assets.images.svgV2.dollar2,
                        selected: widget.navigationShell.currentIndex ==
                            _kEarningsBranch,
                        onTap: () => _goBranch(_kEarningsBranch),
                      ),
                    _NavIcon(
                      iconPath: Assets.images.svgV2.user2,
                      selected: widget.navigationShell.currentIndex ==
                          _kProfileBranch,
                      onTap: () => _goBranch(_kProfileBranch),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _openDrawer() {
    logger.w(!baseScaffoldKey.currentState!.isDrawerOpen);
    // Ensure the drawer is not already open
    if (!baseScaffoldKey.currentState!.isDrawerOpen) {
      baseScaffoldKey.currentState?.openDrawer();
    }
  }

  void _closeDrawer() {
    // Close the drawer if it's open
    if (baseScaffoldKey.currentState!.isDrawerOpen) {
      Navigator.of(context).pop();
    }
  }
}

class _NavIcon extends StatelessWidget {
  const _NavIcon({
    required this.iconPath,
    required this.selected,
    required this.onTap,
  });

  final String iconPath;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      customBorder: const CircleBorder(),
      child: Container(
        width: 48.w,
        height: 48.h,
        child: Center(
          child: SvgPicture.asset(
            iconPath,
            width: 22.w,
            height: 22.w,
            colorFilter: ColorFilter.mode(
              selected ? Pallets.blueBubbleColor : Pallets.boldBlackV2,
              BlendMode.srcIn,
            ),
          ),
        ),
      ),
    );
  }
}
