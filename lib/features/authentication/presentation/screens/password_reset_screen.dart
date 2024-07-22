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
import 'package:talkam/core/navigation/route_url.dart';
import 'package:talkam/core/utils/extensions/context_extension.dart';
import 'package:talkam/core/utils/validators.dart';
import 'package:talkam/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:talkam/gen/assets.gen.dart';

class PassWordResetScreen extends StatefulWidget {
  const PassWordResetScreen({super.key, required this.otp});

  final String otp;

  @override
  State<PassWordResetScreen> createState() => _PassWordResetScreenState();
}

class _PassWordResetScreenState extends State<PassWordResetScreen> {
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  bool passwordObscured = true;
  bool confirmPasswordObscured = true;
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
                text: "Save New Password",

                fontSize: 15,
                fontWeight: FontWeight.w700,
              ),
              onPressed: () {
                if (formkey.currentState?.validate() ?? false) {
                  bloc.add(PasswordResetEvent(
                      widget.otp, passwordController.text.trim()));
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
                    text: "Reset Password",
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                  ),
                  30.verticalSpace,
                  OutlinedFormField(
                    placeHolder: "New Password",
                    hint: "*************************",
                    controller: passwordController,
                    onChange: (d) {
                      setState(() {});
                    },
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
                  16.verticalSpace,
                  OutlinedFormField(
                    placeHolder: "Confirm new password",
                    hint: "*************************",
                    controller: confirmPasswordController,
                    onChange: (d) {
                      setState(() {});
                    },
                    validator: MultiValidator([
                      RequiredValidator(errorText: "Field is required"),
                      MinLengthValidator(8,
                          errorText: "Password should be up to 8 characters"),
                      ConfirmPasswordValidator(
                          errorText: "Password mismatch",
                          comparedPassword: passwordController.text)
                    ]).call,
                    suffix: InkWell(
                      onTap: () {
                        setState(() {
                          confirmPasswordObscured = !confirmPasswordObscured;
                        });
                      },
                      child: Icon(
                        confirmPasswordObscured
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                        color: context.colorScheme.onBackground,
                      ),
                    ),
                  ),
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

    if (state is PasswordResetSuccess) {
      context.pop();
      CustomDialogs.success("Password reset successful, Please login");
      context.goNamed(
        PageUrl.login,
      );
    }
  }
}
