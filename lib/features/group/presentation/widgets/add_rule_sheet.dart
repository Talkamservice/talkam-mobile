import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:talkam/common/widgets/custom_button.dart';
import 'package:talkam/common/widgets/custom_outlined_button.dart';
import 'package:talkam/common/widgets/outlined_form_field.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/constants/package_exports.dart';
import 'package:talkam/core/theme/pallets.dart';
import 'package:talkam/core/utils/extensions/context_extension.dart';
import 'package:talkam/features/group/data/models/create_group_payload.dart';

class AddRuleSheet extends StatefulWidget {
  const AddRuleSheet({super.key});

  @override
  State<AddRuleSheet> createState() => _AddRuleSheetState();
}

class _AddRuleSheetState extends State<AddRuleSheet> {
  final ruleController = TextEditingController();
  final descriptionController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: context.theme.cardColor),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const TextView(
                text: "Add Rule",
                fontWeight: FontWeight.w700,
                fontSize: 18,
              ),
              10.verticalSpace,
              const Divider(
                thickness: 1,
              ),
              20.verticalSpace,
              OutlinedFormField(
                  maxLine: 1,
                  radius: 8,
                  filled: true,
                  // padding: const EdgeInsets.symmetric(vertical: 16,horizontal: 16),
                  placeHolder: "Rule",
                  validator:
                  RequiredValidator(errorText: "Field is required").call,
                  controller: ruleController,
                  onChange: (d) {
                    setState(() {});
                  },
                  showRequiredAsterics: false,
                  hint: "Stay on topic"),
              15.verticalSpace,
              OutlinedFormField(
                  maxLine: 10,
                  minLine: 4,
                  radius: 8,
                  filled: true,
                  // padding: const EdgeInsets.symmetric(vertical: 16,horizontal: 16),
                  placeHolder: "Description",
                  validator:
                  RequiredValidator(errorText: "Field is required").call,
                  controller: descriptionController,
                  onChange: (d) {
                    setState(() {});
                  },
                  showRequiredAsterics: false,
                  hint: "Enter description"),
              30.verticalSpace,
              Row(
                children: [
                  Expanded(
                    child: CustomOutlinedButton(
                        outlinedColr: Pallets.red,
                        foreGroundColor: Pallets.red,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        onPressed: () {
                          context.pop();
                        },
                        child: const TextView(
                          text: "Cancel",
                          fontWeight: FontWeight.w700,
                        )),
                  ),
                  10.horizontalSpace,
                  Expanded(
                    child: CustomButton(
                      text: "Save",
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      foregroundColor: Pallets.white,
                      onPressed: () {
                        if (formKey.currentState?.validate() ?? false) {
                          context.pop(GuidelinePayload(
                              title: ruleController.text,

                              description: descriptionController.text));
                        }
                      },
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
