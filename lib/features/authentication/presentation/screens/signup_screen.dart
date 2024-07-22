import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:talkam/common/widgets/custom_appbar.dart';
import 'package:talkam/common/widgets/custom_button.dart';
import 'package:talkam/common/widgets/custom_dialogs.dart';
import 'package:talkam/common/widgets/image_widget.dart';
import 'package:talkam/common/widgets/outlined_form_field.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/constants/onboarding_texts.dart';
import 'package:talkam/core/constants/package_exports.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/core/navigation/path_params.dart';
import 'package:talkam/core/navigation/route_url.dart';
import 'package:talkam/core/utils/extensions/context_extension.dart';
import 'package:talkam/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:talkam/features/authentication/presentation/screens/verify_otp_screen.dart';
import 'package:talkam/gen/assets.gen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool passwordObscured = true;
  final _formKey = GlobalKey<FormState>();
  final authBloc = AuthBloc(injector.get());

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      bloc: authBloc,
      listener: _listenToAuthBloc,
      builder: (context, state) {
        return Scaffold(
          appBar: CustomAppBar(
            fgColor: context.colorScheme.onSurface,
            tittle: ImageWidget(imageUrl: Assets.images.svgs.logo2),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    29.verticalSpace,
                    const TextView(
                      text: "Create Account",
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                    ),
                    4.verticalSpace,
                    Row(
                      children: [
                        const TextView(
                          text: "Already have an account? ",
                        ),
                        TextView(
                          text: "Login",
                          color: context.colorScheme.primary,
                          fontWeight: FontWeight.w700,
                          onTap: () {
                            context.goNamed(PageUrl.login);
                          },
                        ),
                      ],
                    ),
                    39.verticalSpace,
                    OutlinedFormField(
                      placeHolder: "Email address",
                      hint: "Enter your email address",
                      controller: emailController,
                      validator: MultiValidator([
                        RequiredValidator(errorText: "Field is required"),
                        EmailValidator(errorText: "Invalid email address")
                      ]).call,
                    ),
                    16.verticalSpace,
                    OutlinedFormField(
                      hint: "Enter your password",
                      placeHolder: "Password",
                      obscure: passwordObscured,
                      controller: passwordController,
                      validator: MultiValidator([
                        RequiredValidator(errorText: "Field is required"),
                        MinLengthValidator(8,
                            errorText: "Password should be up tp 8 characters"),
                      ]).call,
                      suffix: InkWell(
                        onTap: () {
                          setState(() {
                            passwordObscured = !passwordObscured;
                          });
                        },
                        child: Icon(
                          passwordObscured
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                          color: context.colorScheme.onBackground,
                        ),
                      ),
                    ),
                    28.verticalSpace,
                    const TextView(
                      text: introMessage,
                      align: TextAlign.center,
                      fontSize: 12,
                    ),
                    17.verticalSpace,
                    CustomButton(
                      child: const TextView(
                        text: "Sign Up",
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                      ),
                      onPressed: () {
                        signUp(context);
                      },
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void signUp(BuildContext context) {
    if (_formKey.currentState?.validate() ?? false) {
      authBloc.add(RegisterEvent(
          email: emailController.text, password: passwordController.text));
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

    if (state is RegisterSuccess) {
      context.pop();
      CustomDialogs.success("Signup successful.");
      context.pushNamed(PageUrl.verifyOtpScreen, queryParameters: {
        PathParam.email: emailController.text.trim(),
        PathParam.otpType: VerifyOtpType.auth.name
      });
    }
  }
}
