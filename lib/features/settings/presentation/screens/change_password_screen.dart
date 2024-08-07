import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:talkam/common/widgets/custom_appbar.dart';
import 'package:talkam/common/widgets/custom_button.dart';
import 'package:talkam/common/widgets/custom_dialogs.dart';
import 'package:talkam/common/widgets/outlined_form_field.dart';
import 'package:talkam/core/constants/package_exports.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/core/utils/_utils.dart';
import 'package:talkam/core/utils/extensions/context_extension.dart';
import 'package:talkam/core/utils/validators.dart';
import 'package:talkam/features/profile/data/models/update_profile_payload.dart';
import 'package:talkam/features/profile/presentation/bloc/profile_bloc/profile_bloc.dart';
import 'package:talkam/features/profile/presentation/bloc/profile_bloc/profile_bloc.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  bool passwordObscured = true;
  bool confirmNewpasswordObscured = true;

  final passwordController = TextEditingController();
  final confirmNewpasswordController = TextEditingController();

  final profileBloc = ProfileBloc(injector.get());
  var password = '';
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProfileBloc, ProfileState>(
      bloc: profileBloc,
      listener: (context, state) {
        if (state is UpdateProfileLoading) {
          CustomDialogs.showLoading(context);
        }
        if (state is UpdateProfileFailure) {
          context.pop();
          CustomDialogs.error(state.error);
        }
        if (state is UpdateProfileSuccess) {
          context.pop();
          context.pop();
          CustomDialogs.success("Password updated");
        }
      },
      child: Scaffold(
        appBar: const CustomAppBar(
          padding: EdgeInsets.all(0.0),
          tittleText: "Change Password",
          centerTile: false,
          showDivider: true,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                23.verticalSpace,
                OutlinedFormField(
                  hint: "*******************",
                  placeHolder: "Enter new password",
                  obscure: passwordObscured,
                  controller: passwordController,
                  onChange: (d) {
                    password = passwordController.text;

                    // setState(() {});
                  },
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
                14.verticalSpace,
                OutlinedFormField(
                  hint: "*******************",
                  placeHolder: "Confirm new password",
                  obscure: confirmNewpasswordObscured,
                  controller: confirmNewpasswordController,
                  onChange: (d) {
                    // setState(() {});
                  },
                  validator: MultiValidator([
                    RequiredValidator(errorText: "Field is required"),
                    MinLengthValidator(8,
                        errorText: "Password should be up to 8 characters"),
                    ConfirmPasswordValidator(
                        errorText: "Password mismatch",
                        comparedPassword: password)
                  ]).call,
                  suffix: InkWell(
                    onTap: () {
                      setState(() {
                        confirmNewpasswordObscured =
                            !confirmNewpasswordObscured;
                      });
                    },
                    child: Icon(
                      confirmNewpasswordObscured
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                      color: context.colorScheme.onSurface,
                    ),
                  ),
                ),
                46.verticalSpace,
                CustomButton(
                  text: "Save Changes",
                  onPressed: () {
                    setState(() {});
                    Future.delayed(
                      Durations.short2,
                      () {
                        if (formKey.currentState?.validate() ?? false) {
                          profileBloc.add(UpdateProfileEvent(
                              UpdateProfilePayload(
                                  password: passwordController.text,
                                  paswordConfirmation:
                                      confirmNewpasswordController.text)));
                        }
                      },
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
