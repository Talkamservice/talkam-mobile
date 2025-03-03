import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
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
  final otpLength = 4;
  DateTime _countDownEndTime = DateTime.now().add(const Duration(minutes: 1));
  bool isCounting = true;
  final formKey = GlobalKey<FormState>();
  final _authBloc = AuthBloc(injector.get());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: _listenToOtpBloc,
        bloc: _authBloc,
        builder: (context, state) {
          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
              18.verticalSpace,
              Center(
                child: TextView(
                  text: tittle,
                  fontWeight: FontWeight.w700,
                  fontSize: 24,
                ),
              ),
              4.verticalSpace,
              Wrap(
                children: [
                  const TextView(text: "Please enter the PIN we sent to"),
                  TextView(
                    text: "${widget.email[0]}*********${widget.email.substring(4)} ",
                    fontWeight: FontWeight.w700,
                  ),
                ],
              ),
              33.verticalSpace,
              Form(
                key: formKey,
                onChanged: () {
                  setState(() {});
                },
                child: Center(
                  child: OtpField(
                    count: otpLength,
                    controller: otpCtrl,
                    onChanged: (p0) {
                      setState(() {});
                    },
                  ),
                ),
              ),
              24.verticalSpace,
              CustomButton(
                text: "Confirm",
                onPressed: () {
                  _verifyOtp();
                  // context.pushNamed(PageUrl.passwordResetScreen);
                },
              ),
              33.verticalSpace,
              if (isCounting == true)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomCountDown(
                      endTime: _countDownEndTime,
                      onEnd: () {
                        isCounting = false;
                        setState(() {});
                      },
                      style: TextStyle(fontSize: 14.sp),
                    ),
                  ],
                ),
              if (isCounting != true)
                Column(
                  children: [
                    TextView(
                      text: "Haven’t received the PIN yet ?",
                      style: GoogleFonts.nunitoSans(fontSize: 15.sp, fontWeight: FontWeight.w600),
                    ),
                    Center(
                      child: TextButton(
                          onPressed: () {
                            _resendOtp();
                          },
                          child: const TextView(
                            text: 'Resend PIN',
                            decoration: TextDecoration.underline,
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                          )),
                    ),
                  ],
                ),
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
          context.goNamed(PageUrl.interestsScreen);
          break;
        case VerifyOtpType.passwordReset:
          context.pushNamed(PageUrl.passWordResetScreen, queryParameters: {
            PathParam.email: widget.email,
            PathParam.otp: otpCtrl.text,
          });
        case VerifyOtpType.returningUser:
          refreshApp();
          context.goNamed(PageUrl.interestsScreen);
      }
      CustomDialogs.success('Otp verified successfully');
      // context.goNamed(PageUrl.createNewPassword,
      //     queryParameters: {PathParam.email: widget.email});
    }
    if (state is OtpSentState) {
      otpCtrl.clear();
      setState(() {
        isCounting = true;
        _countDownEndTime = DateTime.now().add(const Duration(minutes: 1));
      });
      CustomDialogs.hideLoading(context);
      CustomDialogs.success('Otp resent successfully');
    }

    if (state is AuthFailure) {
      CustomDialogs.hideLoading(context);
      CustomDialogs.error(state.error);
    }
  }
}
