import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:talkam/common/widgets/custom_appbar.dart';
import 'package:talkam/common/widgets/custom_button.dart';
import 'package:talkam/common/widgets/custom_dialogs.dart';
import 'package:talkam/common/widgets/custom_switch.dart';
import 'package:talkam/common/widgets/otp_field.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/core/navigation/route_url.dart';
import 'package:talkam/core/services/data/session_manager.dart';
import 'package:talkam/core/theme/pallets.dart';
import 'package:talkam/core/utils/helper_utils.dart';
import 'package:talkam/features/authentication/dormain/repository/auth_repository.dart';
import 'package:talkam/features/profile/presentation/bloc/profile_bloc/profile_bloc.dart';
import 'package:talkam/features/settings/data/models/privacy_settings.dart';
import 'package:talkam/features/settings/presentation/blocs/settings/settings_bloc.dart';

class PrivacySettingsScreen extends StatefulWidget {
  const PrivacySettingsScreen({super.key});

  @override
  State<PrivacySettingsScreen> createState() => _PrivacySettingsScreenState();
}

class _PrivacySettingsScreenState extends State<PrivacySettingsScreen> {
  final bloc = SettingsBloc(injector.get(), injector.get());
  final _authRepository = injector.get<AuthRepository>();

  PrivacySettings _saved = const PrivacySettings();
  PrivacySettings _draft = const PrivacySettings();

  bool get _hasChanges => _draft != _saved;

  void _update(PrivacySettings next) => setState(() => _draft = next);

  @override
  void initState() {
    super.initState();
    bloc.add(const SettingsEvent.getPrivacySettings());
  }

  @override
  void dispose() {
    bloc.close();
    super.dispose();
  }

  Future<void> _save() async {
    // Turning 2FA on for the first time needs a fresh TYPE_LOGIN otp before
    // the server will accept the change.
    if (_draft.twoFactorEnabled && !_saved.twoFactorEnabled) {
      final email = injector.get<ProfileBloc>().appUser?.email;
      if (email == null) return;
      try {
        await _authRepository.sendOtp(email, 'login');
      } catch (error) {
        if (mounted) CustomDialogs.error(error.toString());
        return;
      }
      if (!mounted) return;
      final otp = await _promptForOtp();
      if (otp == null || !mounted) return;
      bloc.add(SettingsEvent.updatePrivacySettings(_draft, otp: otp));
      return;
    }
    bloc.add(SettingsEvent.updatePrivacySettings(_draft));
  }

  Future<String?> _promptForOtp() {
    final controller = TextEditingController();
    return showDialog<String>(
      context: context,
      builder: (dialogContext) => Dialog(
        backgroundColor: Colors.white,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
        insetPadding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Padding(
          padding: EdgeInsets.all(20.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const TextView(
                text: "Enter the 6-digit code we sent to confirm turning on"
                    " two-factor authentication.",
                fontSize: 14,
                fontWeight: FontWeight.w600,
                align: TextAlign.center,
                lineHeight: 1.35,
              ),
              20.verticalSpace,
              OtpField(count: 6, controller: controller),
              20.verticalSpace,
              CustomButton(
                elevation: 0,
                onPressed: () =>
                    Navigator.of(dialogContext).pop(controller.text),
                child: const TextView(
                  text: "Confirm",
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _openDataExport() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (_) => _DataExportSheet(bloc: bloc),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SettingsBloc, SettingsState>(
      bloc: bloc,
      listener: (context, state) {
        state.maybeWhen(
          orElse: () => null,
          getPrivacySettingsSuccess: (settings) => setState(() {
            _saved = settings;
            _draft = settings;
          }),
          getPrivacySettingsFailure: (error) => CustomDialogs.error(error),
          updatePrivacySettingsSuccess: (settings) => setState(() {
            _saved = settings;
            _draft = settings;
          }),
          updatePrivacySettingsFailure: (error) => CustomDialogs.error(error),
        );
      },
      builder: (context, state) {
        final saving = state.maybeWhen(
          orElse: () => false,
          updatePrivacySettingsLoading: () => true,
        );

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
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // ── COMMUNITY ──────────────────────────────────────────────
                        const _SectionHeader(title: "COMMUNITY"),
                        12.verticalSpace,
                        if (!SessionManager.instance.isTherapistAccount) ...[
                          _ToggleRow(
                            title: "Anonymous mode",
                            subtitle:
                                "Post and comment without your name showing",
                            value: _draft.anonymousMode,
                            onChanged: (v) =>
                                _update(_draft.copyWith(anonymousMode: v)),
                          ),
                          12.verticalSpace,
                        ],
                        _ToggleRow(
                          title: "Read receipts",
                          subtitle:
                              "Let others see when you've read their replies",
                          value: _draft.readReceipts,
                          onChanged: (v) =>
                              _update(_draft.copyWith(readReceipts: v)),
                        ),
                        12.verticalSpace,
                        _ToggleRow(
                          title: "Activity status",
                          subtitle: "Show when you were last active",
                          value: _draft.activityStatus,
                          onChanged: (v) =>
                              _update(_draft.copyWith(activityStatus: v)),
                        ),

                        24.verticalSpace,

                        // ── ACCOUNT SECURITY ───────────────────────────────────────
                        const _SectionHeader(title: "ACCOUNT SECURITY"),
                        12.verticalSpace,
                        _ToggleRow(
                          title: "Two-factor authentication",
                          subtitle: "Extra security on login via email OTP",
                          value: _draft.twoFactorEnabled,
                          onChanged: (v) =>
                              _update(_draft.copyWith(twoFactorEnabled: v)),
                        ),
                        12.verticalSpace,
                        _NavRow(
                          title: "Change Password",
                          subtitle: "Update your account password",
                          onTap: () =>
                              context.pushNamed(PageUrl.changePasswordScreen),
                        ),
                        12.verticalSpace,
                        _NavRow(
                          title: "Change Wallet PIN",
                          subtitle: "Update your 4-digit payment PIN",
                          onTap: () =>
                              context.pushNamed(PageUrl.paymentPinScreen),
                        ),

                        24.verticalSpace,

                        // ── SESSIONS ───────────────────────────────────────────────
                        const _SectionHeader(title: "SESSIONS"),
                        12.verticalSpace,
                        _SessionsMergedCard(onDownloadData: _openDataExport),
                      ],
                    ),
                  ),
                ),
                // ── Save Button ───────────────────────────────────────────────
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                  decoration: const BoxDecoration(
                    color: Pallets.white,
                  ),
                  child: CustomButton(
                    elevation: 0,
                    bgColor: _hasChanges ? Pallets.primary : Pallets.lightBlue,
                    onPressed: (_hasChanges && !saving) ? _save : null,
                    borderRadius: BorderRadius.circular(12.r),
                    child: saving
                        ? CustomDialogs.getLoading(
                            size: 24, color: Colors.white)
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
      },
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
  const _SessionsMergedCard({required this.onDownloadData});

  final VoidCallback onDownloadData;

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
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
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
            onTap: onDownloadData,
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

/// Bottom sheet for `POST /user/data-export` + `GET /user/data-export/latest`.
/// Shows the last known status on open and lets the user kick off a new
/// export; once a link is ready it's opened via the system browser.
class _DataExportSheet extends StatefulWidget {
  const _DataExportSheet({required this.bloc});

  final SettingsBloc bloc;

  @override
  State<_DataExportSheet> createState() => _DataExportSheetState();
}

class _DataExportSheetState extends State<_DataExportSheet> {
  @override
  void initState() {
    super.initState();
    widget.bloc.add(const SettingsEvent.getDataExportStatus());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsBloc, SettingsState>(
      bloc: widget.bloc,
      builder: (context, state) {
        final loading = state.maybeWhen(
          orElse: () => false,
          getDataExportStatusLoading: () => true,
          requestDataExportLoading: () => true,
        );
        final status = state.maybeWhen(
          orElse: () => null,
          getDataExportStatusSuccess: (s) => s,
          requestDataExportSuccess: (s) => s,
        );
        final error = state.maybeWhen(
          orElse: () => null,
          getDataExportStatusFailure: (e) => e,
          requestDataExportFailure: (e) => e,
        );

        return Padding(
          padding: EdgeInsets.fromLTRB(
            20.w,
            20.h,
            20.w,
            20.h + MediaQuery.viewInsetsOf(context).bottom,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const TextView(
                text: "Download my data",
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
              8.verticalSpace,
              const TextView(
                text:
                    "We'll package a copy of your TalkAM data. The link expires 7 days after it's ready.",
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: Pallets.grey400,
                lineHeight: 1.4,
              ),
              20.verticalSpace,
              if (loading)
                Center(child: CustomDialogs.getLoading(size: 50))
              else if (error != null)
                TextView(
                  text: error,
                  fontSize: 13,
                  color: Pallets.errorRed,
                )
              else if (status != null)
                TextView(
                  text: status.isReady
                      ? "Your export is ready to download."
                      : "Status: ${status.status}",
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              20.verticalSpace,
              if (status?.isReady == true)
                CustomButton(
                  elevation: 0,
                  onPressed: () => Helpers.launchRawUrl(status!.downloadUrl!),
                  child: const TextView(
                    text: "Download",
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                )
              else
                CustomButton(
                  elevation: 0,
                  onPressed: loading
                      ? null
                      : () => widget.bloc
                          .add(const SettingsEvent.requestDataExport()),
                  child: const TextView(
                    text: "Request export",
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
