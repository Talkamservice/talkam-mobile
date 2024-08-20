import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:talkam/common/widgets/custom_dialogs.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/core/theme/pallets.dart';
import 'package:talkam/features/group/presentation/blocs/groups_cubit/groups_cubit.dart';
import 'package:talkam/features/profile/presentation/bloc/profile_bloc/profile_bloc.dart';
import 'package:talkam/features/search/data/models/get_group_response.dart';

class JoinGroupButton extends StatefulWidget {
  const JoinGroupButton({
    super.key,
    required this.group,
  });

  final TalkamGroup group;

  @override
  State<JoinGroupButton> createState() => _JoinGroupButtonState();
}

class _JoinGroupButtonState extends State<JoinGroupButton> {
  final bloc = GroupsCubit(injector.get());

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GroupsCubit, GroupsState>(
      bloc: bloc,
      listener: (context, state) {
        state.maybeWhen(
          orElse: () => null,
          joinGroupSuccess: (response) {
            widget.group.isFollowing = !widget.group.isFollowing!;
          },
          joinGroupFailureState: (error) {
            CustomDialogs.error(error);
          },
        );
      },
      builder: (context, state) {
        return TextButton(
            style: TextButton.styleFrom(
                backgroundColor:
                    widget.group.isFollowing! ? Pallets.red : Pallets.primary,
                foregroundColor: Pallets.white,
                shape: const StadiumBorder()),
            onPressed: () {
              // var userInterests =
              //     injector.get<ProfileBloc>().appUser!.interests;
              bloc.joinGroup(
                  groupId: widget.group.id.toString(),
                  userId: injector.get<ProfileBloc>().appUser!.id.toString());
            },
            child: Builder(builder: (context) {
              return state.maybeWhen(
                orElse: () => Row(
                  children: [
                    if (!widget.group.isFollowing!)
                      const Icon(
                        Icons.add,
                        color: Pallets.white,
                      ),

                    if (!widget.group.isFollowing!) 5.horizontalSpace,
                    TextView(
                        text: widget.group.isFollowing! ? "Leave" : "Join"),
                  ],
                ),
                joinGroupLoading: () => SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(
                    color: Pallets.white,
                  ),
                ),
              );

              // CustomDialogs.success("");
            }));
      },
    );
  }
}
