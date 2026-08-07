import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:talkam/common/widgets/custom_appbar.dart';
import 'package:talkam/common/widgets/custom_button.dart';
import 'package:talkam/common/widgets/custom_countdown.dart';
import 'package:talkam/common/widgets/custom_dialogs.dart';
import 'package:talkam/common/widgets/otp_field.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/constants/package_exports.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/core/navigation/path_params.dart';
import 'package:talkam/core/navigation/route_url.dart';
import 'package:talkam/core/theme/pallets.dart';
import 'package:talkam/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:talkam/features/home/dormain/mixins/refresh_app_mixin.dart';

enum VerifyOtpType {
  auth,
  passwordReset,
  returningUser,
}

class VerifyOtpScreen extends StatefulWidget {
  const VerifyOtpScreen({super.key, required this.email, required this.verifyOtpType});

  final VerifyOtpType verifyOtpType;

  final String email;

  @override
  State<VerifyOtpScreen> createState() => _VerifyOtpScreenState();
}

class _VerifyOtpScreenState extends State<VerifyOtpScreen> with RefreshAppMixin {
  // final TextEditingController emailController = TextEditingController();
  final otpCtrl = TextEditingController();
  bool isSent = true;
  final otpLength = 6;
  DateTime _countDownEndTime = DateTime.now().add(const Duration(minutes: 1));
  bool isCounting = true;
  bool hasOtpError = false;
  final formKey = GlobalKey<FormState>();
  final _authBloc = AuthBloc(injector.get());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(
        bgColor: Colors.transparent,
        elevation: 0,
      ),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: _listenToOtpBloc,
        bloc: _authBloc,
        builder: (context, state) {
          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              // ── Header ─────────────────────────────────────────────
              TextView(
                text: tittle,
                fontWeight: FontWeight.w800,
                fontSize: 28,
                color: Pallets.boldBlackV2,
              ),
              8.verticalSpace,
              Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  const TextView(
                    text: "Please enter the PIN we sent to",
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Pallets.grey400,
                    lineHeight: 1.4,
                  ),
                  TextView(
                    text: " ${widget.email[0]}*********${widget.email.substring(4)} ",
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Pallets.boldBlackV2,
                    lineHeight: 1.4,
                  ),
                ],
              ),

              40.verticalSpace,

              // ── PIN boxes ──────────────────────────────────────────
              Form(
                key: formKey,
                onChanged: () {
                  setState(() {});
                },
                child: Center(
                  child: OtpField(
                    count: otpLength,
                    controller: otpCtrl,
                    hasError: hasOtpError,
                    onChanged: (p0) {
                      // Clear the red state as soon as the user edits the PIN
                      setState(() => hasOtpError = false);
                    },
                  ),
                ),
              ),

              56.verticalSpace,

              // ── Confirm button ─────────────────────────────────────
              CustomButton(
                onPressed: () {
                  _verifyOtp();
                  // context.pushNamed(PageUrl.passwordResetScreen);
                },
                bgColor: Pallets.blueBubbleColor,
                borderRadius: BorderRadius.circular(14.r),
                padding: EdgeInsets.symmetric(vertical: 14.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const TextView(
                      text: "Confirm",
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                    6.horizontalSpace,
                    Icon(
                      Icons.chevron_right_rounded,
                      color: Colors.white,
                      size: 20.sp,
                    ),
                  ],
                ),
              ),

              24.verticalSpace,

              // ── Resend ─────────────────────────────────────────────
              Center(
                child: Column(
                  children: [
                    // Disabled until the countdown finishes.
                    TextView(
                      text: 'Resend Code',
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: isCounting
                          ? Pallets.grey75
                          : Pallets.blueBubbleColor,
                      onTap: isCounting ? null : _resendOtp,
                    ),
                    8.verticalSpace,
                    Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        const TextView(
                          text: "Haven’t received the Code yet? ",
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Pallets.grey500,
                        ),
                        if (isCounting == true) ...[
                          const TextView(
                            text: "Resend code ",
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: Pallets.blueBubbleColor,
                          ),
                          CustomCountDown(
                            endTime: _countDownEndTime,
                            onEnd: () {
                              isCounting = false;
                              setState(() {});
                            },
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w700,
                              color: Pallets.blueBubbleColor,
                            ),
                          ),
                          const TextView(
                            text: "s",
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: Pallets.blueBubbleColor,
                          ),
                        ]
                      ],
                    ),
                  ],
                )
              ),

              32.verticalSpace,
            ]),
          );
        },
      ),
    );
  }

  String get tittle {
    return widget.verifyOtpType == VerifyOtpType.auth ? "Verify Account" : "Verify Email";
  }

  void _resendOtp() {
    _authBloc.add(SendOtpEvent(widget.email, otpType));
  }

  void _verifyOtp() {
    _authBloc.add(VerifyOtpEvent(code: otpCtrl.text, email: widget.email, type: otpType));
  }

  String get otpType {
    return widget.verifyOtpType == VerifyOtpType.passwordReset ? "password_reset" : "verify_email";
  }

  void _listenToOtpBloc(BuildContext context, AuthState state) {
    if (state is AuthLoading) {
      CustomDialogs.showLoading(context);
    }

    if (state is VerifyOtpSuccessState) {
      switch (widget.verifyOtpType) {
        case VerifyOtpType.auth:
          context.goNamed(PageUrl.userTypeSelectionScreen);
          break;
        case VerifyOtpType.passwordReset:
          context.pushNamed(PageUrl.passWordResetScreen, queryParameters: {
            PathParam.email: widget.email,
            PathParam.otp: otpCtrl.text,
          });
        case VerifyOtpType.returningUser:
          refreshApp();
          context.goNamed(PageUrl.userTypeSelectionScreen);
      }
      CustomDialogs.success('Otp verified successfully');
      // context.goNamed(PageUrl.createNewPassword,
      //     queryParameters: {PathParam.email: widget.email});
    }
    if (state is OtpSentState) {
      otpCtrl.clear();
      setState(() {
        isCounting = true;
        hasOtpError = false;
        _countDownEndTime = DateTime.now().add(const Duration(minutes: 1));
      });
      CustomDialogs.hideLoading(context);
      CustomDialogs.success('Otp resent successfully');
    }

    if (state is AuthFailure) {
      CustomDialogs.hideLoading(context);
      setState(() => hasOtpError = true);
      CustomDialogs.error(state.error);
    }
  }
}
