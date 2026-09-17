import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:talkam/common/widgets/custom_dialogs.dart';
import 'package:talkam/common/widgets/image_widget.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/constants/dialog_texts.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/core/theme/pallets.dart';
import 'package:talkam/core/utils/extensions/context_extension.dart';
import 'package:talkam/features/group/presentation/blocs/groups_cubit/groups_cubit.dart';
import 'package:talkam/features/group/presentation/screens/group_details_screen.dart';
import 'package:talkam/features/group/presentation/tabs/group_rules_tab.dart';
import 'package:talkam/features/group/presentation/widgets/add_rule_sheet.dart';
import 'package:talkam/features/search/data/models/get_group_response.dart';
import 'package:talkam/gen/assets.gen.dart';

/// The real "Rules" tab shown on a group's info screen — fetches the
/// group's actual guidelines (rather than trusting whatever the group's
/// own detail-fetch happened to embed) so a stale/incomplete embedded
/// list doesn't leave this tab showing outdated rules.
class GroupsRulesTab extends StatefulWidget {
  const GroupsRulesTab({super.key, required this.data});

  final TalkamGroup data;

  @override
  State<GroupsRulesTab> createState() => _GroupsRulesTabState();
}

class _GroupsRulesTabState extends State<GroupsRulesTab> {
  final bloc = GroupsCubit(injector.get());
  bool _loadingRules = true;

  @override
  void initState() {
    super.initState();
    bloc.getGroupRules(groupId: widget.data.id.toString());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GroupsCubit, GroupsState>(
      bloc: bloc,
      listener: (context, state) {
        state.maybeWhen(
          orElse: () => null,
          addGroupRuleFailureState: (error) {
            context.pop();
            CustomDialogs.error(error);
          },
          addGroupRuleLoading: () {
            CustomDialogs.showLoading(context);
          },
          addGroupRuleSuccess: (response) {
            context.pop();
            widget.data.guidelines?.add(response);
            setState(() {});
          },
          getGroupRuleSuccess: (guidelines) {
            _loadingRules = false;
            widget.data.guidelines = guidelines;
            setState(() {});
          },
          getGroupRuleFailureState: (error) {
            // Keep whatever guidelines came bundled with the group itself
            // rather than blanking the tab on a failed refetch.
            _loadingRules = false;
            setState(() {});
          },
        );
      },
      builder: (context, state) {
        if (_loadingRules) {
          return const Padding(
            padding: EdgeInsets.only(top: 40),
            child: Center(child: CircularProgressIndicator()),
          );
        }
        final guidelines = widget.data.guidelines ?? [];
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircularBorder(
                      child: ImageWidget(
                    imageUrl: Assets.images.svgs.rules,
                    color: context.colorScheme.onSurface,
                  )),
                  8.horizontalSpace,
                  const Expanded(
                    child: TextView(
                      text: "Group Rules",
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  if (widget.data.isAdmin)
                    TextButton(
                        style: outlinedButtonStyle(),
                        onPressed: () async {
                          var guidline = await CustomDialogs.showBottomSheet(
                              context, const AddRuleSheet());
                          if (guidline != null) {
                            bloc.addGroupRule(
                                groupId: widget.data.id.toString(),
                                rule: guidline);
                          }
                        },
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ImageWidget(
                                imageUrl: Assets.images.svgs.icPersonEdit),
                            10.horizontalSpace,
                            TextView(
                              text: "Add Rule",
                              fontSize: 14,
                              color: context.colorScheme.onSurface,
                              fontWeight: FontWeight.w600,
                            ),
                          ],
                        )),
                ],
              ),
              14.verticalSpace,
              const TextView(
                text: groupRuleIntro,
              ),
              16.verticalSpace,
              TextView(text: widget.data.description.toString()),
              18.verticalSpace,
              if (guidelines.isEmpty)
                const TextView(
                  text: "No rules have been added for this group yet.",
                  color: Pallets.grey60,
                ),
              ...List.generate(
                  guidelines.length,
                  (index) => BlocListener<GroupsCubit, GroupsState>(
                        bloc: bloc,
                        listener: (context, state) {
                          state.maybeWhen(
                            orElse: () => null,
                            deleteGroupRuleLoading: () {
                              CustomDialogs.showLoading(context);
                            },
                            deleteGroupRuleFailureState: (error) {
                              context.pop();
                              CustomDialogs.error(error);
                            },
                            deleteGroupRuleSuccess: (response) {
                              context.pop();
                              widget.data.guidelines
                                  ?.remove(guidelines[index]);
                              setState(() {});
                            },
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 16.0),
                          child: GroupRuleItem(
                            index: index + 1,
                            guidline: guidelines[index],
                            onDeleteClicked: () {
                              bloc.deleteGroupRule(
                                  guidelineId: guidelines[index].id.toString());
                            },
                            canDelete: widget.data.userRole?.toLowerCase() ==
                                    "admin" ||
                                widget.data.userRole?.toLowerCase() == "owner",
                          ),
                        ),
                      )),
            ],
          ),
        );
      },
    );
  }
}
