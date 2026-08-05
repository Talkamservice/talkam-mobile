import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:talkam/common/widgets/custom_appbar.dart';
import 'package:talkam/common/widgets/custom_button.dart';
import 'package:talkam/common/widgets/custom_switch.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/navigation/route_url.dart';
import 'package:talkam/core/services/data/session_manager.dart';
import 'package:talkam/core/theme/pallets.dart';

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
  _PrivacyPrefs _saved = const _PrivacyPrefs();
  _PrivacyPrefs _draft = const _PrivacyPrefs();

  bool _saving = false;
  bool get _hasChanges => _draft != _saved;

  void _update(_PrivacyPrefs next) => setState(() => _draft = next);

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
      backgroundColor: Pallets.white,
      appBar: const CustomAppBar(
        padding: EdgeInsets.all(0.0),
        tittleText: "Privacy",
        centerTile: false,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ── COMMUNITY ──────────────────────────────────────────────
                    const _SectionHeader(title: "COMMUNITY"),
                    12.verticalSpace,
                    if (!SessionManager.instance.isTherapistAccount) ...[
                      _ToggleRow(
                        title: "Anonymous mode",
                        subtitle: "When a session is booked or cancelled",
                        value: _draft.anonymousMode,
                        onChanged: (v) => _update(_draft.copyWith(anonymousMode: v)),
                      ),
                      12.verticalSpace,
                    ],
                    _ToggleRow(
                      title: "Read receipts",
                      subtitle: "Let others see when you've read their replies",
                      value: _draft.readReceipts,
                      onChanged: (v) => _update(_draft.copyWith(readReceipts: v)),
                    ),
                    12.verticalSpace,
                    _ToggleRow(
                      title: "Activity status",
                      subtitle: "Show when you were last active",
                      value: _draft.activityStatus,
                      onChanged: (v) => _update(_draft.copyWith(activityStatus: v)),
                    ),
      
                    24.verticalSpace,
      
                    // ── ACCOUNT SECURITY ───────────────────────────────────────
                    const _SectionHeader(title: "ACCOUNT SECURITY"),
                    12.verticalSpace,
                    _ToggleRow(
                      title: "Two-factor authentication",
                      subtitle: "Extra security on login via SMS OTP",
                      value: _draft.twoFactor,
                      onChanged: (v) => _update(_draft.copyWith(twoFactor: v)),
                    ),
                    12.verticalSpace,
                    _NavRow(
                      title: "Change Password",
                      subtitle: "Notified before session starts",
                      onTap: () => context.pushNamed(PageUrl.changePasswordScreen),
                    ),
                    12.verticalSpace,
                    _NavRow(
                      title: "Change Wallet PIN",
                      subtitle: "Update your 4-digit payment PIN",
                      onTap: () {},
                    ),
      
                    24.verticalSpace,
      
                    // ── SESSIONS ───────────────────────────────────────────────
                    const _SectionHeader(title: "SESSIONS"),
                    12.verticalSpace,
                    const _SessionsMergedCard(),
                  ],
                ),
              ),
            ),
            // ── Save Button ───────────────────────────────────────────────
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
              decoration: const BoxDecoration(
                color: Pallets.white,
              ),
              child: CustomButton(
                elevation: 0,
                bgColor: _hasChanges ? Pallets.primary : Pallets.primary, // Design shows blue button even if no changes? Will assume active by default.
                onPressed: _saving ? null : _save,
                borderRadius: BorderRadius.circular(12.r),
                child: _saving
                    ? SizedBox(
                        height: 20.w,
                        width: 20.w,
                        child: const CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      )
                    : const TextView(
                        text: "Save Settings",
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return TextView(
      text: title,
      fontSize: 12,
      fontWeight: FontWeight.w700,
      color: const Color(0xFF4B5563), // Darker gray matching design
      wordSpacing: 1,
    );
  }
}

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
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      decoration: BoxDecoration(
        color: const Color(0xFFF9FAFB),
        borderRadius: BorderRadius.circular(16.r),
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
                  color: const Color(0xFF6B7280), // Gray text
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
      borderRadius: BorderRadius.circular(16.r),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        decoration: BoxDecoration(
          color: const Color(0xFFF9FAFB),
          borderRadius: BorderRadius.circular(16.r),
        ),
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
                      color: const Color(0xFF6B7280),
                      lineHeight: 1.3,
                    ),
                  ],
                ],
              ),
            ),
            16.horizontalSpace,
            const Icon(
              Icons.chevron_right,
              size: 20.0,
              color: Color(0xFF6B7280),
            ),
          ],
        ),
      ),
    );
  }
}

class _SessionsMergedCard extends StatelessWidget {
  const _SessionsMergedCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFFF9FAFB),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const TextView(
                  text: "Push notifications",
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: Pallets.boldBlackV2,
                ),
                8.verticalSpace,
                const TextView(
                  text:
                      "TalkAM never records your therapy sessions. Video and audio stay exclusively between you and your therapist.",
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF6B7280),
                  lineHeight: 1.4,
                ),
                12.verticalSpace,
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE6FDF4),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.shield_outlined,
                        size: 16,
                        color: Color(0xFF0F9D58),
                      ),
                      6.horizontalSpace,
                      const TextView(
                        text: "End-to-end encrypted",
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF0F9D58),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          InkWell(
            onTap: () {},
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(16.r),
              bottomRight: Radius.circular(16.r),
            ),
            child: Padding(
              padding: EdgeInsets.all(16.w),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const TextView(
                          text: "Download my data",
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: Pallets.boldBlackV2,
                        ),
                        4.verticalSpace,
                        const TextView(
                          text: "Get a copy of all your TalkAM data",
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF6B7280),
                        ),
                      ],
                    ),
                  ),
                  16.horizontalSpace,
                  const Icon(
                    Icons.chevron_right,
                    size: 20.0,
                    color: Color(0xFF6B7280),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
