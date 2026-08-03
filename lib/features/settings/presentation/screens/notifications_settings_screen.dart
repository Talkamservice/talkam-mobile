import 'package:flutter/material.dart';
import 'package:talkam/common/widgets/custom_appbar.dart';
import 'package:talkam/common/widgets/custom_button.dart';
import 'package:talkam/common/widgets/custom_switch.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/constants/package_exports.dart';
import 'package:talkam/core/theme/pallets.dart';

/// Notification preferences the user can toggle and persist together.
///
/// Kept as a small immutable snapshot (mirrors the Privacy screen) so the
/// Save button can compare against the last saved state and enable itself
/// only when something actually changed.
class _NotificationPrefs {
  const _NotificationPrefs({
    this.sessionConfirmation = true,
    this.sessionReminders = true,
    this.postSessionFeedback = true,
    this.paymentConfirmations = true,
    this.repliesToPosts = true,
    this.promotions = true,
    this.pushNotifications = true,
    this.sms = true,
    this.email = true,
  });

  final bool sessionConfirmation;
  final bool sessionReminders;
  final bool postSessionFeedback;
  final bool paymentConfirmations;
  final bool repliesToPosts;
  final bool promotions;
  final bool pushNotifications;
  final bool sms;
  final bool email;

  _NotificationPrefs copyWith({
    bool? sessionConfirmation,
    bool? sessionReminders,
    bool? postSessionFeedback,
    bool? paymentConfirmations,
    bool? repliesToPosts,
    bool? promotions,
    bool? pushNotifications,
    bool? sms,
    bool? email,
  }) =>
      _NotificationPrefs(
        sessionConfirmation: sessionConfirmation ?? this.sessionConfirmation,
        sessionReminders: sessionReminders ?? this.sessionReminders,
        postSessionFeedback: postSessionFeedback ?? this.postSessionFeedback,
        paymentConfirmations:
            paymentConfirmations ?? this.paymentConfirmations,
        repliesToPosts: repliesToPosts ?? this.repliesToPosts,
        promotions: promotions ?? this.promotions,
        pushNotifications: pushNotifications ?? this.pushNotifications,
        sms: sms ?? this.sms,
        email: email ?? this.email,
      );

  @override
  bool operator ==(Object other) =>
      other is _NotificationPrefs &&
      other.sessionConfirmation == sessionConfirmation &&
      other.sessionReminders == sessionReminders &&
      other.postSessionFeedback == postSessionFeedback &&
      other.paymentConfirmations == paymentConfirmations &&
      other.repliesToPosts == repliesToPosts &&
      other.promotions == promotions &&
      other.pushNotifications == pushNotifications &&
      other.sms == sms &&
      other.email == email;

  @override
  int get hashCode => Object.hash(
        sessionConfirmation,
        sessionReminders,
        postSessionFeedback,
        paymentConfirmations,
        repliesToPosts,
        promotions,
        pushNotifications,
        sms,
        email,
      );
}
class NotificationsSettingsScreen extends StatefulWidget {
  const NotificationsSettingsScreen({super.key});

  @override
  State<NotificationsSettingsScreen> createState() =>
      _NotificationsSettingsScreenState();
}

class _NotificationsSettingsScreenState
    extends State<NotificationsSettingsScreen> {
  /// The last state that was saved. In a real integration this would come
  /// from a bloc/repository fetch in [initState].
  _NotificationPrefs _saved = const _NotificationPrefs();

  /// The state currently reflected by the switches.
  _NotificationPrefs _draft = const _NotificationPrefs();

  bool _saving = false;

  bool get _hasChanges => _draft != _saved;

  void _update(_NotificationPrefs next) => setState(() => _draft = next);

  Future<void> _save() async {
    setState(() => _saving = true);
    await Future<void>.delayed(const Duration(milliseconds: 600));
    if (!mounted) return;
    setState(() {
      _saved = _draft;
      _saving = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(
        padding: EdgeInsets.all(0.0),
        tittleText: "Notification",
        centerTile: false,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
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
                onChanged: (v) => _update(_draft.copyWith(sessionReminders: v)),
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
                onChanged: (v) => _update(_draft.copyWith(repliesToPosts: v)),
              ),
              12.verticalSpace,
              _NotificationCard(
                title: "Promotions & updates",
                subtitle: "Notified before session starts",
                value: _draft.promotions,
                onChanged: (v) => _update(_draft.copyWith(promotions: v)),
              ),

              28.verticalSpace,

              // ── CHANNELS ───────────────────────────────────────────────
              const _SectionHeader(title: "CHANNELS"),
              12.verticalSpace,
              _NotificationCard(
                title: "Push notifications",
                subtitle: "In-app & device push alerts",
                value: _draft.pushNotifications,
                onChanged: (v) =>
                    _update(_draft.copyWith(pushNotifications: v)),
              ),
              12.verticalSpace,
              _NotificationCard(
                title: "SMS",
                subtitle: "Messages to +234 801 ⋯ 5678",
                value: _draft.sms,
                onChanged: (v) => _update(_draft.copyWith(sms: v)),
              ),
              12.verticalSpace,
              _NotificationCard(
                title: "Email",
                subtitle: "Emails to chisom@example.com",
                value: _draft.email,
                onChanged: (v) => _update(_draft.copyWith(email: v)),
              ),

              28.verticalSpace,

              // ── Save ───────────────────────────────────────────────────
              CustomButton(
                elevation: 0,
                bgColor:
                    _hasChanges ? Pallets.blueBubbleColor : Pallets.lightBlue,
                onPressed: (_hasChanges && !_saving) ? _save : null,
                child: _saving
                    ? SizedBox(
                        height: 20.w,
                        width: 20.w,
                        child: const CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      )
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


