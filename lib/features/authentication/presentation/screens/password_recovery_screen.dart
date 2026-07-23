import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:go_router/go_router.dart';
import 'package:talkam/common/widgets/custom_appbar.dart';
import 'package:talkam/common/widgets/custom_button.dart';
import 'package:talkam/common/widgets/custom_dialogs.dart';
import 'package:talkam/common/widgets/custom_outlined_button.dart';
import 'package:talkam/common/widgets/custom_text_field.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/core/navigation/path_params.dart';
import 'package:talkam/core/navigation/route_url.dart';
import 'package:talkam/core/theme/pallets.dart';
import 'package:talkam/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:talkam/features/authentication/presentation/screens/verify_otp_screen.dart';
import 'package:talkam/gen/assets.gen.dart';

class PassWordRecoveryScreen extends StatefulWidget {
  const PassWordRecoveryScreen({super.key});

  @override
  State<PassWordRecoveryScreen> createState() => _PassWordRecoveryScreenState();
}

class _PassWordRecoveryScreenState extends State<PassWordRecoveryScreen> {
  final _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final authBloc = AuthBloc(injector.get());

  final _scrollController = ScrollController();
  double _scrollOffset = 0;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      setState(() => _scrollOffset = _scrollController.offset);
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      bloc: authBloc,
      listener: _listenToAuthBloc,
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: const CustomAppBar(
            bgColor: Colors.transparent,
            elevation: 0,
          ),
          body: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ── Pinned header ──────────────────────────────────────
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const TextView(
                        text: "Password Recovery",
                        fontSize: 28,
                        fontWeight: FontWeight.w800,
                        color: Pallets.boldBlackV2,
                      ),
                      8.verticalSpace,
                      const TextView(
                        text:
                            "Enter the email linked to your account and we'll send you a code to reset your password.",
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Pallets.grey400,
                        lineHeight: 1.4,
                      ),
                      20.verticalSpace,
                    ],
                  ),
                ),

                // ── Scrollable form with top fade ──────────────────────
                Expanded(
                  child: ShaderMask(
                    shaderCallback: (rect) {
                      return LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        stops: const [0.0, 0.08],
                        colors: [
                          Colors.white
                              .withOpacity((_scrollOffset > 4 ? 0.0 : 1.0)),
                          Colors.white,
                        ],
                      ).createShader(rect);
                    },
                    blendMode: BlendMode.dstIn,
                    child: SingleChildScrollView(
                      controller: _scrollController,
                      padding: EdgeInsets.symmetric(horizontal: 24.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Email
                          CustomTextField(
                            label: "Email address",
                            hint: "Enter your Email Address",
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                            validator: MultiValidator([
                              RequiredValidator(errorText: "Email is required"),
                              EmailValidator(
                                  errorText: "Enter a valid email address"),
                            ]).call,
                          ),

                          20.verticalSpace,

                          // Reset Password button
                          CustomButton(
                            onPressed: () => resetPassword(context),
                            bgColor: Pallets.blueBubbleColor,
                            borderRadius: BorderRadius.circular(14.r),
                            padding: EdgeInsets.symmetric(vertical: 14.h),
                            child: const TextView(
                              text: "Reset Password",
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),

                          20.verticalSpace,

                          // Remembered your password
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const TextView(
                                text: "Remembered your password? ",
                                fontSize: 14,
                                color: Pallets.grey500,
                                fontWeight: FontWeight.w500,
                              ),
                              GestureDetector(
                                onTap: () => context.goNamed(PageUrl.login),
                                child: const TextView(
                                  text: "Sign In",
                                  fontSize: 14,
                                  color: Pallets.blueBubbleColor,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),

                          32.verticalSpace,
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void resetPassword(BuildContext context) {
    if (_formKey.currentState?.validate() ?? false) {
      authBloc.add(ForgotPasswordEvent(_emailController.text.trim()));
    }
  }

  void _listenToAuthBloc(BuildContext context, AuthState state) {
    if (state is AuthLoading) {
      CustomDialogs.showLoading(context);
    }
    if (state is AuthFailure) {
      context.pop();
      CustomDialogs.error(state.error);
    }
    if (state is ForgotPasswordSuccess) {
      context.pop();
      context.pushNamed(PageUrl.verifyOtpScreen, queryParameters: {
        PathParam.email: _emailController.text.trim(),
        PathParam.otpType: VerifyOtpType.passwordReset.name
      });
    }
  }
}
