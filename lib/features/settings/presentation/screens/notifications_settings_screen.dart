import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talkam/common/widgets/custom_appbar.dart';
import 'package:talkam/common/widgets/custom_button.dart';
import 'package:talkam/common/widgets/custom_dialogs.dart';
import 'package:talkam/common/widgets/custom_switch.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/constants/package_exports.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/core/theme/pallets.dart';
import 'package:talkam/features/settings/data/models/notification_preferences.dart';
import 'package:talkam/features/settings/presentation/blocs/settings/settings_bloc.dart';

class NotificationsSettingsScreen extends StatefulWidget {
  const NotificationsSettingsScreen({super.key});

  @override
  State<NotificationsSettingsScreen> createState() =>
      _NotificationsSettingsScreenState();
}

class _NotificationsSettingsScreenState
    extends State<NotificationsSettingsScreen> {
  final bloc = SettingsBloc(injector.get(), injector.get());

  NotificationPreferences _saved = const NotificationPreferences();
  NotificationPreferences _draft = const NotificationPreferences();

  /// SMS has no server-side field in v2 — unknown keys are rejected, so this
  /// stays a local-only toggle and is never sent with the save request.
  bool _sms = true;

  bool get _hasChanges => _draft != _saved;

  void _update(NotificationPreferences next) => setState(() => _draft = next);

  @override
  void initState() {
    super.initState();
    bloc.add(const SettingsEvent.getNotificationPreferencesV2());
  }

  @override
  void dispose() {
    bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SettingsBloc, SettingsState>(
      bloc: bloc,
      listener: (context, state) {
        state.maybeWhen(
          orElse: () => null,
          getNotificationPreferencesV2Success: (prefs) => setState(() {
            _saved = prefs;
            _draft = prefs;
          }),
          getNotificationPreferencesV2Failure: (error) =>
              CustomDialogs.error(error),
          updateNotificationPreferencesV2Success: (prefs) => setState(() {
            _saved = prefs;
            _draft = prefs;
          }),
          updateNotificationPreferencesV2Failure: (error) =>
              CustomDialogs.error(error),
        );
      },
      builder: (context, state) {
        final loading = state.maybeWhen(
          orElse: () => false,
          getNotificationPreferencesV2Loading: () => true,
        );
        final saving = state.maybeWhen(
          orElse: () => false,
          updateNotificationPreferencesV2Loading: () => true,
        );

        return Scaffold(
          backgroundColor: Colors.white,
          appBar: const CustomAppBar(
            padding: EdgeInsets.all(0.0),
            tittleText: "Notification",
            centerTile: false,
          ),
          body: SafeArea(
            child: loading
                ? Center(child: CustomDialogs.getLoading(size: 50))
                : SingleChildScrollView(
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // ── SESSIONS ───────────────────────────────────────────────
                        const _SectionHeader(title: "SESSIONS"),
                        12.verticalSpace,
                        _NotificationCard(
                          title: "Session confirmation",
                          subtitle: "When a session is booked or cancelled",
                          value: _draft.sessionConfirmation,
                          onChanged: (v) =>
                              _update(_draft.copyWith(sessionConfirmation: v)),
                        ),
                        12.verticalSpace,
                        _NotificationCard(
                          title: "Session reminders",
                          subtitle: "Notified before session starts",
                          value: _draft.sessionReminders,
                          onChanged: (v) =>
                              _update(_draft.copyWith(sessionReminders: v)),
                        ),
                        12.verticalSpace,
                        _NotificationCard(
                          title: "Post-session feedback",
                          subtitle: "Request feedback post-session",
                          value: _draft.postSessionFeedback,
                          onChanged: (v) =>
                              _update(_draft.copyWith(postSessionFeedback: v)),
                        ),
                        12.verticalSpace,
                        _NotificationCard(
                          title: "Payment confirmations",
                          subtitle: "Receipt sent after payment",
                          value: _draft.paymentConfirmations,
                          onChanged: (v) =>
                              _update(_draft.copyWith(paymentConfirmations: v)),
                        ),

                        28.verticalSpace,

                        // ── COMMUNITY ──────────────────────────────────────────────
                        const _SectionHeader(title: "COMMUNITY"),
                        12.verticalSpace,
                        _NotificationCard(
                          title: "Replies to my posts",
                          subtitle: "When someone replies to your post",
                          value: _draft.repliesToPosts,
                          onChanged: (v) =>
                              _update(_draft.copyWith(repliesToPosts: v)),
                        ),
                        12.verticalSpace,
                        _NotificationCard(
                          title: "Promotions & updates",
                          subtitle: "News, offers, and product updates",
                          value: _draft.promotionsUpdates,
                          onChanged: (v) =>
                              _update(_draft.copyWith(promotionsUpdates: v)),
                        ),

                        28.verticalSpace,

                        // ── CHANNELS ───────────────────────────────────────────────
                        const _SectionHeader(title: "CHANNELS"),
                        12.verticalSpace,
                        _NotificationCard(
                          title: "Push notifications",
                          subtitle: "In-app & device push alerts",
                          value: _draft.canReceivePush,
                          onChanged: (v) =>
                              _update(_draft.copyWith(canReceivePush: v)),
                        ),
                        12.verticalSpace,
                        _NotificationCard(
                          title: "SMS",
                          subtitle: "Not yet available",
                          value: _sms,
                          onChanged: (v) => setState(() => _sms = v),
                        ),
                        12.verticalSpace,
                        _NotificationCard(
                          title: "Email",
                          subtitle: "Emails about your account and sessions",
                          value: _draft.canReceiveMail,
                          onChanged: (v) =>
                              _update(_draft.copyWith(canReceiveMail: v)),
                        ),
                        12.verticalSpace,
                        _NotificationCard(
                          title: "Wellness nudges",
                          subtitle: "Gentle reminders to check in on yourself",
                          value: _draft.wellnessNudges,
                          onChanged: (v) =>
                              _update(_draft.copyWith(wellnessNudges: v)),
                        ),

                        28.verticalSpace,

                        // ── Save ───────────────────────────────────────────────────
                        CustomButton(
                          elevation: 0,
                          bgColor: _hasChanges
                              ? Pallets.blueBubbleColor
                              : Pallets.lightBlue,
                          onPressed: (_hasChanges && !saving)
                              ? () => bloc.add(
                                  SettingsEvent.updateNotificationPreferencesV2(
                                      _draft))
                              : null,
                          child: saving
                              ? CustomDialogs.getLoading(
                                  size: 24, color: Colors.white)
                              : const TextView(
                                  text: "Save Preferences",
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                ),
                        ),

                        20.verticalSpace,
                      ],
                    ),
                  ),
          ),
        );
      },
    );
  }
}

/// Small caps section label, e.g. "SESSIONS".
class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return TextView(
      text: title,
      fontSize: 12,
      fontWeight: FontWeight.w700,
      color: Pallets.grey400,
      wordSpacing: 1,
    );
  }
}

/// Card row: title + subtitle on the left, [CustomSwitch] on the right,
/// on a light rounded background — matches the Notification mockup.
class _NotificationCard extends StatelessWidget {
  const _NotificationCard({
    required this.title,
    required this.subtitle,
    required this.value,
    required this.onChanged,
  });

  final String title;
  final String subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      decoration: BoxDecoration(
        color: Pallets.bgLight.withValues(alpha: 0.6),
        borderRadius: BorderRadius.circular(14.r),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextView(
                  text: title,
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: Pallets.boldBlackV2,
                ),
                4.verticalSpace,
                TextView(
                  text: subtitle,
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: Pallets.grey400,
                  lineHeight: 1.3,
                ),
              ],
            ),
          ),
          16.horizontalSpace,
          CustomSwitch(value: value, onChanged: onChanged),
        ],
      ),
    );
  }
}
