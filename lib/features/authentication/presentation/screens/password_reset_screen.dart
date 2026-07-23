import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:talkam/common/widgets/custom_appbar.dart';
import 'package:talkam/common/widgets/custom_button.dart';
import 'package:talkam/common/widgets/custom_countdown.dart';
import 'package:talkam/common/widgets/custom_dialogs.dart';
import 'package:talkam/common/widgets/custom_text_field.dart';
import 'package:talkam/common/widgets/otp_field.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/constants/package_exports.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/core/navigation/route_url.dart';
import 'package:talkam/core/theme/pallets.dart';
import 'package:talkam/core/utils/validators.dart';
import 'package:talkam/features/authentication/presentation/bloc/auth_bloc.dart';

class PassWordResetScreen extends StatefulWidget {
  const PassWordResetScreen({
    super.key,
    required this.otp,
    this.email = '',
  });

  final String otp;
  final String email;

  @override
  State<PassWordResetScreen> createState() => _PassWordResetScreenState();
}

class _PassWordResetScreenState extends State<PassWordResetScreen> {
  static const int _otpLength = 6;
  static const int _minPasswordLength = 8;

  final _otpController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final bloc = AuthBloc(injector.get());

  bool _passwordObscured = true;
  bool _confirmPasswordObscured = true;
  bool _hasError = false;

  DateTime _countDownEndTime = DateTime.now().add(const Duration(minutes: 1));
  bool isCounting = true;

  bool get _isFormValid {
    final password = _passwordController.text.trim();
    return password.length >= _minPasswordLength &&
        password == _confirmPasswordController.text.trim();
  }

  @override
  void dispose() {
    _otpController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: _listenToAuthBloc,
      bloc: bloc,
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: const CustomAppBar(
            bgColor: Colors.transparent,
            elevation: 0,
          ),
          body: Form(
            key: _formKey,
            onChanged: () => setState(() {}),
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ── Header ─────────────────────────────────────────────
                  const TextView(
                    text: "Reset your Password",
                    fontSize: 28,
                    fontWeight: FontWeight.w800,
                    color: Pallets.boldBlackV2,
                  ),
                  8.verticalSpace,
                  Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      const TextView(
                        text: "A $_otpLength-digit code was sent to",
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Pallets.grey400,
                        lineHeight: 1.4,
                      ),
                      TextView(
                        text: " ${widget.email}",
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: Pallets.boldBlackV2,
                        lineHeight: 1.4,
                      ),
                    ],
                  ),

                  40.verticalSpace,

                  // ── Code boxes ─────────────────────────────────────────
                  // Display only — the reset call still uses the code that was
                  // already verified on the previous screen.
                  Center(
                    child: OtpField(
                      count: _otpLength,
                      controller: _otpController,
                      hasError: _hasError,
                      onChanged: (_) => setState(() => _hasError = false),
                    ),
                  ),

                  24.verticalSpace,

                  // ── New password ───────────────────────────────────────
                  CustomTextField(
                    label: "New Password",
                    hint: "Enter your Password",
                    controller: _passwordController,
                    obscureText: _passwordObscured,
                    validator: MultiValidator([
                      RequiredValidator(errorText: "Field is required"),
                      MinLengthValidator(_minPasswordLength,
                          errorText:
                              "Password should be up to $_minPasswordLength characters"),
                    ]).call,
                    suffixIcon: IconButton(
                      icon: Icon(
                        _passwordObscured
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                        color: _hasError ? Pallets.errorRed : Pallets.grey400,
                      ),
                      onPressed: () => setState(
                          () => _passwordObscured = !_passwordObscured),
                    ),
                  ),

                  16.verticalSpace,

                  // ── Confirm password ───────────────────────────────────
                  CustomTextField(
                    label: "Confirm Passwords",
                    hint: "Enter your Password",
                    controller: _confirmPasswordController,
                    obscureText: _confirmPasswordObscured,
                    validator: MultiValidator([
                      RequiredValidator(errorText: "Field is required"),
                      MinLengthValidator(_minPasswordLength,
                          errorText:
                              "Password should be up to $_minPasswordLength characters"),
                      ConfirmPasswordValidator(
                          errorText: "Password mismatch",
                          comparedPassword: _passwordController.text)
                    ]).call,
                    suffixIcon: IconButton(
                      icon: Icon(
                        _confirmPasswordObscured
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                        color: _hasError ? Pallets.errorRed : Pallets.grey400,
                      ),
                      onPressed: () => setState(() =>
                          _confirmPasswordObscured = !_confirmPasswordObscured),
                    ),
                  ),

                  24.verticalSpace,

                  // ── Reset button ───────────────────────────────────────
                  CustomButton(
                    elevation: 0,
                    onPressed: _isFormValid ? _resetPassword : null,
                    child: const TextView(
                      text: "Reset Password",
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
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
                              text: "Didn’t receive the code? ",
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Pallets.grey500,
                            ),
                            if (isCounting) ...[
                              const TextView(
                                text: "Resend code ",
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: Pallets.blueBubbleColor,
                              ),
                              CustomCountDown(
                                endTime: _countDownEndTime,
                                onEnd: () => setState(() => isCounting = false),
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
                            ],
                          ],
                        ),
                      ],
                    ),
                  ),

                  32.verticalSpace,
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _resetPassword() {
    if (_formKey.currentState?.validate() ?? false) {
      bloc.add(
          PasswordResetEvent(widget.otp, _passwordController.text.trim()));
    }
  }

  void _resendOtp() {
    bloc.add(SendOtpEvent(widget.email, "password_reset"));
  }

  void _listenToAuthBloc(BuildContext context, AuthState state) {
    if (state is AuthLoading) {
      CustomDialogs.showLoading(context);
    }
    if (state is AuthFailure) {
      context.pop();
      setState(() => _hasError = true);
      CustomDialogs.error(state.error);
    }
    if (state is OtpSentState) {
      CustomDialogs.hideLoading(context);
      setState(() {
        isCounting = true;
        _hasError = false;
        _countDownEndTime = DateTime.now().add(const Duration(minutes: 1));
      });
      CustomDialogs.success('Otp resent successfully');
    }
    if (state is PasswordResetSuccess) {
      context.pop();
      CustomDialogs.success("Password reset successful, Please login");
      context.goNamed(
        PageUrl.login,
      );
    }
  }
}
