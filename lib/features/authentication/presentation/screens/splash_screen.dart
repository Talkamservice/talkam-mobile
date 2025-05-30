import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:talkam/common/widgets/image_widget.dart';
import 'package:talkam/core/constants/package_exports.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/core/mixins/returning_user_mixin.dart';
import 'package:talkam/core/navigation/route_url.dart';
import 'package:talkam/core/services/data/session_manager.dart';
import 'package:talkam/features/profile/presentation/bloc/profile_bloc/profile_bloc.dart';
import 'package:talkam/gen/assets.gen.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin, ReturningUserMixin {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> dialogKey = GlobalKey<FormState>();

  late Animation<double> animation;
  AnimationController? animationCtrl;

  @override
  void initState() {
    super.initState();
    animationCtrl = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    );
    animation = Tween<double>(begin: 0, end: 100).animate(
      CurvedAnimation(
        parent: animationCtrl!,
        curve: Curves.easeIn,
      ),
    );

    // Future.delayed(Duration.zero, () {
    //
    //   ref.read(setupProfileProvider.notifier).getDataConfigs();
    //   // ref.read(locationProvider.notifier).caller();
    // });

    animationCtrl?.forward();
    animation.addListener(() async {
      if (animation.isCompleted ?? false) {
        _goToNextScreen();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    dialogKey.currentState?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: Center(
        child: IgnorePointer(
          child: ImageWidget(
            // size: 100,
            width: 100,
            height: 100,
            fit: BoxFit.cover,
            imageUrl: Assets.images.png.appIcon.path,
          ),
        ),
      ),
    );
  }

  void _goToNextScreen() {
    // context.goNamed(PageUrl.userNameScreen);

    if (SessionManager.instance.isLoggedIn) {
      gotoNextScreen(context, injector.get<ProfileBloc>().appUser!);
    } else {

      if(SessionManager().hasOnboarded){
        context.goNamed(PageUrl.homeScreen);
      }else{
        context.goNamed(PageUrl.onboardingScreen);
      }
    }

  }
}
