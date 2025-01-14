import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:talkam/common/widgets/custom_dialogs.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/core/theme/pallets.dart';
import 'package:talkam/core/utils/guest_user_helper.dart';
import 'package:talkam/features/group/presentation/blocs/group_members_cubit/group_members_cubit.dart';
import 'package:talkam/features/profile/presentation/bloc/profile_bloc/profile_bloc.dart';
import 'package:talkam/features/search/data/models/get_group_response.dart';

class JoinGroupButton extends StatefulWidget {
  const JoinGroupButton({
    super.key,
    required this.group,
    required this.onStateChanged,
    this.textSize,
    this.showIcon = true,
  });

  final VoidCallback onStateChanged;

  final TalkamGroup group;
  final double? textSize;
  final bool? showIcon;

  @override
  State<JoinGroupButton> createState() => _JoinGroupButtonState();
}

class _JoinGroupButtonState extends State<JoinGroupButton> {
  final bloc = GroupMembersCubit(injector.get());

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GroupMembersCubit, GroupMembersState>(
      bloc: bloc,
      listener: listenToGroupStates,
      builder: (context, state) {
        if (widget.group.isSuspended ?? false) {
          // if (true) {
          return TextButton(
              style: TextButton.styleFrom(
                  padding: const EdgeInsets.all(8),
                  fixedSize: const Size.fromHeight(5),
                  backgroundColor: Colors.transparent,
                  foregroundColor: Pallets.red,
                  shape: const StadiumBorder(side: BorderSide(color: Pallets.red))),
              onPressed: () {
                CustomDialogs.error("You have been suspended from this group");
              },
              child: Row(
                children: [
                  const TextView(
                    text: "Suspended",
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                  ),
                  5.horizontalSpace,
                  const Icon(
                    Icons.info_outline_rounded,
                    size: 16,
                  ),
                ],
              ));
        }
        return TextButton(
            style: TextButton.styleFrom(
                padding: const EdgeInsets.all(8),
                fixedSize: const Size.fromHeight(5),
                backgroundColor: Pallets.primary,
                foregroundColor: Pallets.white,
                shape: const StadiumBorder()),
            onPressed: () {
              GuestUserHelper.handleGuestUserAction(
                action: () {
                  handleJoinGroupAction();
                },
              );
            },
            child: Builder(builder: (context) {
              return state.maybeWhen(
                  orElse: () => Row(
                        children: [
                          if (showIcon)
                            const Icon(
                              Icons.add,
                              size: 16,
                              color: Pallets.white,
                            ),
                          if (showIcon) 5.horizontalSpace,
                          TextView(
                            text: tittleText,
                            fontSize: widget.textSize,
                          ),
                        ],
                      ),
                  addGroupMemberLoading: () => const _Loader(),
                  deleteMemberLoading: () => const _Loader(),
                  sendRequestLoading: () => const _Loader(),
                  cancelRequestLoading: () => const _Loader());
              // CustomDialogs.success("");
            }));
      },
    );
  }

  bool get showIcon {
    return !(widget.group.isFollowing??false) && !(widget.group.hasRequested??false) &&( widget.showIcon??false);
  }

  void listenToGroupStates(context, GroupMembersState state) {
    state.maybeWhen(
      orElse: () => null,
      addGroupMemberSuccess: (response) {
        widget.group.isFollowing = !widget.group.isFollowing!;
        widget.onStateChanged();
      },
      addGroupMemberFailure: (error) {
        CustomDialogs.error(error);
        widget.onStateChanged();
      },
      deleteMemberSuccess: (response) {
        widget.group.isFollowing = false;
        widget.group.hasRequested = false;
        widget.onStateChanged();

      },
      deleteMemberFailure: (error) {
        CustomDialogs.error(error);
      },
      cancelRequestSuccess: (response) {
        widget.group.hasRequested = false;
        widget.group.isFollowing = false;

        widget.onStateChanged();
      },
      cancelRequestFailure: (error) {
        CustomDialogs.error(error);
        widget.onStateChanged();
      },
      sendRequestSyccess: (response) {
        widget.group.hasRequested = !widget.group.hasRequested!;
        widget.onStateChanged();
      },
      sendRequestFailure: (error) {
        CustomDialogs.error(error);
        widget.onStateChanged();
      },
    );
  }

  void handleJoinGroupAction() {
    if (canJoinGroup) {
      logger.w("Joining ");

      bloc.addGroupMember(groupId: widget.group.id.toString(), userId: injector.get<ProfileBloc>().appUser!.id.toString());
    } else if (shouldSendJoinRequest) {
      logger.w("Sending request");

      bloc.sendGroupRequest(
        widget.group.id.toString(),
      );
    } else if (widget.group.hasRequested!) {
      logger.w("Cancelling request");
      bloc.unfollowGroup(injector.get<ProfileBloc>().appUser!.id.toString(), widget.group.id.toString());
    } else {
      bloc.unfollowGroup(injector.get<ProfileBloc>().appUser!.id.toString(), widget.group.id.toString());
    }
  }

  bool get shouldSendJoinRequest =>
      !(widget.group.isFollowing ?? false) && !(widget.group.isPublic ?? false) && !(widget.group.hasRequested ?? false);

  bool get canJoinGroup =>
      !(widget.group.isFollowing ?? false) && (widget.group.isPublic ?? false) && !(widget.group.hasRequested ?? false);

  String get tittleText =>
      (widget.group.isFollowing ?? false)
          ? "Unfollow"
          : (widget.group.hasRequested ?? false)
          ? "Cancel Request"
          : "Join";

}

class _Loader extends StatelessWidget {
  const _Loader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 20,
      width: 20,
      child: CircularProgressIndicator(
        color: Pallets.white,
      ),
    );
  }
}
