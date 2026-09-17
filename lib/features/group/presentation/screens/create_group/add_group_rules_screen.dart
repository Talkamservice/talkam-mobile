import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:talkam/common/widgets/custom_dialogs.dart';
import 'package:talkam/common/widgets/image_widget.dart';
import 'package:talkam/common/widgets/outlined_form_field.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/constants/package_exports.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/core/navigation/route_url.dart';
import 'package:talkam/core/theme/pallets.dart';
import 'package:talkam/core/utils/extensions/context_extension.dart';
import 'package:talkam/features/group/data/models/create_group_payload.dart';
import 'package:talkam/features/group/presentation/blocs/create_group_cubit/create_group_cubit.dart';
import 'package:talkam/features/group/presentation/screens/create_group/preview_group_screen.dart';
import 'package:talkam/features/group/presentation/tabs/group_rules_tab.dart';
import 'package:talkam/features/group/presentation/widgets/add_rule_sheet.dart';
import 'package:talkam/gen/assets.gen.dart';

class AddGroupRulesScreen extends StatefulWidget {
  const AddGroupRulesScreen({super.key});

  // final

  @override
  State<AddGroupRulesScreen> createState() => _AddGroupRulesScreenState();
}

class _AddGroupRulesScreenState extends State<AddGroupRulesScreen> {
  static const _kRulesSummaryMaxLength = 100;

  final rulesSummaryController = TextEditingController();
  List<GuidelinePayload> guidlines = [];
  bool _rulesSummaryAtLimit = false;

  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    // Carry over anything already saved on the payload — e.g. rules
    // added on an earlier pass through this screen, or a resumed draft.
    final payload = injector.get<CreateGroupCubit>().groupPayload;
    guidlines = List.of(payload.guidelines);
    rulesSummaryController.text = payload.rulesSummary;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Pallets.white,
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Divider(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
            child: Row(
              children: [
                TextButton(
                    style: TextButton.styleFrom(
                        foregroundColor: context.colorScheme.onSurface,
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        shape: const StadiumBorder(
                            side: BorderSide(color: Pallets.grey75))),
                    onPressed: () {
                      context.pop();
                    },
                    child: Row(
                      children: [
                        const Icon(
                          Icons.arrow_back_ios_new_rounded,
                          size: 16,
                        ),
                        4.horizontalSpace,
                        const TextView(text: "Back")
                      ],
                    )),
                const Spacer(),
                TextButton(
                    style: TextButton.styleFrom(
                        backgroundColor: Pallets.primary,
                        shape: const StadiumBorder(),
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        foregroundColor: Pallets.white),
                    onPressed: () {
                      if (formKey.currentState?.validate() ?? false) {
                        if (guidlines.length < 2) {
                          CustomDialogs.error(
                              "You should add at least 2 rules");
                        } else {


                          updatePayload();
                          context.pushNamed(PageUrl.previewGroupScreen,
                              extra: PreviewGroupScreenParam(injector
                                  .get<CreateGroupCubit>()
                                  .groupPayload, false
                              ));
                        }
                      }
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
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Form(
            key: formKey,
            child: SingleChildScrollView(

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const TextView(
                    text: "Group Rules",
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                  17.verticalSpace,
                  const TextView(
                      text:
                          "Your group can have up to 8 different rules. Make your rules clear for healthy participation of all members"),
                  10.verticalSpace,
                  if (guidlines.length < 2)
                    TextView(
                      text:
                          "You should add at least 2 rules (${guidlines.length}/2 added)",
                      color: Colors.orange,
                    ),
                  28.verticalSpace,
                  OutlinedFormField(
                      maxLine: 10,
                      radius: 8,
                      minLine: 4,
                      filled: true,
                      maxLength: _kRulesSummaryMaxLength,
                      isError: _rulesSummaryAtLimit,

                      // padding: const EdgeInsets.symmetric(vertical: 16,horizontal: 16),
                      placeHolder: "Rules summary",
                      validator:
                          RequiredValidator(errorText: "Field is required").call,
                      controller: rulesSummaryController,
                      onChange: (d) {
                        _checkRulesSummaryLimit();
                        updatePayload();
                        setState(() {});
                      },
                      showRequiredAsterics: false,
                      hint: "About the rules for this group"),
                  25.verticalSpace,
                  ...List.generate(
                    guidlines.length,
                    (index) => Padding(
                      padding: const EdgeInsets.only(bottom: 20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _RuleItem(
                            index: index + 1,
                            rule: guidlines[index],
                            onDelete: () {
                              guidlines.remove(guidlines[index]);
                              updatePayload();
                              setState(() {});
                            },
                          ),
                          16.verticalSpace,
                          Divider(color: Pallets.grey90),
                        ],
                      ),
                    ),
                  ),
                  TextButton(
                      style: TextButton.styleFrom(
                          foregroundColor: context.colorScheme.onSurface,
                          shape: const StadiumBorder(
                              side: BorderSide(color: Pallets.grey75))),
                      onPressed: () {
                        addRule(context);
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.add),
                          4.horizontalSpace,
                          const TextView(text: "Add Rule")
                        ],
                      ))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void addRule(BuildContext context) async {
    GuidelinePayload? rule =
        await CustomDialogs.showBottomSheet(context, const AddRuleSheet());
    if (rule != null) {
      guidlines.add(rule);
      updatePayload();
      setState(() {});
    }
  }

  void updatePayload() {
    injector.get<CreateGroupCubit>().updateGroupPayload(
        guidelines: guidlines, rulesSummary: rulesSummaryController.text);
  }

  void _checkRulesSummaryLimit() {
    final atLimit =
        rulesSummaryController.text.characters.length >= _kRulesSummaryMaxLength;
    if (atLimit && !_rulesSummaryAtLimit) {
      CustomDialogs.showToast(
          "You have reached the maximum character limit of $_kRulesSummaryMaxLength characters");
    }
    _rulesSummaryAtLimit = atLimit;
  }
}

class _RuleItem extends StatelessWidget {
  const _RuleItem(
      {super.key,
      required this.index,
      required this.rule,
      required this.onDelete});

  final GuidelinePayload rule;
  final int index;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircularBorder(padding: 4, child: TextView(text: index.toString())),
        12.horizontalSpace,
        Expanded(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextView(
                  text: rule.title,
                  fontWeight: FontWeight.w700,
                ),
                InkWell(
                    onTap: () {
                      onDelete();
                    },
                    child: ImageWidget(imageUrl: Assets.images.svgs.icDelete))
              ],
            ),
            4.verticalSpace,
            TextView(
              text: rule.description,
            )
          ],
        ))
      ],
    );
  }
}
