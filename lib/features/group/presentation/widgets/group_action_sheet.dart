import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:talkam/common/widgets/custom_dialogs.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/core/navigation/route_url.dart';
import 'package:talkam/core/services/network/url_config.dart';
import 'package:talkam/core/theme/pallets.dart';
import 'package:talkam/core/utils/extensions/context_extension.dart';
import 'package:talkam/core/utils/helper_utils.dart';
import 'package:talkam/features/group/presentation/blocs/group_members_cubit/group_members_cubit.dart';
import 'package:talkam/features/group/presentation/blocs/groups_cubit/groups_cubit.dart';
import 'package:talkam/features/search/data/models/get_group_response.dart';

import '../../../profile/presentation/bloc/profile_bloc/profile_bloc.dart';

class GroupActionSheet extends StatefulWidget {
  const GroupActionSheet({super.key, required this.group});

  final TalkamGroup group;

  @override
  State<GroupActionSheet> createState() => _GroupActionSheetState();
}

class _GroupActionSheetState extends State<GroupActionSheet> {
  final groupsCubit = GroupsCubit(injector.get());
  final groupMembersCubit = GroupMembersCubit(injector.get());

  @override
  Widget build(BuildContext context) {
    bool isPublic = widget.group.isPublic;
    bool isFollowing = widget.group.isFollowing ?? false;
    bool isOwner = widget.group.isOwner;
    String visibilityText = isPublic ? "Public" : "Private";

    return MultiBlocListener(
      listeners: [
        BlocListener<GroupsCubit, GroupsState>(
          bloc: groupsCubit,
          listener: (context, state) {
            state.maybeWhen(
              orElse: () => null,
              reportGroupLoading: () => CustomDialogs.showLoading(context),
              reportGroupSuccess: (msg) {
                context.pop(); // pop loading
                context.pop(); // pop action sheet
                CustomDialogs.showToast(msg.toString());
              },
              reportGroupFailureState: (error) {
                context.pop(); // pop loading
                CustomDialogs.error(error);
              },
              deleteGroupLoading: () => CustomDialogs.showLoading(context),
              deleteGroupSuccess: (res) {
                context.pop(); // pop loading
                context.pop(); // pop action sheet
                CustomDialogs.showToast("Group deleted successfully");
                context.goNamed(PageUrl.groups);
              },
              deleteGroupFailure: (error) {
                context.pop(); // pop loading
                CustomDialogs.error(error);
              },
            );
          },
        ),
        BlocListener<GroupMembersCubit, GroupMembersState>(
          bloc: groupMembersCubit,
          listener: (context, state) {
            state.maybeWhen(
              orElse: () => null,
              deleteMemberLoading: () => CustomDialogs.showLoading(context),
              deleteMemberSuccess: (res) {
                context.pop(); // pop loading
                context.pop(); // pop action sheet
                CustomDialogs.showToast("Left group successfully");
              },
              deleteMemberFailure: (error) {
                context.pop(); // pop loading
                CustomDialogs.error(error);
              },
            );
          },
        ),
      ],
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 24.h),
        decoration: BoxDecoration(
          color: context.theme.cardColor,
          borderRadius: BorderRadius.circular(24.r),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _GroupAction(
              title: "Share $visibilityText Group",
              onTap: () {
                context.pop();
                Helpers.share("${UrlConfig.webUrl}group/${widget.group.id}");
              },
            ),
            _GroupAction(
              title: "Report $visibilityText Group",
              onTap: () {
                CustomDialogs.showConfirmDialog(
                  context,
                  tittle: "Report Group",
                  message: "Are you sure you want to report this group?",
                  onYes: () {
                    groupsCubit.reportGroup(
                      groupId: widget.group.id.toString(),
                      reason: "Inappropriate content",
                    );
                  },
                );
              },
            ),
            if (isFollowing && !isOwner)
              _GroupAction(
                title: "Leave group",
                color: Pallets.red,
                onTap: () {
                  CustomDialogs.showConfirmDialog(
                    context,
                    tittle: "Leave Group",
                    message: "Are you sure you want to leave this group?",
                    onYes: () {
                      groupMembersCubit.unfollowGroup(
                        injector.get<ProfileBloc>().appUser?.id.toString() ?? "",
                        widget.group.id.toString(),
                      );
                    },
                  );
                },
              ),
            if (isOwner)
              _GroupAction(
                title: "Delete Group",
                color: Pallets.red,
                onTap: () {
                  CustomDialogs.showConfirmDialog(
                    context,
                    tittle: "Delete Group",
                    message: "Are you sure you want to permanently delete this group? This action cannot be undone.",
                    confirmButtonBgColor: Pallets.red,
                    onYes: () {
                      groupsCubit.deleteGroup(widget.group.id.toString());
                    },
                  );
                },
              ),
          ],
        ),
      ),
    );
  }
}

class _GroupAction extends StatelessWidget {
  const _GroupAction({required this.title, required this.onTap, this.color});

  final String title;
  final VoidCallback onTap;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 16.h),
        child: SizedBox(
          width: double.infinity,
          child: TextView(
            text: title,
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: color ?? context.colorScheme.onSurface,
          ),
        ),
      ),
    );
  }
}
