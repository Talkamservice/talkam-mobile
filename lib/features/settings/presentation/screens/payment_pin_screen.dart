import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talkam/common/widgets/custom_appbar.dart';
import 'package:talkam/common/widgets/custom_button.dart';
import 'package:talkam/common/widgets/custom_dialogs.dart';
import 'package:talkam/common/widgets/otp_field.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/constants/package_exports.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/core/theme/pallets.dart';
import 'package:talkam/features/authentication/dormain/repository/auth_repository.dart';
import 'package:talkam/features/profile/presentation/bloc/profile_bloc/profile_bloc.dart';
import 'package:talkam/features/settings/presentation/blocs/settings/settings_bloc.dart';

/// Sets or changes the 4-digit payment PIN that authorizes saved-card
/// charges. The API accepts either [current_pin] (an existing PIN) or a
/// fresh TYPE_PASSWORD_RESET otp to authorize a change — neither is required
/// the first time a PIN is set, so both stay optional here and the server
/// is the source of truth on whether one was actually needed.
class PaymentPinScreen extends StatefulWidget {
  const PaymentPinScreen({super.key});

  @override
  State<PaymentPinScreen> createState() => _PaymentPinScreenState();
}

class _PaymentPinScreenState extends State<PaymentPinScreen> {
  final bloc = SettingsBloc(injector.get(), injector.get());
  final _authRepository = injector.get<AuthRepository>();

  final _pinController = TextEditingController();
  final _currentPinController = TextEditingController();
  final _otpController = TextEditingController();

  bool _useOtp = false;
  bool _requestingOtp = false;

  bool get _isFormValid =>
      _pinController.text.length == 4 &&
      (_useOtp ? _otpController.text.length == 6 : true);

  @override
  void dispose() {
    bloc.close();
    _pinController.dispose();
    _currentPinController.dispose();
    _otpController.dispose();
    super.dispose();
  }

  Future<void> _requestOtp() async {
    final email = injector.get<ProfileBloc>().appUser?.email;
    if (email == null) return;
    setState(() => _requestingOtp = true);
    try {
      await _authRepository.sendOtp(email, 'password_reset');
      if (!mounted) return;
      setState(() {
        _useOtp = true;
        _requestingOtp = false;
      });
    } catch (error) {
      if (!mounted) return;
      setState(() => _requestingOtp = false);
      CustomDialogs.error(error.toString());
    }
  }

  void _submit() {
    bloc.add(SettingsEvent.setPaymentPin(
      pin: _pinController.text,
      currentPin: _useOtp || _currentPinController.text.length != 4
          ? null
          : _currentPinController.text,
      otp: _useOtp && _otpController.text.length == 6
          ? _otpController.text
          : null,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SettingsBloc, SettingsState>(
      bloc: bloc,
      listener: (context, state) {
        state.maybeWhen(
          orElse: () => null,
          setPaymentPinLoading: () => CustomDialogs.showLoading(context),
          setPaymentPinFailure: (error) {
            context.pop();
            CustomDialogs.error(error);
          },
          setPaymentPinSuccess: () {
            context.pop();
            CustomDialogs.success("Payment PIN saved");
            context.pop();
          },
        );
      },
      builder: (context, state) {
        final saving = state.maybeWhen(
          orElse: () => false,
          setPaymentPinLoading: () => true,
        );

        return Scaffold(
          backgroundColor: Colors.white,
          appBar: const CustomAppBar(
            padding: EdgeInsets.all(0.0),
            tittleText: "Payment PIN",
            centerTile: false,
            showDivider: true,
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const TextView(
                    text: "New PIN",
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                  4.verticalSpace,
                  const TextView(
                    text: "4 digits, used to authorize saved-card charges.",
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: Pallets.grey400,
                  ),
                  16.verticalSpace,
                  OtpField(
                    count: 4,
                    controller: _pinController,
                    obscureText: true,
                    onChanged: (_) => setState(() {}),
                  ),
                  28.verticalSpace,
                  if (!_useOtp) ...[
                    const TextView(
                      text: "Current PIN",
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                    4.verticalSpace,
                    const TextView(
                      text: "Only required if you already have a PIN set.",
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: Pallets.grey400,
                    ),
                    16.verticalSpace,
                    OtpField(
                      count: 4,
                      controller: _currentPinController,
                      obscureText: true,
                      onChanged: (_) => setState(() {}),
                    ),
                    12.verticalSpace,
                    TextView(
                      text: _requestingOtp
                          ? "Sending code…"
                          : "Forgot your PIN? Verify with a code instead",
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: Pallets.blueBubbleColor,
                      onTap: _requestingOtp ? null : _requestOtp,
                    ),
                  ] else ...[
                    const TextView(
                      text: "Verification code",
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                    4.verticalSpace,
                    const TextView(
                      text: "Enter the 6-digit code sent to your email.",
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: Pallets.grey400,
                    ),
                    16.verticalSpace,
                    OtpField(
                      count: 6,
                      controller: _otpController,
                      onChanged: (_) => setState(() {}),
                    ),
                  ],
                  36.verticalSpace,
                  CustomButton(
                    elevation: 0,
                    bgColor: _isFormValid
                        ? Pallets.blueBubbleColor
                        : Pallets.lightBlue,
                    onPressed: (_isFormValid && !saving) ? _submit : null,
                    child: const TextView(
                      text: "Save PIN",
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
