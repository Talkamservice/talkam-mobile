import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:talkam/common/widgets/custom_appbar.dart';
import 'package:talkam/common/widgets/custom_button.dart';
import 'package:talkam/common/widgets/custom_dialogs.dart';
import 'package:talkam/common/widgets/outlined_form_field.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/constants/dialog_texts.dart';
import 'package:talkam/core/constants/package_exports.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/core/navigation/route_url.dart';
import 'package:talkam/core/services/data/session_manager.dart';
import 'package:talkam/core/theme/pallets.dart';
import 'package:talkam/core/utils/extensions/context_extension.dart';
import 'package:talkam/features/settings/presentation/blocs/settings/settings_bloc.dart';

class _InstructionItem extends StatelessWidget {
  const _InstructionItem({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
            width: 8.w,
            height: 8.w,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20), color: Pallets.grey)),
        10.horizontalSpace,
        Expanded(child: TextView(text: text))
      ],
    );
  }
}

class DeleteAccountScreen extends StatefulWidget {
  const DeleteAccountScreen({super.key});

  @override
  State<DeleteAccountScreen> createState() => _DeleteAccountScreenState();
}

class _DeleteAccountScreenState extends State<DeleteAccountScreen> {
  var passwordController = TextEditingController();

  bool passwordObscured = true;

  var emailController = TextEditingController();

  var reasonController = TextEditingController();
  final bloc = SettingsBloc(injector.get(),injector.get());
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        padding: EdgeInsets.all(0.0),
        tittleText: "Delete Account",
        centerTile: false,
        showDivider: true,
      ),
      body: BlocListener<SettingsBloc, SettingsState>(
        bloc: bloc,
        listener: (context, state) {
          state.maybeWhen(
            orElse: () => null,
            deleteAccountFailure: (error) {
              context.pop();
              CustomDialogs.error(error);
            },
            deleteAccountLoading: () => CustomDialogs.showLoading(context),
            deleteAccountSuccess: (response) {
              context.pop();
              SessionManager.instance.logOut();
              context.goNamed(PageUrl.signUp);
              CustomDialogs.success('Account deleted');
            },
          );
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const TextView(
                    text: "Warning: Account Deletion is Permanent",
                    color: Colors.red,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                  20.verticalSpace,
                  const TextView(
                    text: deleteAccountIntro,
                  ),
                  20.verticalSpace,
                  ...deleteAccountInstructions.map(
                    (e) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: _InstructionItem(text: e),
                    ),
                  ),
                  30.verticalSpace,
                  OutlinedFormField(
                      controller: emailController,
                      validator: MultiValidator([
                        RequiredValidator(errorText: "Field is required"),
                        MinLengthValidator(5, errorText: "Invalid username"),
                      ]).call,
                      placeHolder: "Enter your username",
                      hint: "username"),
                  14.verticalSpace,
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
                  14.verticalSpace,
                  OutlinedFormField(
                      controller: reasonController,
                      maxLine: 5,

                      // validator: MultiValidator([
                      //   RequiredValidator(errorText: "Field is required"),
                      //   // MinLengthValidator(5,
                      //   //     errorText: "User name should be up to 5 characters"),
                      // ]).call,
                      placeHolder: "Reason for leaving",
                      hint: "(optional)"),
                  16.verticalSpace,
                  CustomButton(
                    text: 'Delete Account',
                    bgColor: Colors.red,
                    foregroundColor: Pallets.white,
                    onPressed: () {
                      if (formKey.currentState?.validate() ?? false) {
                        CustomDialogs.showConfirmDialog(
                          context,
                          tittle: 'Delete',
                          confirmButtonBgColor: Colors.red,
                          message: "Are sure you want to delete account ?",
                          onYes: () {
                            context.pop();
                            bloc.add(SettingsEvent.deleteAccount(
                                reason: reasonController.text));
                          },
                        );
                      }
                    },
                  ),
                  100.verticalSpace
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
