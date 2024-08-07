import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talkam/common/widgets/custom_appbar.dart';
import 'package:talkam/common/widgets/custom_dialogs.dart';
import 'package:talkam/common/widgets/error_widget.dart';
import 'package:talkam/common/widgets/image_widget.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/_core.dart';
import 'package:talkam/core/constants/package_exports.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/core/theme/pallets.dart';
import 'package:talkam/features/settings/data/models/blocked_users_response.dart';
import 'package:talkam/features/settings/presentation/blocs/settings/settings_bloc.dart';
import 'package:talkam/gen/assets.gen.dart';

class BlockedUsersScreen extends StatefulWidget {
  const BlockedUsersScreen({super.key});

  @override
  State<BlockedUsersScreen> createState() => _BlockedUsersScreenState();
}

class _BlockedUsersScreenState extends State<BlockedUsersScreen> {
  @override
  void initState() {
    super.initState();
    settingsBloc.add(const SettingsEvent.fetchBlockedUsers());
  }

  final settingsBloc = SettingsBloc(injector.get(), injector.get());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        tittleText: "Blocked Users",
        elevation: 0,
        centerTile: false,
      ),
      body: BlocProvider(
        create: (context) => settingsBloc,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              Expanded(
                  child: BlocConsumer<SettingsBloc, SettingsState>(
                listener: (context, state) {},
                buildWhen: _buildWhen,
                builder: (context, state) {
                  return state.maybeWhen(
                    orElse: () => 0.verticalSpace,
                    fetchBlockedUsersLoading: () =>
                        CustomDialogs.getLoading(size: 40),
                    fetchBlockedUsersFailure: (error) => AppPromptWidget(
                      onTap: () {
                        settingsBloc
                            .add(const SettingsEvent.fetchBlockedUsers());
                      },
                    ),
                    fetchBlockedUsersSuccess: (response) {
                      if (response.data.isEmpty) {
                        return const Center(
                          child: TextView(
                            text: "No blocked users here",
                            fontSize: 18,
                          ),
                        );
                      }

                      return ListView.builder(
                        itemCount: response.data.length,
                        itemBuilder: (context, index) => Padding(
                          padding: const EdgeInsets.only(top: 4.0),
                          child: BlockedUserItem(
                            blockedUser: response.data[index],
                          ),
                        ),
                      );
                    },
                  );
                },
              ))
            ],
          ),
        ),
      ),
    );
  }

  bool _buildWhen(SettingsState previous, SettingsState current) {
    return current.maybeWhen(
      orElse: () => false,
      fetchBlockedUsersSuccess: (response) => true,
      fetchBlockedUsersLoading: () => true,
      fetchBlockedUsersFailure: (error) => true,
    );
  }
}

class BlockedUserItem extends StatelessWidget {
  const BlockedUserItem({super.key, required this.blockedUser});

  final TalkamBlockedUser blockedUser;

  @override
  Widget build(BuildContext context) {
    return BlocListener<SettingsBloc, SettingsState>(
      listener: (context, state) {
        state.maybeWhen(
            orElse: () => null,
            blockUserLoading: () => CustomDialogs.showLoading(context),
            blockUserFailure: (error) {
              context.pop();
              CustomDialogs.error(error);
            },
            blockUserSuccess: (response) {
              context
                  .read<SettingsBloc>()
                  .add(const SettingsEvent.fetchBlockedUsers());
              context.pop();
              // CustomDialogs.success('User blocked');
            });
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ImageWidget(imageUrl: Assets.images.svgs.blockedUser),
          10.horizontalSpace,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextView(
                  text: blockedUser.blockedUser.username ??
                      blockedUser.blockedUser.email,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
                TextView(
                  text:
                      "Member since ${TimeUtil.monthYeay(blockedUser.createdAt)}",
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ],
            ),
          ),
          TextButton(
              style: TextButton.styleFrom(
                  shape: const StadiumBorder(
                      side: BorderSide(color: Pallets.primary))),
              onPressed: () {
                context.read<SettingsBloc>().add(SettingsEvent.blockUser(
                    blockedUser.blockedUser.id.toString()));
              },
              child: const TextView(text: "Unblock"))
        ],
      ),
    );
  }
}
