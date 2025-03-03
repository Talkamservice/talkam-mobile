import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:talkam/core/services/theme_service/app_theme.dart';
import 'package:talkam/features/home/presentation/screens/base_bloc_provider.dart';
import 'package:talkam/features/notifications/presentation/screens/push_notifications_listener.dart';
import 'core/constants/package_exports.dart';
import 'core/navigation/routes.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class TalkAmApp extends StatefulWidget {
  const TalkAmApp({super.key});

  @override
  State<TalkAmApp> createState() => _TalkAmAppState();
}

class _TalkAmAppState extends State<TalkAmApp> {
  @override
  void initState() {
    // _initMesibo();
    super.initState();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 852),
      // designSize: ScreenUtil.defaultSize,
      useInheritedMediaQuery: true,
      minTextAdapt: true,
      builder: (context, child) {
        return OverlaySupport.global(
          child: BaseBlocProvider(
            child: GestureDetector(
              onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
              child: PushNotificationListener(
                child: MaterialApp.router(
                  debugShowCheckedModeBanner: false,
                  title: "Talkam",
                  localizationsDelegates: const [
                    GlobalMaterialLocalizations.delegate,
                    GlobalWidgetsLocalizations.delegate,
                    GlobalCupertinoLocalizations.delegate,
                  ],
                  theme: AppTheme.lightTheme,
                  routerConfig: CustomRoutes.goRouter,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
