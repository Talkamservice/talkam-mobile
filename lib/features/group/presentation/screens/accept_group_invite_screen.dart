import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talkam/common/widgets/custom_appbar.dart';
import 'package:talkam/common/widgets/custom_button.dart';
import 'package:talkam/common/widgets/custom_dialogs.dart';
import 'package:talkam/common/widgets/image_widget.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/constants/package_exports.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/core/theme/pallets.dart';
import 'package:talkam/features/group/presentation/blocs/group_invite_cubit/group_invite_cubit.dart';
import 'package:talkam/gen/assets.gen.dart';

/// Reached with the invite's `uuid` (from `GroupsRepository.acceptGroupInvite`
/// — identifies the invite itself, not the group). Currently only reachable
/// by manually pushing this route: no deep-link/notification case routes
/// here yet — see the TODO in `deep_link_naigator.dart`. This screen, its
/// route, and the bloc call are already wired end to end so wiring up the
/// real trigger later is a one-line addition, not a new feature.
class AcceptGroupInviteScreen extends StatefulWidget {
  const AcceptGroupInviteScreen({super.key, required this.uuid});

  final String uuid;

  @override
  State<AcceptGroupInviteScreen> createState() =>
      _AcceptGroupInviteScreenState();
}

class _AcceptGroupInviteScreenState extends State<AcceptGroupInviteScreen> {
  final _cubit = GroupInviteCubit(injector.get());

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GroupInviteCubit, GroupInviteState>(
      bloc: _cubit,
      listener: (context, state) {
        if (state is AcceptGroupInviteLoading) {
          CustomDialogs.showLoading(context);
        }
        if (state is AcceptGroupInviteFailure) {
          context.pop(); // pop loading
          CustomDialogs.error(state.error);
        }
        if (state is AcceptGroupInviteSuccess) {
          context.pop(); // pop loading
          CustomDialogs.showToast("You've joined the group");
          context.pop(); // pop this screen
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: const CustomAppBar(
            bgColor: Colors.transparent,
            elevation: 0,
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ImageWidget(
                  imageUrl: Assets.images.svgV2.userAdd,
                  size: 56,
                  color: Pallets.blueBubbleColor,
                ),
                20.verticalSpace,
                const TextView(
                  text: "You've been invited",
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: Pallets.boldBlackV2,
                  align: TextAlign.center,
                ),
                8.verticalSpace,
                const TextView(
                  text: "Accept this invite to join the group.",
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Pallets.grey400,
                  align: TextAlign.center,
                ),
                28.verticalSpace,
                CustomButton(
                  onPressed: () => _cubit.acceptGroupInvite(widget.uuid),
                  bgColor: Pallets.blueBubbleColor,
                  borderRadius: BorderRadius.circular(14.r),
                  child: const TextView(
                    text: "Accept Invite",
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
