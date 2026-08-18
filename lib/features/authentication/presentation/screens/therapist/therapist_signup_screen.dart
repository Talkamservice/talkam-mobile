import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:talkam/common/widgets/custom_appbar.dart';
import 'package:talkam/common/widgets/custom_button.dart';
import 'package:talkam/common/widgets/custom_dialogs.dart';
import 'package:talkam/common/widgets/custom_text_field.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/core/navigation/route_url.dart';
import 'package:talkam/core/theme/pallets.dart';
import 'package:talkam/features/authentication/dormain/repository/auth_repository.dart';
import 'package:talkam/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:talkam/features/therapist_application/presentation/bloc/therapist_application_bloc.dart';

/// Therapist-specific sign-up screen (name / email / phone / password).
/// Located between the Requirements screen and the OTP verify screen in the
/// therapist onboarding wizard. On success the server returns a token and the
/// session is saved, so the rest of the wizard runs authenticated.
class TherapistSignupScreen extends StatefulWidget {
  const TherapistSignupScreen({super.key, required this.bloc});

  /// The single TherapistApplicationBloc instance shared across the whole
  /// wizard — carried forward so each screen can accumulate state.
  final TherapistApplicationBloc bloc;

  @override
  State<TherapistSignupScreen> createState() => _TherapistSignupScreenState();
}

class _TherapistSignupScreenState extends State<TherapistSignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _passwordObscured = true;
  bool _confirmPasswordObscured = true;

  final _authBloc = AuthBloc(injector.get<AuthRepository>());

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _authBloc.close();
    super.dispose();
  }

  bool get _isFormValid {
    final name = _nameController.text.trim();
    final email = _emailController.text.trim();
    final phone = _phoneController.text.trim();
    final pass = _passwordController.text;
    final confirm = _confirmPasswordController.text;
    return name.isNotEmpty &&
        email.isNotEmpty &&
        phone.isNotEmpty &&
        pass.length >= 8 &&
        pass == confirm;
  }

  void _submit() {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    _authBloc.add(RegisterTherapistEvent(
      fullName: _nameController.text.trim(),
      email: _emailController.text.trim(),
      phoneNumber: _phoneController.text.trim(),
      password: _passwordController.text,
      passwordConfirmation: _confirmPasswordController.text,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(
        bgColor: Colors.transparent,
        elevation: 0,
      ),
      body: BlocConsumer<AuthBloc, AuthState>(
        bloc: _authBloc,
        listener: _onAuthState,
        builder: (context, state) {
          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Form(
              key: _formKey,
              onChanged: () => setState(() {}),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const TextView(
                    text: "Create your\ntherapist account",
                    fontSize: 26,
                    fontWeight: FontWeight.w800,
                    color: Pallets.boldBlackV2,
                    lineHeight: 1.25,
                    align: TextAlign.left,
                  ),
                  8.verticalSpace,
                  const TextView(
                    text: "Enter your details to get started.",
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Pallets.grey400,
                    align: TextAlign.left,
                  ),
                  28.verticalSpace,
                  CustomTextField(
                    label: "Full Name",
                    hint: "Enter your full name",
                    controller: _nameController,
                    keyboardType: TextInputType.name,
                    validator: (v) =>
                        (v == null || v.trim().isEmpty) ? "Name is required" : null,
                  ),
                  16.verticalSpace,
                  CustomTextField(
                    label: "Email Address",
                    hint: "Enter your email",
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    validator: (v) {
                      if (v == null || v.trim().isEmpty) return "Email is required";
                      if (!v.contains('@')) return "Enter a valid email";
                      return null;
                    },
                  ),
                  16.verticalSpace,
                  CustomTextField(
                    label: "Phone Number",
                    hint: "e.g. +2348012345678",
                    controller: _phoneController,
                    keyboardType: TextInputType.phone,
                    validator: (v) =>
                        (v == null || v.trim().isEmpty)
                            ? "Phone number is required"
                            : null,
                  ),
                  16.verticalSpace,
                  CustomTextField(
                    label: "Password",
                    hint: "Min. 8 characters",
                    controller: _passwordController,
                    obscureText: _passwordObscured,
                    suffixIcon: IconButton(
                      icon: Icon(
                        _passwordObscured
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                        size: 20.sp,
                        color: Pallets.grey400,
                      ),
                      onPressed: () =>
                          setState(() => _passwordObscured = !_passwordObscured),
                    ),
                    validator: (v) {
                      if (v == null || v.isEmpty) return "Password is required";
                      if (v.length < 8) return "Password must be at least 8 characters";
                      return null;
                    },
                  ),
                  16.verticalSpace,
                  CustomTextField(
                    label: "Confirm Password",
                    hint: "Re-enter your password",
                    controller: _confirmPasswordController,
                    obscureText: _confirmPasswordObscured,
                    suffixIcon: IconButton(
                      icon: Icon(
                        _confirmPasswordObscured
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                        size: 20.sp,
                        color: Pallets.grey400,
                      ),
                      onPressed: () => setState(
                          () => _confirmPasswordObscured = !_confirmPasswordObscured),
                    ),
                    validator: (v) {
                      if (v == null || v.isEmpty) return "Please confirm your password";
                      if (v != _passwordController.text) return "Passwords do not match";
                      return null;
                    },
                  ),
                  40.verticalSpace,
                  CustomButton(
                    elevation: 0,
                    onPressed: _isFormValid ? _submit : null,
                    bgColor: Pallets.blueBubbleColor,
                    child: const TextView(
                      text: "Create Account",
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                  24.verticalSpace,
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _onAuthState(BuildContext context, AuthState state) {
    if (state is AuthLoading) {
      CustomDialogs.showLoading(context);
    }

    if (state is RegisterTherapistSuccess) {
      CustomDialogs.hideLoading(context);
      final email = _emailController.text.trim();
      final bloc = widget.bloc;
      // Navigate to the shared OTP verify screen. We pass [onVerified] as a
      // callback so the bloc instance (which can't travel through URL params)
      // is correctly forwarded to the personal-info wizard step.
      context.pushNamed(
        PageUrl.verifyOtpScreen,
        queryParameters: {
          'email': email,
          'otpType': 'therapistAuth',
        },
        extra: VerifyOtpCallbackExtra(
          onVerified: () {
            context.pushNamed(
              PageUrl.therapistPersonalInfoScreen,
              extra: bloc,
            );
          },
        ),
      );
    }

    if (state is AuthFailure) {
      CustomDialogs.hideLoading(context);
      CustomDialogs.error(state.error);
    }
  }
}

/// Carries the [onVerified] callback through GoRouter's [extra] parameter.
/// The [VerifyOtpScreen] checks for this type when [extra] is set.
class VerifyOtpCallbackExtra {
  const VerifyOtpCallbackExtra({required this.onVerified});
  final VoidCallback onVerified;
}
