import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:go_router/go_router.dart';
import 'package:talkam/common/widgets/custom_appbar.dart';
import 'package:talkam/common/widgets/custom_button.dart';
import 'package:talkam/common/widgets/custom_text_field.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/navigation/route_url.dart';
import 'package:talkam/core/services/data/session_manager.dart';
import 'package:talkam/core/theme/pallets.dart';
import 'package:talkam/core/utils/validators.dart';

/// Guest entry point — picks a device-local alias. No account is created and
/// nothing is sent to the backend.
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

  /// Local validity only — the alias is never checked against the backend,
  /// because guests have no server-side account to collide with.
  bool get _isUsernameValid =>
      _username.length >= _minLength && !_username.contains(' ');

  @override
  void dispose() {
    _usernameController.dispose();
    super.dispose();
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
                  onChanged: (value) =>
                      setState(() => _username = value.trim()),
                  validator: MultiValidator([
                    RequiredValidator(errorText: "Username is required"),
                    MinLengthValidator(_minLength,
                        errorText:
                            "Username must be at least $_minLength characters"),
                    SpaceValidator(
                        errorText: "Username must not contain space"),
                  ]).call,
                ),

                if (_isUsernameValid) ...[
                  8.verticalSpace,
                  const TextView(
                    text: "Username is available",
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Pallets.successGreen,
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
