import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/core/navigation/route_url.dart';
import 'package:talkam/core/theme/pallets.dart';
import 'package:talkam/core/utils/extensions/context_extension.dart';
import 'package:talkam/features/home/presentation/bloc/drawer/drawer_cubit.dart';
import 'package:talkam/features/home/presentation/widgets/app_drawer.dart';
import 'package:talkam/gen/assets.gen.dart';

class _BottomNavIcon extends StatelessWidget {
  final Function(int) onTap;
  final int currentIndex, itemIndex;
  final String iconPath;
  final Color? bgColor;

  const _BottomNavIcon({
    super.key,
    required this.onTap,
    required this.currentIndex,
    required this.iconPath,
    required this.itemIndex,
    this.bgColor,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(itemIndex),
      child: Container(
        width: 48.w,
        height: 48.h,
        decoration: bgColor != null
            ? BoxDecoration(color: bgColor, shape: BoxShape.circle)
            : currentIndex == itemIndex
                ? BoxDecoration(
                    color: context.colorScheme.primary, shape: BoxShape.circle)
                : null,
        child: Center(child: SvgPicture.asset(iconPath)),
      ),
    );
  }
}

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

class _BasePageState extends State<BasePage> {
  final GlobalKey<FormState> dialogKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> baseScaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void dispose() {
    dialogKey.currentState?.dispose();
    super.dispose();
  }

  void _goBranch(int index) {
    widget.navigationShell.goBranch(index,
        initialLocation: index == widget.navigationShell.currentIndex);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: baseScaffoldKey,
      extendBody: true,
      drawer: const AppDrawer(),
      // backgroundColor: Pallets.defaultBackgroundColor,
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
        // child: ,
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 12, right: 12, bottom: 12),
        child: Container(
          height: 64.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100.r),
            color: Pallets.boldBlack,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _BottomNavIcon(
                onTap: _goBranch,
                currentIndex: widget.navigationShell.currentIndex,
                iconPath: Assets.images.svgs.home,
                itemIndex: 0,
              ),
              _BottomNavIcon(
                onTap: _goBranch,
                currentIndex: widget.navigationShell.currentIndex,
                iconPath: Assets.images.svgs.search,
                itemIndex: 1,
              ),
              _BottomNavIcon(
                onTap: (p0) {
                  // SessionManager.instance.logOut();
                  context.pushNamed(PageUrl.createPostScreen);
                },
                currentIndex: widget.navigationShell.currentIndex,
                iconPath: Assets.images.svgs.add,
                bgColor: Pallets.white,
                itemIndex: 2,
              ),
              _BottomNavIcon(
                onTap: (p0) {
                  _goBranch(2);
                },
                currentIndex: widget.navigationShell.currentIndex,
                iconPath: Assets.images.svgs.groups,
                itemIndex: 2,
              ),
              _BottomNavIcon(
                onTap: (p0) {
                  _goBranch(3);
                },
                currentIndex: widget.navigationShell.currentIndex,
                iconPath: Assets.images.svgs.message,
                itemIndex: 3,
              ),
            ],
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
