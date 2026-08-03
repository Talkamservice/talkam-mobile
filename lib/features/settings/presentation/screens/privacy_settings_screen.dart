import 'package:flutter/material.dart';
import 'package:talkam/common/widgets/custom_appbar.dart';
import 'package:talkam/common/widgets/custom_button.dart';
import 'package:talkam/common/widgets/custom_switch.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/constants/package_exports.dart';
import 'package:talkam/core/navigation/route_url.dart';
import 'package:talkam/core/theme/pallets.dart';

/// Privacy preferences the user can toggle and persist together.
///
/// Kept as a small immutable snapshot (mirrors [ConsentSettings] on the
/// Data & Privacy screen) so the Save button can compare against the last
/// saved state and enable itself only when something actually changed.
class _PrivacyPrefs {
  const _PrivacyPrefs({
    this.anonymousMode = false,
    this.readReceipts = true,
    this.activityStatus = true,
    this.twoFactor = false,
  });

  final bool anonymousMode;
  final bool readReceipts;
  final bool activityStatus;
  final bool twoFactor;

  _PrivacyPrefs copyWith({
    bool? anonymousMode,
    bool? readReceipts,
    bool? activityStatus,
    bool? twoFactor,
  }) =>
      _PrivacyPrefs(
        anonymousMode: anonymousMode ?? this.anonymousMode,
        readReceipts: readReceipts ?? this.readReceipts,
        activityStatus: activityStatus ?? this.activityStatus,
        twoFactor: twoFactor ?? this.twoFactor,
      );

  @override
  bool operator ==(Object other) =>
      other is _PrivacyPrefs &&
      other.anonymousMode == anonymousMode &&
      other.readReceipts == readReceipts &&
      other.activityStatus == activityStatus &&
      other.twoFactor == twoFactor;

  @override
  int get hashCode =>
      Object.hash(anonymousMode, readReceipts, activityStatus, twoFactor);
}

class PrivacySettingsScreen extends StatefulWidget {
  const PrivacySettingsScreen({super.key});

  @override
  State<PrivacySettingsScreen> createState() => _PrivacySettingsScreenState();
}

class _PrivacySettingsScreenState extends State<PrivacySettingsScreen> {
  /// The last state that was saved to the backend. In a real integration this
  /// would come from a bloc/repository fetch in [initState].
  _PrivacyPrefs _saved = const _PrivacyPrefs();

  /// The state currently reflected by the switches — diverges from [_saved]
  /// while the user is making changes.
  _PrivacyPrefs _draft = const _PrivacyPrefs();

  bool _saving = false;

  bool get _hasChanges => _draft != _saved;

  void _update(_PrivacyPrefs next) => setState(() => _draft = next);

  Future<void> _save() async {
    setState(() => _saving = true);
    // Persist happens here (bloc/repository). Simulated for now so the button
    // shows its loading state and then settles back to "no changes".
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
        tittleText: "Privacy",
        centerTile: false,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── COMMUNITY ──────────────────────────────────────────────
              const _SectionHeader(title: "COMMUNITY"),
              16.verticalSpace,
              _ToggleRow(
                title: "Anonymous mode",
                subtitle: "When a session is booked or canceled",
                value: _draft.anonymousMode,
                onChanged: (v) => _update(_draft.copyWith(anonymousMode: v)),
              ),
              20.verticalSpace,
              _ToggleRow(
                title: "Read receipts",
                subtitle: "Let others see when you've read their replies",
                value: _draft.readReceipts,
                onChanged: (v) => _update(_draft.copyWith(readReceipts: v)),
              ),
              20.verticalSpace,
              _ToggleRow(
                title: "Activity status",
                subtitle: "Show when you were last active",
                value: _draft.activityStatus,
                onChanged: (v) => _update(_draft.copyWith(activityStatus: v)),
              ),

              const _SectionDivider(),

              // ── ACCOUNT SECURITY ───────────────────────────────────────
              const _SectionHeader(title: "ACCOUNT SECURITY"),
              16.verticalSpace,
              _ToggleRow(
                title: "Two-factor authentication",
                subtitle: "Extra security on login via SMS OTP",
                value: _draft.twoFactor,
                onChanged: (v) => _update(_draft.copyWith(twoFactor: v)),
              ),
              20.verticalSpace,
              _NavRow(
                title: "Change Password",
                onTap: () => context.pushNamed(PageUrl.changePasswordScreen),
              ),
              20.verticalSpace,
              _NavRow(
                title: "Change Wallet PIN",
                subtitle: "Update your 4-digit payment PIN",
                onTap: () {},
              ),

              const _SectionDivider(),

              // ── SESSIONS ───────────────────────────────────────────────
              const _SectionHeader(title: "SESSIONS"),
              16.verticalSpace,
              const _EncryptionCard(),
              20.verticalSpace,
              _NavRow(
                title: "Download my data",
                subtitle: "Get a copy of all your TalkAM data",
                onTap: () {},
              ),

              32.verticalSpace,

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
                        text: "Save Settings",
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

/// Small caps section label, e.g. "COMMUNITY".
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

/// Spacing + hairline rule between sections.
class _SectionDivider extends StatelessWidget {
  const _SectionDivider();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        24.verticalSpace,
        const Divider(height: 1, color: Pallets.borderGrey),
        24.verticalSpace,
      ],
    );
  }
}

/// Title + subtitle on the left, [CustomSwitch] on the right.
class _ToggleRow extends StatelessWidget {
  const _ToggleRow({
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
    return Row(
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
    );
  }
}

/// Tappable row with a trailing chevron — used for navigation-style items.
class _NavRow extends StatelessWidget {
  const _NavRow({
    required this.title,
    this.subtitle,
    required this.onTap,
  });

  final String title;
  final String? subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
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
                if (subtitle != null) ...[
                  4.verticalSpace,
                  TextView(
                    text: subtitle!,
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: Pallets.grey400,
                    lineHeight: 1.3,
                  ),
                ],
              ],
            ),
          ),
          16.horizontalSpace,
          const Icon(
            Icons.arrow_forward_ios_sharp,
            size: 16.0,
            color: Color(0xFF444444),
          ),
        ],
      ),
    );
  }
}

/// Info card explaining session privacy, with an "End-to-end encrypted" badge.
class _EncryptionCard extends StatelessWidget {
  const _EncryptionCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      decoration: BoxDecoration(
        color: Pallets.bgLight.withValues(alpha: 0.6),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextView(
            text: "Push notifications",
            fontSize: 15,
            fontWeight: FontWeight.w700,
            color: Pallets.boldBlackV2,
          ),
          4.verticalSpace,
          const TextView(
            text:
                "TalkAM never records your therapy sessions. Video and audio stay exclusively between you and your therapist.",
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Pallets.boldBlackV2,
            lineHeight: 1.4,
          ),
          12.verticalSpace,
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
            decoration: BoxDecoration(
              color: Pallets.successGreen.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(100),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.lock_outline,
                  size: 14,
                  color: Pallets.successGreen,
                ),
                6.horizontalSpace,
                const TextView(
                  text: "End-to-end encrypted",
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: Pallets.successGreen,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
