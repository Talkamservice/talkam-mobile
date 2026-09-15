import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talkam/common/widgets/custom_appbar.dart';
import 'package:talkam/common/widgets/custom_button.dart';
import 'package:talkam/common/widgets/custom_countdown.dart';
import 'package:talkam/common/widgets/custom_dialogs.dart';
import 'package:talkam/common/widgets/custom_switch.dart';
import 'package:talkam/common/widgets/error_widget.dart';
import 'package:talkam/common/widgets/otp_field.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/constants/package_exports.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/core/theme/pallets.dart';
import 'package:talkam/features/authentication/dormain/repository/auth_repository.dart';
import 'package:talkam/features/profile/presentation/bloc/profile_bloc/profile_bloc.dart';
import 'package:talkam/features/settings/data/models/privacy_settings.dart';
import 'package:talkam/features/settings/presentation/blocs/settings/settings_bloc.dart';

/// The real 2FA flow, continuing from the toggle also surfaced on
/// [PrivacySettingsScreen] — both read/write the same
/// `PrivacySettings.twoFactorEnabled` through the same [SettingsBloc], so
/// there's only ever one source of truth for whether 2FA is actually on.
class TwoFactorAuthScreen extends StatefulWidget {
  const TwoFactorAuthScreen({super.key});

  @override
  State<TwoFactorAuthScreen> createState() => _TwoFactorAuthScreenState();
}

class _TwoFactorAuthScreenState extends State<TwoFactorAuthScreen> {
  final _bloc = SettingsBloc(injector.get(), injector.get());
  final _authRepository = injector.get<AuthRepository>();

  PrivacySettings? _settings;

  @override
  void initState() {
    super.initState();
    _bloc.add(const SettingsEvent.getPrivacySettings());
  }

  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }

  void _onToggle(bool value) {
    final current = _settings;
    if (current == null) return;

    if (!value) {
      CustomDialogs.showConfirmDialog(
        context,
        tittle: "Turn off two-factor authentication?",
        message: "Your account will only need your password to sign in.",
        confirmText: "Turn off",
        confirmButtonBgColor: Pallets.dangerText,
        onYes: () {
          CustomDialogs.hideLoading(context);
          _bloc.add(SettingsEvent.updatePrivacySettings(
              current.copyWith(twoFactorEnabled: false)));
        },
      );
      return;
    }

    _startEnableFlow(current);
  }

  Future<void> _startEnableFlow(PrivacySettings current) async {
    final email = injector.get<ProfileBloc>().appUser?.email;
    if (email == null) return;

    CustomDialogs.showLoading(context);
    try {
      await _authRepository.sendOtp(email, 'login');
    } catch (error) {
      if (!mounted) return;
      CustomDialogs.hideLoading(context);
      CustomDialogs.error(error.toString());
      return;
    }
    if (!mounted) return;
    CustomDialogs.hideLoading(context);

    Navigator.of(context).push(MaterialPageRoute(
      builder: (_) => _EnableOtpScreen(
        bloc: _bloc,
        email: email,
        settings: current,
        onResend: () => _authRepository.sendOtp(email, 'login'),
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SettingsBloc, SettingsState>(
      bloc: _bloc,
      listener: (context, state) {
        state.maybeWhen(
          orElse: () => null,
          getPrivacySettingsSuccess: (settings) =>
              setState(() => _settings = settings),
          updatePrivacySettingsSuccess: (settings) {
            setState(() => _settings = settings);
            CustomDialogs.success(settings.twoFactorEnabled
                ? "Two-factor authentication turned on"
                : "Two-factor authentication turned off");
          },
          updatePrivacySettingsFailure: (error) => CustomDialogs.error(error),
        );
      },
      builder: (context, state) {
        final loading = state.maybeWhen(
          orElse: () => false,
          getPrivacySettingsLoading: () => true,
        );
        final saving = state.maybeWhen(
          orElse: () => false,
          updatePrivacySettingsLoading: () => true,
        );
        final loadError = state.maybeWhen(
          orElse: () => null,
          getPrivacySettingsFailure: (error) => error,
        );

        return Scaffold(
          backgroundColor: Pallets.white,
          appBar: const CustomAppBar(
            padding: EdgeInsets.all(0.0),
            tittleText: "Two-Factor Authentication",
            centerTile: false,
            showDivider: true,
          ),
          body: SafeArea(
            child: loading
                ? Center(child: CustomDialogs.getLoading(size: 50))
                : loadError != null
                    ? AppErrorWidget(
                        message: loadError,
                        onTap: () =>
                            _bloc.add(const SettingsEvent.getPrivacySettings()),
                      )
                    : Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 16.w, vertical: 24.h),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: EdgeInsets.all(16.w),
                              decoration: BoxDecoration(
                                color: Pallets.bgLight,
                                borderRadius: BorderRadius.circular(16.r),
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        TextView(
                                          text: "Email verification",
                                          fontSize: 15,
                                          fontWeight: FontWeight.w700,
                                          color: Pallets.boldBlackV2,
                                        ),
                                        4.verticalSpace,
                                        TextView(
                                          text: (_settings?.twoFactorEnabled ??
                                                  false)
                                              ? "On — we'll email you an OTP every time you sign in."
                                              : "Off — turn on to require an OTP sent to your email when signing in.",
                                          fontSize: 13,
                                          fontWeight: FontWeight.w500,
                                          color: Pallets.grey400,
                                          lineHeight: 1.35,
                                        ),
                                      ],
                                    ),
                                  ),
                                  16.horizontalSpace,
                                  saving
                                      ? SizedBox(
                                          width: 24.w,
                                          height: 24.w,
                                          child:
                                              const CircularProgressIndicator(
                                                  strokeWidth: 2),
                                        )
                                      : CustomSwitch(
                                          value: _settings?.twoFactorEnabled ??
                                              false,
                                          onChanged: _onToggle,
                                        ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
          ),
        );
      },
    );
  }
}

/// Full OTP step for confirming 2FA turn-on — resend gated by a countdown,
/// wrong codes re-show the same screen with an inline error instead of
/// dropping the user back to a stale toggle.
class _EnableOtpScreen extends StatefulWidget {
  const _EnableOtpScreen({
    required this.bloc,
    required this.email,
    required this.settings,
    required this.onResend,
  });

  final SettingsBloc bloc;
  final String email;
  final PrivacySettings settings;
  final Future<void> Function() onResend;

  @override
  State<_EnableOtpScreen> createState() => _EnableOtpScreenState();
}

class _EnableOtpScreenState extends State<_EnableOtpScreen> {
  final _otpController = TextEditingController();
  bool _hasError = false;
  bool _isCounting = true;
  DateTime _countdownEnd = DateTime.now().add(const Duration(seconds: 60));

  @override
  void dispose() {
    _otpController.dispose();
    super.dispose();
  }

  void _confirm() {
    widget.bloc.add(SettingsEvent.updatePrivacySettings(
      widget.settings.copyWith(twoFactorEnabled: true),
      otp: _otpController.text,
    ));
  }

  Future<void> _resend() async {
    setState(() {
      _isCounting = true;
      _hasError = false;
      _otpController.clear();
      _countdownEnd = DateTime.now().add(const Duration(seconds: 60));
    });
    try {
      await widget.onResend();
      if (mounted) CustomDialogs.success("OTP resent");
    } catch (error) {
      if (mounted) CustomDialogs.error(error.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SettingsBloc, SettingsState>(
      bloc: widget.bloc,
      listener: (context, state) {
        state.maybeWhen(
          orElse: () => null,
          updatePrivacySettingsSuccess: (_) => Navigator.of(context).pop(),
          updatePrivacySettingsFailure: (_) => setState(() => _hasError = true),
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
            tittleText: "Verify It's You",
            centerTile: false,
            showDivider: true,
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const TextView(
                    text: "Enter the OTP we emailed you",
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                  8.verticalSpace,
                  Wrap(
                    children: [
                      const TextView(
                        text: "We sent a 6-digit OTP to ",
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: Pallets.grey400,
                      ),
                      TextView(
                        text: widget.email,
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: Pallets.boldBlackV2,
                      ),
                    ],
                  ),
                  24.verticalSpace,
                  Center(
                    child: OtpField(
                      count: 6,
                      controller: _otpController,
                      hasError: _hasError,
                      onChanged: (_) => setState(() => _hasError = false),
                    ),
                  ),
                  20.verticalSpace,
                  Center(
                    child: _isCounting
                        ? Wrap(
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: [
                              const TextView(
                                text: "Resend OTP in ",
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                                color: Pallets.grey400,
                              ),
                              CustomCountDown(
                                endTime: _countdownEnd,
                                onEnd: () =>
                                    setState(() => _isCounting = false),
                                style: TextStyle(
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w500,
                                  color: Pallets.grey400,
                                ),
                              ),
                              const TextView(
                                text: "s",
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                                color: Pallets.grey400,
                              ),
                            ],
                          )
                        : TextView(
                            text: "Resend OTP",
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            color: Pallets.blueBubbleColor,
                            onTap: _resend,
                          ),
                  ),
                  24.verticalSpace,
                  CustomButton(
                    elevation: 0,
                    onPressed: (_otpController.text.length == 6 && !saving)
                        ? _confirm
                        : null,
                    child: saving
                        ? CustomDialogs.getLoading(
                            size: 24, color: Colors.white)
                        : const TextView(
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
      },
    );
  }
}
