import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:go_router/go_router.dart';
import 'package:talkam/common/widgets/custom_appbar.dart';
import 'package:talkam/common/widgets/custom_button.dart';
import 'package:talkam/common/widgets/custom_text_field.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/core/navigation/route_url.dart';
import 'package:talkam/core/services/data/session_manager.dart';
import 'package:talkam/core/theme/pallets.dart';
import 'package:talkam/core/utils/validators.dart';
import 'package:talkam/features/authentication/dormain/repository/auth_repository.dart';

/// Guest entry point — picks a device-local alias. No account is created,
/// but the alias is checked against the same username-availability endpoint
/// Create Account uses, so a guest can't collide with a real account.
class AnonymousSignInScreen extends StatefulWidget {
  const AnonymousSignInScreen({super.key});

  @override
  State<AnonymousSignInScreen> createState() => _AnonymousSignInScreenState();
}

class _AnonymousSignInScreenState extends State<AnonymousSignInScreen> {
  static const int _minLength = 3;

  final _usernameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  String _username = '';
  Timer? _availabilityDebounce;

  /// null = not checked yet / currently checking.
  bool? _usernameAvailable;

  bool get _isLocallyValid =>
      _username.length >= _minLength && !_username.contains(' ');

  bool get _isUsernameValid => _isLocallyValid && (_usernameAvailable ?? false);

  @override
  void dispose() {
    _usernameController.dispose();
    _availabilityDebounce?.cancel();
    super.dispose();
  }

  void _onUsernameChanged(String value) {
    _availabilityDebounce?.cancel();
    setState(() {
      _username = value.trim();
      _usernameAvailable = null;
    });

    if (!_isLocallyValid) return;

    _availabilityDebounce = Timer(const Duration(milliseconds: 500), () async {
      try {
        final available =
            await injector.get<AuthRepository>().isUsernameAvailable(_username);
        if (mounted) setState(() => _usernameAvailable = available);
      } catch (_) {
        // Silently ignore — availability just stays unresolved.
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(
        bgColor: Colors.transparent,
        elevation: 0,
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ── Header ─────────────────────────────────────────────
                const TextView(
                  text: "Choose your username",
                  fontSize: 28,
                  fontWeight: FontWeight.w800,
                  color: Pallets.boldBlackV2,
                ),
                8.verticalSpace,
                const TextView(
                  text:
                      "This is your public profile in the community. No email or phone needed, fully anonymous.",
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Pallets.grey400,
                  lineHeight: 1.4,
                ),

                32.verticalSpace,

                // ── Username ───────────────────────────────────────────
                CustomTextField(
                  label: "Username",
                  hint: "Enter your alias name",
                  controller: _usernameController,
                  onChanged: _onUsernameChanged,
                  validator: MultiValidator([
                    RequiredValidator(errorText: "Username is required"),
                    MinLengthValidator(_minLength,
                        errorText:
                            "Username must be at least $_minLength characters"),
                    SpaceValidator(
                        errorText: "Username must not contain space"),
                  ]).call,
                ),

                if (_isLocallyValid) ...[
                  8.verticalSpace,
                  if (_usernameAvailable == null)
                    const TextView(
                      text: "Checking availability…",
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Pallets.grey400,
                    )
                  else
                    TextView(
                      text: _usernameAvailable!
                          ? "Username is available"
                          : "Username is taken",
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: _usernameAvailable!
                          ? Pallets.successGreen
                          : Pallets.errorRed,
                    ),
                ],

                20.verticalSpace,

                // ── Local-storage notice ───────────────────────────────
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                    decoration: BoxDecoration(
                      color: Pallets.transparentOrage,
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(color: Pallets.noticeAmber, width: 1),
                    ),
                    child: const TextView(
                      text:
                          "Your username is stored locally and can be changed.",
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: Pallets.noticeAmber,
                    ),
                  ),
                ),

                24.verticalSpace,

                // ── Continue ───────────────────────────────────────────
                CustomButton(
                  elevation: 0,
                  onPressed: _isUsernameValid ? _continueAsGuest : null,
                  bgColor: Pallets.blueBubbleColor,
                  borderRadius: BorderRadius.circular(24.r),
                  padding: EdgeInsets.symmetric(vertical: 16.h),
                  child: const TextView(
                    text: "Continue as User",
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),

                24.verticalSpace,
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _continueAsGuest() {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    SessionManager().anonymousUsername = _usernameController.text.trim();
    SessionManager().hasOnboarded = true;

    context.goNamed(PageUrl.homeScreen);
  }
}
