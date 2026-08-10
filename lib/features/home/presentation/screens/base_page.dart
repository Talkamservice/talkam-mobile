import 'package:flutter/foundation.dart';
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
/// (1) and Groups (2) stay real, reachable branches, just not represented in
/// the bottom bar itself (Search moved to the top app bar, Groups is
/// reachable from the sidebar). Messaging is NOT part of this shell at all —
/// it's a standalone top-level route, pushed separately from the drawer.
const int _kHomeBranch = 0;
const int _kGroupsBranch = 1;
const int _kTherapistBranch = 2;
const int _kSessionBranch = 3;
const int _kEarningsBranch = 4;
const int _kProfileBranch = 5;

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

  /// The exit-confirmation dialog is pushed on the root navigator — the same
  /// one every top-level route (e.g. /login) uses, since this page doesn't
  /// sit behind a navigator boundary of its own. If it's left open (user
  /// backs out but never taps Yes/Cancel) and this page then goes away some
  /// other way — e.g. logging out — GoRouter's page swap doesn't touch this
  /// imperatively-pushed dialog, so it just keeps floating over whatever
  /// screen comes next. Track it so dispose() can close it explicitly.
  bool _isExitDialogShowing = false;
  NavigatorState? _rootNavigator;

  /// Rebuilds the bar when the account type changes, so the Earnings
  /// destination appears as soon as an application is approved rather than
  /// after the next unrelated setState.
  ValueListenable<bool> get _isTherapistListenable =>
      SessionManager.instance.isTherapistAccountListenable;

  @override
  void dispose() {
    dialogKey.currentState?.dispose();
    if (_isExitDialogShowing) {
      _rootNavigator?.pop();
    }
    super.dispose();
  }

  void _confirmExit(BuildContext context) {
    if (_isExitDialogShowing) return;
    _isExitDialogShowing = true;
    _rootNavigator = Navigator.of(context, rootNavigator: true);
    CustomDialogs.showConfirmDialog(
      context,
      tittle: "Exit",
      message: "Are you sure you want to exit",
      onYes: () {
        Navigator.pop(context);
        SystemNavigator.pop();
      },
      onCancel: () {
        Navigator.pop(context);
      },
    ).whenComplete(() => _isExitDialogShowing = false);
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
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;
        _confirmExit(context);
      },
      child: Scaffold(
        key: baseScaffoldKey,
        extendBody: true,
        drawerScrimColor: Colors.transparent,
        drawer: AppDrawer(
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
        bottomNavigationBar: widget.navigationShell.currentIndex ==
                _kGroupsBranch
            ? null
            : Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border:
                      Border(top: BorderSide(color: Pallets.grey90, width: 1)),
                ),
                child: SafeArea(
                  top: false,
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 10.h),
                    child: ValueListenableBuilder<bool>(
                      // Wraps the whole bar rather than a single destination: the
                      // shell is a StatefulShellRoute.indexedStack, so a visited
                      // branch stays alive and will not rebuild on its own.
                      // Reading the flag once during build would leave both the
                      // therapist/wellness icon and the Earnings destination stale
                      // after an application is approved mid-session.
                      valueListenable: _isTherapistListenable,
                      builder: (context, isTherapist, _) => Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _NavIcon(
                            selectedIconPath:
                                Assets.images.svgV2.userMultipleActive,
                            unselectedIconPath:
                                Assets.images.svgV2.userMultipleInActive,
                            selected: widget.navigationShell.currentIndex ==
                                _kHomeBranch,
                            onTap: () => _goBranch(_kHomeBranch),
                          ),
                          _NavIcon(
                            selectedIconPath: isTherapist
                                ? Assets.images.svgV2.userActive
                                : Assets.images.svgV2.brainActive,
                            unselectedIconPath: isTherapist
                                ? Assets.images.svgV2.userInActive
                                : Assets.images.svgV2.brainInActive,
                            selected: widget.navigationShell.currentIndex ==
                                _kTherapistBranch,
                            onTap: () => _goBranch(_kTherapistBranch),
                          ),
                          _NavIcon(
                            selectedIconPath:
                                Assets.images.svgV2.calendarActive,
                            unselectedIconPath:
                                Assets.images.svgV2.calendarInActive,
                            selected: widget.navigationShell.currentIndex ==
                                _kSessionBranch,
                            onTap: () => _goBranch(_kSessionBranch),
                          ),
                          if (isTherapist)
                            _NavIcon(
                              selectedIconPath:
                                  Assets.images.svgV2.dollarSelected,
                              unselectedIconPath: Assets.images.svgV2.dollar2,
                              selected: widget.navigationShell.currentIndex ==
                                  _kEarningsBranch,
                              onTap: () => _goBranch(_kEarningsBranch),
                            ),
                          _NavIcon(
                            selectedIconPath:
                                Assets.images.svgV2.profileSelected,
                            unselectedIconPath:
                                Assets.images.svgV2.profileUnselected,
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
    required this.selectedIconPath,
    required this.unselectedIconPath,
    required this.selected,
    required this.onTap,
  });

  final String selectedIconPath;
  final String unselectedIconPath;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      customBorder: const CircleBorder(),
      child: SizedBox(
        width: 48.w,
        height: 48.h,
        child: Center(
          child: SvgPicture.asset(
            selected ? selectedIconPath : unselectedIconPath,
            width: 22.w,
            height: 22.w,
          ),
        ),
      ),
    );
  }
}
