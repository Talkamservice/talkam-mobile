import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:talkam/common/widgets/custom_button.dart';
import 'package:talkam/common/widgets/custom_dialogs.dart';
import 'package:talkam/common/widgets/image_widget.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/constants/onboarding_texts.dart';
import 'package:talkam/core/constants/package_exports.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/core/mixins/returning_user_mixin.dart';
import 'package:talkam/core/navigation/route_url.dart';
import 'package:talkam/core/services/data/session_manager.dart';
import 'package:talkam/core/services/network/network_service.dart';
import 'package:talkam/core/theme/pallets.dart';
import 'package:talkam/features/authentication/data/repository/auth_repository_impl.dart';
import 'package:talkam/features/authentication/dormain/mixins/auth_success_mixin.dart';
import 'package:talkam/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:talkam/gen/assets.gen.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> with AuthSuccessMixin {
  final _authBloc = AuthBloc(injector.get());

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      bloc: _authBloc,
      listener: _listenToAuthBloc,
      builder: (context, state) {
        return Scaffold(
          body: Stack(
            children: [
              ImageWidget(
                imageUrl: "Assets.images.gif.intro.path",
                height: 1.sh,
                width: 1.sw,
                fit: BoxFit.cover,
              ),
              Container(
                height: 1.sh,
                width: 1.sw,
                decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                  Colors.black.withOpacity(0.12),
                  Colors.black.withOpacity(0.78),
                  Colors.black.withOpacity(0.78),
                  // Colors.black,
                ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Column(
                    children: [
                      70.verticalSpace,
                      ImageWidget(
                        imageUrl: Assets.images.svgs.intologo,
                        width: 186.w,
                        height: 56.h,
                        fit: BoxFit.scaleDown,
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            if (Platform.isIOS)
                              CustomButton(
                                bgColor: Pallets.white,
                                foregroundColor: Pallets.black,
                                borderRadius: BorderRadius.circular(8.r),
                                padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 20.w),
                                onPressed: () {

                                  _authBloc.add(const AppleAuthEvent());

                                },
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    ImageWidget(imageUrl: Assets.images.svgs.apple),
                                    const Expanded(
                                        child: TextView(
                                      text: 'Login with Apple ID',
                                      align: TextAlign.center,
                                      fontWeight: FontWeight.w700,
                                    )),
                                  ],
                                ),
                              ),
                            12.verticalSpace,
                            CustomButton(
                              bgColor: Pallets.white,
                              foregroundColor: Pallets.black,
                              borderRadius: BorderRadius.circular(8.r),
                              padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 20.w),
                              onPressed: () {
                                _authBloc.add(const FacebookAuthEvent());

                                // context.pushNamed(PageUrl.termsScreen);
                              },
                              child: Row(
                                children: [
                                  ImageWidget(imageUrl: Assets.images.svgs.facebook),
                                  const Expanded(
                                      child: TextView(
                                    text: 'Login with Facebook',
                                    align: TextAlign.center,
                                    fontWeight: FontWeight.w700,
                                  )),
                                ],
                              ),
                            ),
                            12.verticalSpace,
                            CustomButton(
                              bgColor: Pallets.white,
                              foregroundColor: Pallets.black,
                              borderRadius: BorderRadius.circular(8.r),
                              padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 20.w),
                              onPressed: () {
                                _authBloc.add(const GoogleAuthEvent());
                                // context.pushNamed(PageUrl.termsScreen);
                              },
                              child: Row(
                                children: [
                                  ImageWidget(imageUrl: Assets.images.svgs.googleAuth),
                                  const Expanded(
                                      child: TextView(
                                    text: 'Login with Google',
                                    align: TextAlign.center,
                                    fontWeight: FontWeight.w700,
                                  )),
                                ],
                              ),
                            ),
                            12.verticalSpace,
                            if(false)
                            CustomButton(
                              bgColor: Pallets.white,
                              foregroundColor: Pallets.black,
                              borderRadius: BorderRadius.circular(8.r),
                              padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 20.w),
                              onPressed: () {
                                _authBloc.add(const TikTokAuthEvent());
                                // context.pushNamed(PageUrl.termsScreen);
                              },
                              child: Row(
                                children: [
                                  ImageWidget(imageUrl: Assets.images.svgs.tiktok),
                                  const Expanded(
                                      child: TextView(
                                    text: 'Login with TikTok',
                                    align: TextAlign.center,
                                    fontWeight: FontWeight.w700,
                                  )),
                                ],
                              ),
                            ),
                            if(false)

                            16.verticalSpace,
                            const Center(
                              child: TextView(
                                text: "or",
                                color: Pallets.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            16.verticalSpace,
                            CustomButton(
                              bgColor: Pallets.white,
                              foregroundColor: Pallets.black,
                              borderRadius: BorderRadius.circular(8.r),
                              padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 20.w),
                              onPressed: () {
                                context.pushNamed(PageUrl.login);
                              },
                              child: const TextView(
                                text: 'Continue with Username',
                                align: TextAlign.center,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            30.verticalSpace,
                            CustomButton(
                              bgColor: Pallets.white,
                              foregroundColor: Pallets.black,
                              borderRadius: BorderRadius.circular(8.r),
                              padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 20.w),
                              onPressed: () {
                                SessionManager().hasOnboarded = true;

                                context.goNamed(PageUrl.homeScreen);
                              },
                              child: const TextView(
                                text: 'Continue as Guest',
                                align: TextAlign.center,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            16.verticalSpace,
                            const TextView(
                              text: introMessage,
                              align: TextAlign.center,
                              color: Pallets.white,
                              fontSize: 12,
                            ),
                            16.verticalSpace
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _listenToAuthBloc(BuildContext context, AuthState state) {
    if (state is OauthLoadingState) {
      CustomDialogs.showLoading(context);
    }
    if (state is OauthFailureState) {
      context.pop();
      CustomDialogs.error(state.error);
    }
    if (state is OauthSuccessState) {
      context.pop();
      handleLoginSuccess(context, state.response.data.user);
    }
  }
}
