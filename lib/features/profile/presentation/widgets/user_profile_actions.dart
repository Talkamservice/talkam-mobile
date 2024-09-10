import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:talkam/common/widgets/block_reason_sheet.dart';
import 'package:talkam/common/widgets/custom_dialogs.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/_core.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/core/theme/pallets.dart';
import 'package:talkam/features/authentication/data/models/auth_response.dart';
import 'package:talkam/features/messaging/dormain/mixins/refresh_conversations_mixin.dart';
import 'package:talkam/features/messaging/presentation/blocs/conversations/conversations_cubit.dart';
import 'package:talkam/features/post/dormain/mixins/refresh_posts_mixin.dart';
import 'package:talkam/features/profile/presentation/bloc/profile_bloc/profile_bloc.dart';

class UserProfileActions extends StatefulWidget {
  const UserProfileActions({super.key, required this.user});

  final TalkamUser user;

  @override
  State<UserProfileActions> createState() => _UserProfileActionsState();
}

class _UserProfileActionsState extends State<UserProfileActions> with RefreshPostsMixin, RefreshConversationsMixin {
  final profileBloc = ProfileBloc(injector.get());
  final conversationsBloc = ConversationsCubit(injector.get());

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<ProfileBloc, ProfileState>(
          bloc: profileBloc,
          listener: (context, state) {
            if (state is BlockUserLoadingState) {
              CustomDialogs.showLoading(context);
            }

            if (state is BlockUserFailureState) {
              context.pop();
              CustomDialogs.error(state.error);
            }
            if (state is BlockUserSuccessState) {
              refreshPost(reload: false);
              context.pop();
              context.pop(true);

              if (state.response.data.isBlocked) {
                CustomDialogs.success("User Blocked");
              } else {
                CustomDialogs.success("User UnBlocked");
              }
            }
          },
        )
      ],
      child: Container(
        decoration: const BoxDecoration(
          color: Color(0xffFFFFFFF),
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildOptionRow(
              icon: Icons.copy_rounded,
              text: 'Copy profile link',
              onTap: () {
                Helpers.copy("https://web.talkam.prodevs.io/userprofile/${widget.user.id}");
                context.pop();
              },
            ),
            const SizedBox(
              width: double.infinity,
              child: Divider(
                thickness: 1,
              ),
            ),
            _buildOptionRow(
              icon: Icons.block_outlined,
              text: widget.user.isBlocked ? 'UnBlock ${widget.user.username}' : 'Block ${widget.user.username}',
              onTap: () {
                blockUser(context);
              },
            ),
            const SizedBox(
              width: double.infinity,
              child: Divider(
                thickness: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void blockUser(BuildContext context) async {
    if(!widget.user.isBlocked){
      CustomDialogs.showConfirmDialog(
        context,
        confirmButtonBgColor: Pallets.red,
        message: "Are you sure you want to block ${widget.user.username}",
        onCancel: () {
          context.pop();
        },
        onYes: () {
          context.pop();

          profileBloc.add(BlockUerEvent(widget.user.id.toString()));

        },
      );
    }else{
      CustomDialogs.showConfirmDialog(
        context,
        confirmButtonBgColor: Pallets.primary,
        message: "Are you sure you want to unblock ${widget.user.username}",
        onCancel: () {
          context.pop();
        },
        onYes: () {
          context.pop();

          profileBloc.add(BlockUerEvent(widget.user.id.toString()));

        },
      );
    }



  }
}

Widget _buildOptionRow({required IconData icon, required String text, required VoidCallback onTap}) {
  return InkWell(
    onTap: onTap,
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          Icon(
            icon,
            size: 24,
            color: const Color(0xff212121),
          ),
          const SizedBox(width: 16),
          TextView(
            color: const Color(0xff212121),
            fontSize: 16,
            fontWeight: FontWeight.w500,
            text: text,
          ),
        ],
      ),
    ),
  );
}
