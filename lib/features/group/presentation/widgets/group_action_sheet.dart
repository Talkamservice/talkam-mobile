import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:talkam/common/widgets/block_reason_sheet.dart';
import 'package:talkam/common/widgets/custom_dialogs.dart';
import 'package:talkam/common/widgets/image_widget.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/constants/package_exports.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/core/utils/extensions/context_extension.dart';
import 'package:talkam/features/ads/presentation/widgets/view_analytics_bottomsheet.dart';
import 'package:talkam/features/group/presentation/blocs/groups_cubit/groups_cubit.dart';
import 'package:talkam/features/group/presentation/blocs/groups_cubit/groups_cubit.dart';
import 'package:talkam/features/post/presentation/widgets/confirm_report_dialog.dart';
import 'package:talkam/features/search/data/models/get_group_response.dart';
import 'package:talkam/gen/assets.gen.dart';
import 'package:talkam/common/widgets/app_action_sheet.dart';

class GroupActionSheet extends StatefulWidget {
  const GroupActionSheet({
    super.key,
    required this.group,
    this.isPrivate = false,
  });

  final TalkamGroup group;
  final bool isPrivate;

  @override
  State<GroupActionSheet> createState() => _GroupActionSheetState();
}

class _GroupActionSheetState extends State<GroupActionSheet> {
  final bloc = GroupsCubit(injector.get());

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GroupsCubit, GroupsState>(
      bloc: bloc,
      listener: (context, state) {
        state.maybeWhen(
          orElse: () => null,
          reportGroupFailureState: (error) {
            context.pop();
            CustomDialogs.error(error);
          },
          reportGroupLoading: () {
            CustomDialogs.showLoading(context);
          },
          reportGroupSuccess: (response) {
            injector.get<GroupsCubit>().refreshGroups();
            context.pop();
            context.pop();
            context.pop();
            CustomDialogs.success("Group Reported");
          },
        );
      },
      builder: (context, state) {
        return AppActionSheet(
          actions: [
            AppActionItem(
              title: "Follow Group",
              onTap: () {
                context.pop();
                CustomDialogs.showToast("Coming soon");
              },
            ),
            AppActionItem(
              title: "Share ${widget.isPrivate || !widget.group.isPublic ? 'Private' : 'Public'} Group",
              onTap: () {
                context.pop();
                CustomDialogs.showToast("Coming soon");
              },
            ),
            if (!(widget.group.isReported ?? false))
              AppActionItem(
                title: "Report ${widget.isPrivate || !widget.group.isPublic ? 'Private' : 'Public'} Group",
                onTap: () async {
                  var reason = await CustomDialogs.showCustomDialog(BlockReasonSheet(), context);
                  if (reason != null) {
                    var report = await CustomDialogs.showCustomDialog(
                        ConfirmReportDialog(
                          reason: reason!,
                        ),
                        context);

                    if (report) {
                      bloc.reportGroup(groupId: widget.group.id.toString(), reason: reason);
                    }
                  }
                },
              ),
            if (groupIsFromLoggedInUser && widget.group.isPromoted)
              AppActionItem(
                title: "View analytics",
                onTap: () async {
                  context.pop();
                  await CustomDialogs.showBottomSheet(
                    context,
                    ViewAnalyticsBottomSheet(
                      isPost: false,
                      postId: widget.group.id.toString(),
                    ),
                  );
                },
              ),
            AppActionItem(
              title: "Leave group",
              textColor: Colors.red,
              onTap: () {
                context.pop();
                CustomDialogs.showToast("Coming soon");
              },
            ),
          ],
        );
      },
    );
  }

  bool get groupIsFromLoggedInUser => widget.group.isOwner;
}
