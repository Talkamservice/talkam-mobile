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
import 'package:talkam/core/navigation/path_params.dart';
import 'package:talkam/core/navigation/route_url.dart';
import 'package:talkam/core/utils/extensions/context_extension.dart';
import 'package:talkam/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:talkam/features/authentication/presentation/screens/verify_otp_screen.dart';
import 'package:talkam/gen/assets.gen.dart';

class PassWordRecoveryScreen extends StatefulWidget {
  const PassWordRecoveryScreen({super.key});

  @override
  State<PassWordRecoveryScreen> createState() => _PassWordRecoveryScreenState();
}

class _PassWordRecoveryScreenState extends State<PassWordRecoveryScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool passwordObscured = true;
  final formkey = GlobalKey<FormState>();
  final bloc = AuthBloc(injector.get());

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: _listenToAuthBloc,
      bloc: bloc,
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
                text: "Reset Password",
                fontSize: 15,
                fontWeight: FontWeight.w700,
              ),
              onPressed: () {
                if (formkey.currentState?.validate() ?? false) {
                  bloc.add(ForgotPasswordEvent(emailController.text.trim()));
                  // context.pushNamed(PageUrl.emailSentScreen);
                }
              },
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Form(
              key: formkey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  29.verticalSpace,
                  const TextView(
                    text: "Password Recovery",
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                  ),
                  4.verticalSpace,
                  Row(
                    children: [
                      const TextView(
                        text: "Remembered your password?",
                      ),
                      TextView(
                        text: "Login",
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
                    placeHolder: "Email address",
                    hint: "Enter your email address",
                    controller: emailController,
                    validator: MultiValidator([
                      RequiredValidator(errorText: "Field is required"),
                      EmailValidator(errorText: "Invalid Email"),
                    ]).call,
                  ),
                  16.verticalSpace,
                ],
              ),
            ),
          ),
        );
      },
    );
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
        PathParam.email: emailController.text.trim(),
        PathParam.otpType: VerifyOtpType.passwordReset.name
      });
    }
  }
}
