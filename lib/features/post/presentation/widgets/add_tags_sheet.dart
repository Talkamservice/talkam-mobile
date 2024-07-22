import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:talkam/common/widgets/image_widget.dart';
import 'package:talkam/common/widgets/outlined_form_field.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/constants/package_exports.dart';
import 'package:talkam/core/theme/pallets.dart';
import 'package:talkam/core/utils/extensions/context_extension.dart';
import 'package:talkam/gen/assets.gen.dart';

class AddTagsSheet extends StatefulWidget {
  const AddTagsSheet({super.key});

  @override
  State<AddTagsSheet> createState() => _AddTagsSheetState();
}

class _AddTagsSheetState extends State<AddTagsSheet> {
  final tittleController = TextEditingController();
  final List<TextEditingController> tagControllers = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
  ];

  int pollHours = 7;
  int pollDays = 2;
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      width: 1.sw,
      decoration: BoxDecoration(color: context.theme.cardColor),
      child: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextView(
                    text: "Add tags",
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w600,
                  ),
                  IconButton(
                      onPressed: () {
                        context.pop();
                      },
                      icon: const Icon(Icons.close))
                ],
              ),
              6.verticalSpace,
              const Divider(),
              6.verticalSpace,
              const TextView(
                  text:
                      "Add at least one tag. Tags make your post easier to find."),
              6.verticalSpace,
              const Divider(),
              ...List.generate(
                tagControllers.length,
                (index) => Row(
                  children: [
                    Expanded(
                        child: OutlinedFormField(
                            validator: RequiredValidator(
                                    errorText: "Field is required")
                                .call,
                            controller: tagControllers[index],
                            hint: "Tag ${index + 1}")),
                    if (index + 1 > 3)
                      IconButton(
                          onPressed: () {
                            tagControllers.removeAt(index);
                            setState(() {});
                          },
                          icon: ImageWidget(
                              imageUrl: Assets.images.svgs.trash03)),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                      style: TextButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 16),
                          shape: const StadiumBorder(
                              side: BorderSide(color: Pallets.borderGrey))),
                      onPressed: () {
                        tagControllers.add(TextEditingController());
                        setState(() {});
                      },
                      child: const TextView(
                        text: "Add choice",
                        fontWeight: FontWeight.w700,
                      )),
                  TextButton(
                      style: TextButton.styleFrom(
                          backgroundColor: Pallets.primary,
                          foregroundColor: Pallets.white,
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 16),
                          shape: const StadiumBorder()),
                      onPressed: () {
                        if (formKey.currentState?.validate() ?? false) {
                          context.pop(tagControllers
                              .map(
                                (e) => e.text,
                              )
                              .toList());
                        }
                      },
                      child: const TextView(
                        text: "Save",
                        fontWeight: FontWeight.w700,
                      )),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
