import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:talkam/common/widgets/custom_button.dart';
import 'package:talkam/common/widgets/custom_dialogs.dart';
import 'package:talkam/common/widgets/custom_outlined_button.dart';
import 'package:talkam/common/widgets/outlined_form_field.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/constants/package_exports.dart';
import 'package:talkam/core/theme/pallets.dart';
import 'package:talkam/core/utils/extensions/context_extension.dart';
import 'package:talkam/core/utils/time_util.dart';
import 'package:talkam/features/group/data/models/create_group_payload.dart';

class ReasonPayload {
  String reason;
  DateTime sespensionEndDate;

  ReasonPayload({
    required this.reason,
    required this.sespensionEndDate,
  });

  ReasonPayload copyWith({
    String? reason,
    DateTime? suspensionEndDate,
  }) =>
      ReasonPayload(
        reason: reason ?? this.reason,
        sespensionEndDate: suspensionEndDate ?? this.sespensionEndDate,
      );

  factory ReasonPayload.fromJson(Map<String, dynamic> json) => ReasonPayload(
        reason: json["suspension_reason"],
        sespensionEndDate: json["suspension_end"],
      );

  Map<String, dynamic> toJson() => {
        "suspension_reason": reason,
        "suspension_end": sespensionEndDate,
      };
}

class SuspensionReasonSheet extends StatefulWidget {
  const SuspensionReasonSheet({super.key});

  @override
  State<SuspensionReasonSheet> createState() => _SuspensionReasonSheetState();
}

class _SuspensionReasonSheetState extends State<SuspensionReasonSheet> {
  final ruleController = TextEditingController();
  final descriptionController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  DateTime? suspensionDate;

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
                text: "Suspension Reason",
                fontWeight: FontWeight.w700,
                fontSize: 18,
              ),
              10.verticalSpace,
              const Divider(
                thickness: 1,
              ),
              20.verticalSpace,
              OutlinedFormField(
                  maxLine: 10,
                  minLine: 4,
                  filled: true,
                  // padding: const EdgeInsets.symmetric(vertical: 16,horizontal: 16),
                  placeHolder: "Reason",
                  validator: RequiredValidator(errorText: "Field is required").call,
                  controller: ruleController,
                  onChange: (d) {
                    setState(() {});
                  },
                  showRequiredAsterics: true,
                  hint: "Suspension reason"),
              15.verticalSpace,
              TextButton(
                  style: TextButton.styleFrom(
                      foregroundColor: Pallets.grey, padding: const EdgeInsets.all(16), side: const BorderSide(color: Pallets.borderGrey, width: 1)),
                  onPressed: () {
                    selectDate(context);
                  },
                  child: Row(
                    children: [
                      Expanded(
                          child: TextView(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              text: suspensionDate != null ? TimeUtil.formatDate(suspensionDate!.toIso8601String()) : "Suspension end date")),
                      const Icon(Icons.keyboard_arrow_right)
                    ],
                  )),
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
                          if (suspensionDate != null) {
                            context.pop(ReasonPayload(reason: ruleController.text, sespensionEndDate: suspensionDate!));
                          } else {
                            CustomDialogs.error("Please select the suspension end date");
                          }
                        }
                      },
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<DateTime?> selectDate(BuildContext context) async {
    final now = DateTime.now();
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: now,
      lastDate: DateTime(now.year + 5),
    );
    if (pickedDate != null && pickedDate != now) {
      suspensionDate = pickedDate;
      setState(() {});
      return pickedDate;
    } else {
      return null; // User canceled or did not select
    }
  }
}
