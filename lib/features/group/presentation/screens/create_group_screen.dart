import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:talkam/common/widgets/image_widget.dart';
import 'package:talkam/common/widgets/outlined_form_field.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/constants/dialog_texts.dart';
import 'package:talkam/core/constants/package_exports.dart';
import 'package:talkam/core/navigation/route_url.dart';
import 'package:talkam/core/theme/pallets.dart';
import 'package:talkam/core/utils/extensions/context_extension.dart';
import 'package:talkam/features/group/presentation/tabs/group_rules_tab.dart';
import 'package:talkam/features/group/presentation/widgets/create_group_header.dart';
import 'package:talkam/gen/assets.gen.dart';

class CreateGroupScreen extends StatefulWidget {
  const CreateGroupScreen({super.key});

  @override
  State<CreateGroupScreen> createState() => _CreateGroupScreenState();
}

class _CreateGroupScreenState extends State<CreateGroupScreen> {
  final groupNameController = TextEditingController();
  final categoryController = TextEditingController();
  final purposeController = TextEditingController();
  final groupInfoController = TextEditingController();
  final discoverabilityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.cardColor,
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Divider(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
            child: Row(
              children: [
                const Spacer(),
                TextButton(
                    style: TextButton.styleFrom(
                        backgroundColor: Pallets.primary,
                        shape: const StadiumBorder(),
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        foregroundColor: Pallets.white),
                    onPressed: () {
                      context.pushNamed(PageUrl.createGroupRulesScreen);
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const TextView(text: "Next"),
                        4.horizontalSpace,
                        const Icon(Icons.keyboard_arrow_right_rounded)
                      ],
                    ))
              ],
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          CreateGroupHeader(
            onBannerUpdated: (String bannerImage) {},
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  25.verticalSpace,
                  OutlinedFormField(
                      maxLine: 1,
                      radius: 8,
                      filled: true,
                      // padding: const EdgeInsets.symmetric(vertical: 16,horizontal: 16),
                      placeHolder: "Name",
                      validator:
                          RequiredValidator(errorText: "Field is required")
                              .call,
                      controller: groupNameController,
                      onChange: (d) {
                        setState(() {});
                      },
                      showRequiredAsterics: false,
                      hint: "Enter your group name"),
                  16.verticalSpace,
                  OutlinedFormField(
                      maxLine: 1,
                      radius: 8,
                      enabled: false,
                      filled: true,
                      preffix: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: CircleAvatar(
                          radius: 16,
                        ),
                      ),
                      suffix: const Icon(Icons.keyboard_arrow_down_rounded),
                      // padding: const EdgeInsets.symmetric(vertical: 16,horizontal: 16),
                      placeHolder: "Category",
                      validator:
                          RequiredValidator(errorText: "Field is required")
                              .call,
                      controller: groupNameController,
                      onChange: (d) {
                        setState(() {});
                      },
                      hintStyle: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w600),
                      showRequiredAsterics: false,
                      hint: "Select category"),
                  const TextView(
                    text: "All groups must be under a specific category.",
                  ),
                  16.verticalSpace,
                  OutlinedFormField(
                      maxLine: 10,
                      radius: 8,
                      minLine: 4,
                      filled: true,
                      maxLength: 100,

                      // padding: const EdgeInsets.symmetric(vertical: 16,horizontal: 16),
                      placeHolder: "Group purpose",
                      validator:
                          RequiredValidator(errorText: "Field is required")
                              .call,
                      controller: groupNameController,
                      onChange: (d) {
                        setState(() {});
                      },
                      showRequiredAsterics: false,
                      hint: "A short description of your group"),
                  16.verticalSpace,
                  OutlinedFormField(
                      maxLine: 10,
                      radius: 8,
                      minLine: 4,
                      filled: true,
                      maxLength: 500,
                      // padding: const EdgeInsets.symmetric(vertical: 16,horizontal: 16),
                      placeHolder: "Group information",
                      validator:
                          RequiredValidator(errorText: "Field is required")
                              .call,
                      controller: groupNameController,
                      onChange: (d) {
                        setState(() {});
                      },
                      showRequiredAsterics: false,
                      hint: "Any and all information for this group"),
                  16.verticalSpace,
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircularBorder(
                          child: ImageWidget(
                              imageUrl: Assets.images.svgs.keylock)),
                      8.horizontalSpace,
                      Expanded(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          OutlinedFormField(
                              maxLine: 1,
                              radius: 8,
                              enabled: false,
                              filled: true,
                              suffix:
                                  const Icon(Icons.keyboard_arrow_down_rounded),
                              // padding: const EdgeInsets.symmetric(vertical: 16,horizontal: 16),
                              placeHolder: "Discoverability",
                              validator: RequiredValidator(
                                      errorText: "Field is required")
                                  .call,
                              controller: groupNameController,
                              onChange: (d) {
                                setState(() {});
                              },
                              hintStyle: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w600),
                              showRequiredAsterics: false,
                              hint: "Public / Open to everyone"),
                          const TextView(
                            text: publicGroupInfo,
                          ),
                        ],
                      ))
                    ],
                  ),
                  50.verticalSpace
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
