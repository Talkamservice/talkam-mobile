import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:talkam/common/widgets/custom_appbar.dart';
import 'package:talkam/common/widgets/custom_button.dart';
import 'package:talkam/common/widgets/custom_dialogs.dart';
import 'package:talkam/common/widgets/custom_outlined_button.dart';
import 'package:talkam/common/widgets/custom_text_field.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/constants/package_exports.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/core/mixins/returning_user_mixin.dart';
import 'package:talkam/core/navigation/route_url.dart';
import 'package:talkam/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:talkam/features/profile/presentation/bloc/profile_bloc/profile_bloc.dart';
import 'package:talkam/gen/assets.gen.dart';

import '../../../../core/theme/pallets.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with ReturningUserMixin {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool passwordObscured = true;
  final formKey = GlobalKey<FormState>();
  final bloc = AuthBloc(injector.get());

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      bloc: bloc,
      listener: _listenToAuthBloc,
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: CustomAppBar(
            bgColor: Colors.transparent,
            elevation: 0,
            onBackPressed: () {
              if (context.canPop()) {
                context.pop();
              } else {
                context.goNamed(PageUrl.getStartedScreen);
              }
            },
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Form(
              key: formKey,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const TextView(
                      text: "Welcome Back",
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      color: Pallets.boldBlackV2,
                    ),
                    8.verticalSpace,
                    const TextView(
                      text:
                          "Join a community that understands. Post anonymously and find support.",
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Pallets.grey400,
                      lineHeight: 1.4,
                    ),
                    32.verticalSpace,

                    // Email Field
                    CustomTextField(
                      label: "Email Address",
                      hint: "Enter your Email Address",
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      validator: MultiValidator([
                        RequiredValidator(errorText: "Field is required"),
                        EmailValidator(
                            errorText: "Enter a valid email address"),
                      ]).call,
                    ),

                    20.verticalSpace,

                    // Password Field
                    CustomTextField(
                      label: "Password",
                      hint: "Enter your Password",
                      controller: passwordController,
                      obscureText: passwordObscured,
                      validator: MultiValidator([
                        RequiredValidator(errorText: "Field is required"),
                        MinLengthValidator(8,
                            errorText:
                                "Password should be at least 8 characters"),
                      ]).call,
                      suffixIcon: IconButton(
                        icon: Icon(
                          passwordObscured
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                          color: Pallets.grey400,
                        ),
                        onPressed: () {
                          setState(() {
                            passwordObscured = !passwordObscured;
                          });
                        },
                      ),
                    ),

                    12.verticalSpace,

                    // Forgot Password
                    Align(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                        onTap: () {
                          context.pushNamed(PageUrl.passwordRecoveryScreen);
                        },
                        child: const TextView(
                          text: "Forgot Password?",
                          color: Pallets.blueBubbleColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                    ),

                    24.verticalSpace,

                    // OR divider
                    Row(
                      children: [
                        const Expanded(
                            child:
                                Divider(color: Pallets.grey90, thickness: 1)),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.w),
                          child: const TextView(
                            text: "or",
                            fontSize: 14,
                            color: Pallets.boldBlack,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const Expanded(
                            child:
                                Divider(color: Pallets.grey90, thickness: 1)),
                      ],
                    ),

                    32.verticalSpace,

                    // Google Button
                    CustomOutlinedButton(
                      onPressed: () => bloc.add(const GoogleAuthEvent()),
                      borderColor: Pallets.grey90,
                      borderRadius: BorderRadius.circular(14.r),
                      padding: EdgeInsets.symmetric(vertical: 14.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(Assets.images.svgs.googleAuth,
                              height: 20.w),
                          12.horizontalSpace,
                          const TextView(
                            text: "Continue with Google",
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Pallets.boldBlack,
                          ),
                        ],
                      ),
                    ),

                    // Apple only ever completes on iOS — same policy as
                    // IntroScreen, where this button is the one place OAuth
                    // is (was) actually wired up.
                    if (Platform.isIOS) ...[
                      8.verticalSpace,
                      CustomOutlinedButton(
                        onPressed: () => bloc.add(const AppleAuthEvent()),
                        borderColor: Pallets.grey90,
                        borderRadius: BorderRadius.circular(14.r),
                        padding: EdgeInsets.symmetric(vertical: 14.h),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(Assets.images.svgs.appleDark,
                                height: 20.w),
                            12.horizontalSpace,
                            const TextView(
                              text: "Continue with Apple",
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Pallets.boldBlack,
                            ),
                          ],
                        ),
                      ),
                    ],

                    24.verticalSpace,

                    // Sign in Button
                    CustomButton(
                      onPressed: () {
                        login(context);
                      },
                      bgColor: Pallets.blueBubbleColor,
                      borderRadius: BorderRadius.circular(14.r),
                      padding: EdgeInsets.symmetric(vertical: 14.h),
                      child: const TextView(
                        text: "Sign in",
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),

                    18.verticalSpace,

                    // Don't have an account
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const TextView(
                          text: "Don’t have an Account? ",
                          fontSize: 14,
                          color: Pallets.grey500,
                          fontWeight: FontWeight.w500,
                        ),
                        GestureDetector(
                          onTap: () {
                            context.pushNamed(PageUrl.signUp);
                          },
                          child: const TextView(
                            text: "Sign Up",
                            fontSize: 14,
                            color: Pallets.blueBubbleColor,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),

                    40.verticalSpace,
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void login(BuildContext context) {
    if (formKey.currentState?.validate() ?? false) {
      bloc.add(
          LoginEvent(emailController.text.trim(), passwordController.text));
    }
  }

  void _listenToAuthBloc(BuildContext context, AuthState state) {
    if (state is AuthLoading || state is OauthLoadingState) {
      CustomDialogs.showLoading(context);
    }
    if (state is AuthFailure) {
      context.pop();
      CustomDialogs.error(state.error);
    }
    if (state is OauthFailureState) {
      context.pop();
      CustomDialogs.error(state.error);
    }

    if (state is LoginSuccess) {
      context.pop();
      CustomDialogs.success("Login successful.");
      injector
          .get<ProfileBloc>()
          .add(SaveUserLocallyEvent(state.response.data.user));
      gotoNextScreen(context, state.response.data.user);
    }
    if (state is OauthSuccessState) {
      context.pop();
      injector
          .get<ProfileBloc>()
          .add(SaveUserLocallyEvent(state.response.data.user));
      gotoNextScreen(context, state.response.data.user);
    }
  }
}
