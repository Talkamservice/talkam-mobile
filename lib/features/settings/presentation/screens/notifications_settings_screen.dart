import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talkam/common/widgets/custom_appbar.dart';
import 'package:talkam/common/widgets/custom_dialogs.dart';
import 'package:talkam/common/widgets/error_widget.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/constants/package_exports.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/features/settings/presentation/blocs/settings/settings_bloc.dart';
import 'package:talkam/features/settings/presentation/blocs/settings/settings_bloc.dart';
import 'package:talkam/features/settings/presentation/widgets/comments_preference_group.dart';
import 'package:talkam/features/settings/presentation/widgets/moderation_activities_group.dart';
import 'package:talkam/features/settings/presentation/widgets/more_activities_group.dart';
import 'package:talkam/features/settings/presentation/widgets/notifications_preferences_group.dart';

class NotificationsSettingsScreen extends StatefulWidget {
  const NotificationsSettingsScreen({super.key});

  @override
  State<NotificationsSettingsScreen> createState() =>
      _NotificationsSettingsScreenState();
}

class _NotificationsSettingsScreenState
    extends State<NotificationsSettingsScreen> {
  final bloc = SettingsBloc(injector.get(), injector.get());

  @override
  void initState() {
    bloc.add(const SettingsEvent.fetchNotificationPreferences());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        padding: EdgeInsets.all(0.0),
        tittleText: "Settings",
        centerTile: false,
        showDivider: true,
      ),
      body: BlocProvider(
        create: (context) => bloc,
        child: BlocConsumer<SettingsBloc, SettingsState>(
          bloc: bloc,
          listener: (context, state) {
            state.maybeWhen(
              orElse: () => null,

              saveNotificationPreferencesSuccess: (response) {
                bloc.add(const SettingsEvent.fetchNotificationPreferences(
                    refresh: false));

                // CustomDialogs.
              },
              saveNotificationPreferencesLoading: () {
                // CustomDialogs.showLoading(context);
              },
              saveNotificationPreferencesFailure: (error) {
                CustomDialogs.error(error);
                bloc.add(const SettingsEvent.fetchNotificationPreferences());
              },
              fetchNotificationPreferencesSuccess: (response) {



              },
            );
          },
          buildWhen: _buildWhen,
          builder: (context, state) {

            return state.maybeWhen(
              orElse: () => 0.verticalSpace,
              fetchNotificationPreferencesSuccess: (response) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const TextView(
                            text:
                                "Get notified to find out what’s going on when you’re not online. You can turn them off anytime."),
                        20.verticalSpace,
                        NotificationsPreferencesGroup(
                          data: response,
                        ),
                        const _Divider(),
                        CommentsPreferencesGroup(
                          data: response,
                        ),
                        const _Divider(),
                        ModerationActivitiesGroup(
                          data: response,
                        ),
                        const _Divider(),
                        MoreActivitiesPreferenceGroup(
                          data: response,
                        ),
                        80.verticalSpace
                      ],
                    ),
                  ),
                );
              },
              fetchNotificationPreferencesLoading: () {

                return Center(
                  child: CustomDialogs.getLoading(size: 50),
                );
                // CustomDialogs.showLoading(context);
              },
              fetchNotificationPreferencesFailure: (error) {
                return AppErrorWidget(
                  onTap: () {},
                );
              },
            );
          },
        ),
      ),
    );
  }

  bool _buildWhen(SettingsState previous, SettingsState current) {
    return current.maybeWhen(
      orElse: () => false,
      fetchNotificationPreferencesLoading: () => true,
      fetchNotificationPreferencesSuccess: (response) => true,
      fetchNotificationPreferencesFailure: (error) => true,
    );
  }
}

class _Divider extends StatelessWidget {
  const _Divider({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        18.verticalSpace,
        const Divider(),
        18.verticalSpace,
      ],
    );
  }
}
