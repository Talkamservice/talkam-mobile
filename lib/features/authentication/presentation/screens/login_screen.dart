import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:talkam/common/widgets/custom_appbar.dart';
import 'package:talkam/common/widgets/custom_button.dart';
import 'package:talkam/common/widgets/custom_dialogs.dart';
import 'package:talkam/common/widgets/image_widget.dart';
import 'package:talkam/common/widgets/outlined_form_field.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/constants/package_exports.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/core/mixins/login_mixin.dart';
import 'package:talkam/core/navigation/route_url.dart';
import 'package:talkam/core/utils/extensions/context_extension.dart';
import 'package:talkam/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:talkam/gen/assets.gen.dart';

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
          appBar: CustomAppBar(
            fgColor: context.colorScheme.onSurface,
            tittle: ImageWidget(imageUrl: Assets.images.svgs.logo2),
          ),
          bottomNavigationBar: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24),
            child: CustomButton(
              child: const TextView(
                text: "Login",
                fontSize: 15,
                fontWeight: FontWeight.w700,
              ),
              onPressed: () {
                login(context);
              },
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Form(
              key: formKey,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    29.verticalSpace,
                    const TextView(
                      text: "Sign In",
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                    ),
                    4.verticalSpace,
                    Row(
                      children: [
                        const TextView(
                          text: "Don’t have an account? ",
                        ),
                        TextView(
                          text: "Create one",
                          color: context.colorScheme.primary,
                          fontWeight: FontWeight.w700,
                          onTap: () {
                            context.pushNamed(PageUrl.signUp);
                          },
                        ),
                      ],
                    ),
                    39.verticalSpace,
                    OutlinedFormField(
                        controller: emailController,
                        validator: MultiValidator([
                          RequiredValidator(errorText: "Field is required"),
                          MinLengthValidator(5,
                              errorText:
                                  "User name should be up to 5 characters"),
                        ]).call,
                        placeHolder: "Username / Email address",
                        hint: "Enter your email address or Username"),
                    16.verticalSpace,
                    OutlinedFormField(
                      hint: "Enter your password",
                      placeHolder: "Password",
                      obscure: passwordObscured,
                      controller: passwordController,
                      validator: MultiValidator([
                        RequiredValidator(errorText: "Field is required"),
                        MinLengthValidator(8,
                            errorText: "Password should be up to 8 characters"),
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
                    18.verticalSpace,
                    Align(
                      alignment: Alignment.bottomRight,
                      child: TextButton(
                          onPressed: () {
                            context.pushNamed(PageUrl.passwordRecoveryScreen);
                          },
                          child: const TextView(
                            text: "Forgot Password",
                            fontWeight: FontWeight.w700,
                          )),
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

  void login(BuildContext context) {
    if (formKey.currentState?.validate() ?? false) {
      bloc.add(LoginEvent(
          emailController.text.trim(), passwordController.text.trim()));

      // context.goNamed(PageUrl.homeScreen);
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

    if (state is LoginSuccess) {
      context.pop();
      CustomDialogs.success("Login successful.");
      handleLoginSuccess(context, state.response.data.user);
    }
  }
}
