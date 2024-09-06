import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:talkam/common/widgets/custom_dialogs.dart';
import 'package:talkam/common/widgets/image_widget.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/constants/dialog_texts.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/core/services/data/session_manager.dart';
import 'package:talkam/core/theme/pallets.dart';
import 'package:talkam/core/utils/extensions/context_extension.dart';
import 'package:talkam/features/group/presentation/blocs/groups_cubit/groups_cubit.dart';
import 'package:talkam/features/group/presentation/screens/group_details_screen.dart';
import 'package:talkam/features/group/presentation/widgets/add_rule_sheet.dart';
import 'package:talkam/features/search/data/models/get_group_response.dart';
import 'package:talkam/gen/assets.gen.dart';

class GroupRulesTab extends StatefulWidget {
  GroupRulesTab({super.key, this.isPreview = false, required this.group});

  final bool? isPreview;
  TalkamGroup group;

  @override
  State<GroupRulesTab> createState() => _GroupRulesTabState();
}

class _GroupRulesTabState extends State<GroupRulesTab> {
  final bloc = GroupsCubit(injector.get());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colorScheme.surface,
      body: BlocConsumer<GroupsCubit, GroupsState>(
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

              widget.group.guidelines?.add(response);
              setState(() {});
            },
          );
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                10.verticalSpace,
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
                    // if (!widget.isPreview!)

                    if (widget.group.isAdmin)

                      TextButton(
                          style: outlinedButtonStyle(),
                          onPressed: () async {
                            var guidline = await CustomDialogs.showBottomSheet(
                                context, const AddRuleSheet());
                            if (guidline != null) {
                              bloc.addGroupRule(
                                  groupId: widget.group.id.toString(),
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
                                text: "Edit",
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
                TextView(text: widget.group.description.toString()),
                18.verticalSpace,
                ...List.generate(
                    widget.group.guidelines!.length,
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
                                widget.group.guidelines
                                    ?.remove(widget.group.guidelines![index]);
                                setState(() {});
                              },
                            );
                          },
                          child: GroupRuleItem(
                            index: index + 1,
                            guidline: widget.group.guidelines![index],
                            onDeleteClicked: () {
                              bloc.deleteGroupRule(
                                  guidelineId: widget
                                      .group.guidelines![index].id
                                      .toString());
                            },
                            canDelete: widget.group.userRole?.toLowerCase() ==
                                    "admin" ||
                                widget.group.userRole?.toLowerCase() == "owner",
                          ),
                        )),
              ],
            ),
          );
        },
      ),
    );
  }
}

class CircularBorder extends StatelessWidget {
  const CircularBorder({super.key, required this.child, this.padding = 8});

  final Widget child;
  final double? padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          border: Border.all(color: Pallets.grey75), shape: BoxShape.circle),
      child: child,
    );
  }
}

class GroupRuleItem extends StatelessWidget {
  const GroupRuleItem(
      {super.key,
      required this.index,
      required this.guidline,
      required this.onDeleteClicked,
      required this.canDelete});

  final GroupGuideline guidline;
  final int index;
  final VoidCallback onDeleteClicked;
  final bool canDelete;

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
            TextView(
              text: guidline.title.toString(),
              fontWeight: FontWeight.w700,
            ),
            4.verticalSpace,
            TextView(text: guidline.description.toString())
          ],
        )),
        if (canDelete)
          InkWell(
              onTap: onDeleteClicked,
              child: ImageWidget(imageUrl: Assets.images.svgs.icDelete))
      ],
    );
  }
}
