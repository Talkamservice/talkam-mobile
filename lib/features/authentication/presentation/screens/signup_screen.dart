import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:go_router/go_router.dart';
import 'package:phone_numbers_parser/phone_numbers_parser.dart';
import 'package:talkam/common/models/get_countries_response.dart';
import 'package:talkam/common/widgets/custom_appbar.dart';
import 'package:talkam/common/widgets/custom_button.dart';
import 'package:talkam/common/widgets/custom_dialogs.dart';
import 'package:talkam/common/widgets/custom_dropdown.dart';
import 'package:talkam/common/widgets/inline_select_field.dart';
import 'package:talkam/common/widgets/custom_outlined_button.dart';
import 'package:talkam/common/widgets/custom_text_field.dart';
import 'package:talkam/common/widgets/date_picker_field.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/core/navigation/path_params.dart';
import 'package:talkam/core/navigation/route_url.dart';
import 'package:talkam/core/theme/pallets.dart';
import 'package:talkam/core/utils/phone_utils.dart';
import 'package:talkam/features/authentication/dormain/mixins/auth_success_mixin.dart';
import 'package:talkam/features/authentication/dormain/repository/auth_repository.dart';
import 'package:talkam/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:talkam/features/authentication/presentation/screens/verify_otp_screen.dart';
import 'package:talkam/features/post/presentation/widgets/country_picker_sheet.dart';
import 'package:talkam/gen/assets.gen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> with AuthSuccessMixin {
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final authBloc = AuthBloc(injector.get());

  bool _passwordObscured = true;
  TalkamCountry? _selectedCountry;
  String? _selectedGender;
  DateTime? _selectedDob;
  final _scrollController = ScrollController();
  double _scrollOffset = 0;

  Timer? _usernameDebounce;
  bool? _usernameAvailable;

  final _phoneFocusNode = FocusNode();

  static const List<String> _genders = [
    'Male',
    'Female',
    'Non-binary',
  ];

  /// Resolved from the selected country's name — null when nothing's
  /// selected yet, or the name doesn't map to a known country, in which
  /// case the phone field just falls back to plain required-field checks.
  IsoCode? get _isoCode => isoCodeForCountryName(_selectedCountry?.name);

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      setState(() => _scrollOffset = _scrollController.offset);
    });
    _phoneFocusNode.addListener(() {
      if (!_phoneFocusNode.hasFocus) _reformatPhoneField();
    });
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    _scrollController.dispose();
    _usernameDebounce?.cancel();
    _phoneFocusNode.dispose();
    super.dispose();
  }

  /// Best-effort — reformats the typed digits into the selected country's
  /// national layout (e.g. "0801 234 5678") once they parse as valid.
  /// Leaves the raw text untouched otherwise, so an in-progress or
  /// unrecognized number is never silently mangled.
  void _reformatPhoneField() {
    final isoCode = _isoCode;
    final raw = _phoneController.text.trim();
    if (isoCode == null || raw.isEmpty) return;

    try {
      final phone = PhoneNumber.parse(raw, callerCountry: isoCode);
      if (phone.isValid()) {
        _phoneController.text = phone.formatNsn(format: NsnFormat.national);
      }
    } catch (_) {
      // Not parseable yet (still typing, or not a real number) — leave as-is.
    }
  }

  String? _validatePhone(String? value) {
    final raw = value?.trim() ?? '';
    if (raw.isEmpty) return "Phone number is required";

    final isoCode = _isoCode;
    if (isoCode == null) {
      return null; // No country resolved — can't check further.
    }

    try {
      final phone = PhoneNumber.parse(raw, callerCountry: isoCode);
      if (!phone.isValid()) {
        return "Enter a valid phone number for ${_selectedCountry?.name}";
      }
    } catch (_) {
      return "Enter a valid phone number";
    }
    return null;
  }

  void _onUsernameChanged(String value) {
    _usernameDebounce?.cancel();
    setState(() => _usernameAvailable = null);

    final username = value.trim();
    if (username.length < 3) return;

    _usernameDebounce = Timer(const Duration(milliseconds: 500), () async {
      try {
        final available =
            await injector.get<AuthRepository>().isUsernameAvailable(username);
        if (mounted) setState(() => _usernameAvailable = available);
      } catch (_) {
        // Silently ignore — the real check still runs server-side on submit.
      }
    });
  }

  Future<TalkamCountry?> _pickCountry(BuildContext context) {
    return CustomDialogs.showBottomSheet(
      context,
      Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: const CountryPickerSheet(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      bloc: authBloc,
      listener: _listenToAuthBloc,
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: const CustomAppBar(
            bgColor: Colors.transparent,
            elevation: 0,
          ),
          body: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ── Pinned header ──────────────────────────────────────
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const TextView(
                        text: "Create your Account",
                        fontSize: 28,
                        fontWeight: FontWeight.w800,
                        color: Pallets.boldBlackV2,
                      ),
                      8.verticalSpace,
                      const TextView(
                        text:
                            "Your identity remains private; your username is kept separate.",
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Pallets.grey400,
                        lineHeight: 1.4,
                      ),
                      20.verticalSpace,
                    ],
                  ),
                ),

                // ── Scrollable form with top fade ──────────────────────
                Expanded(
                  child: ShaderMask(
                    shaderCallback: (rect) {
                      return LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        stops: const [0.0, 0.08],
                        colors: [
                          Colors.white
                              .withOpacity((_scrollOffset > 4 ? 0.0 : 1.0)),
                          Colors.white,
                        ],
                      ).createShader(rect);
                    },
                    blendMode: BlendMode.dstIn,
                    child: SingleChildScrollView(
                      controller: _scrollController,
                      padding: EdgeInsets.symmetric(horizontal: 24.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Full Name
                          CustomTextField(
                            label: "Full Name",
                            hint: "Enter your name",
                            controller: _fullNameController,
                            keyboardType: TextInputType.name,
                            validator: RequiredValidator(
                                    errorText: "Full name is required")
                                .call,
                          ),

                          16.verticalSpace,

                          // Email
                          CustomTextField(
                            label: "Email address",
                            hint: "Enter your Email Address",
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                            validator: MultiValidator([
                              RequiredValidator(errorText: "Email is required"),
                              EmailValidator(
                                  errorText: "Enter a valid email address"),
                            ]).call,
                          ),

                          16.verticalSpace,

                          // Phone Number
                          CustomTextField(
                            label: "Phone Number",
                            hint: "Enter your number",
                            controller: _phoneController,
                            focusNode: _phoneFocusNode,
                            keyboardType: TextInputType.phone,
                            validator: _validatePhone,
                            prefixIcon: _isoCode == null
                                ? null
                                : Padding(
                                    padding:
                                        EdgeInsets.only(left: 16.w, right: 8.w),
                                    child: Center(
                                      widthFactor: 1,
                                      child: TextView(
                                        text: callingCodeFor(_isoCode!),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: Pallets.boldBlack,
                                      ),
                                    ),
                                  ),
                          ),

                          16.verticalSpace,

                          // Username
                          CustomTextField(
                            label: "Username",
                            hint: "Use a unique name",
                            controller: _usernameController,
                            onChanged: _onUsernameChanged,
                            validator: MultiValidator([
                              RequiredValidator(
                                  errorText: "Username is required"),
                              MinLengthValidator(3,
                                  errorText:
                                      "Username must be at least 3 characters"),
                            ]).call,
                          ),
                          if (_usernameAvailable != null) ...[
                            6.verticalSpace,
                            TextView(
                              text: _usernameAvailable!
                                  ? "Username is available"
                                  : "Username is taken",
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: _usernameAvailable!
                                  ? Pallets.successGreen
                                  : Pallets.errorRed,
                            ),
                          ],

                          16.verticalSpace,

                          // Country
                          FormField<TalkamCountry>(
                            initialValue: _selectedCountry,
                            validator: (val) =>
                                val == null ? "Please select a country" : null,
                            builder: (state) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const TextView(
                                    text: "Country",
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: Pallets.boldBlackV2,
                                  ),
                                  8.verticalSpace,
                                  InkWell(
                                    borderRadius: BorderRadius.circular(14.r),
                                    onTap: () async {
                                      final country =
                                          await _pickCountry(context);
                                      if (country != null) {
                                        setState(
                                            () => _selectedCountry = country);
                                        state.didChange(country);
                                        // The dial code/expected format just
                                        // changed — reformat whatever's
                                        // already typed against it.
                                        _reformatPhoneField();
                                      }
                                    },
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 16.w, vertical: 14.h),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: state.hasError
                                              ? Pallets.errorRed
                                              : Pallets.grey90,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(14.r),
                                      ),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: TextView(
                                              text: _selectedCountry?.name ??
                                                  "Select your country",
                                              fontSize: 14,
                                              color: _selectedCountry == null
                                                  ? Pallets.grey75
                                                  : Pallets.boldBlack,
                                            ),
                                          ),
                                          const Icon(
                                            Icons.keyboard_arrow_down_rounded,
                                            color: Pallets.grey400,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  if (state.hasError) ...[
                                    4.verticalSpace,
                                    TextView(
                                      text: state.errorText ?? '',
                                      fontSize: 12,
                                      color: Pallets.errorRed,
                                    ),
                                  ],
                                ],
                              );
                            },
                          ),

                          16.verticalSpace,

                          // Date of Birth
                          DatePickerField(
                            label: "Date of birth",
                            hint: "20/01/01",
                            iconAsset: Assets.images.svgs.calendar3,
                            lastDate: DateTime(DateTime.now().year - 5,
                                DateTime.now().month, DateTime.now().day),
                            firstDate: DateTime(1900),
                            onChanged: (date) =>
                                setState(() => _selectedDob = date),
                            validator: (_) => _selectedDob == null
                                ? "Date of birth is required"
                                : null,
                          ),

                          16.verticalSpace,

                          // Gender
                          FormField<String>(
                            initialValue: _selectedGender,
                            validator: (_) => _selectedGender == null
                                ? "Please select a gender"
                                : null,
                            builder: (state) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  InlineSelectField<String>(
                                    label: "Gender",
                                    hint: "Select gender",
                                    options: _genders,
                                    labelBuilder: (g) => g,
                                    value: _selectedGender,
                                    onSingleChanged: (val) {
                                      setState(() => _selectedGender = val);
                                      state.didChange(val);
                                    },
                                  ),
                                  if (state.hasError) ...[
                                    4.verticalSpace,
                                    Padding(
                                      padding: EdgeInsets.only(left: 12.w),
                                      child: TextView(
                                        text: state.errorText ?? '',
                                        fontSize: 12,
                                        color: Pallets.errorRed,
                                      ),
                                    ),
                                  ],
                                ],
                              );
                            },
                          ),

                          16.verticalSpace,

                          // Password
                          CustomTextField(
                            label: "Password",
                            hint: "Enter your Password",
                            controller: _passwordController,
                            obscureText: _passwordObscured,
                            validator: MultiValidator([
                              RequiredValidator(
                                  errorText: "Password is required"),
                              MinLengthValidator(8,
                                  errorText:
                                      "Password must be at least 8 characters"),
                            ]).call,
                            suffixIcon: IconButton(
                              icon: Icon(
                                _passwordObscured
                                    ? Icons.visibility_off_outlined
                                    : Icons.visibility_outlined,
                                color: Pallets.grey400,
                              ),
                              onPressed: () => setState(
                                  () => _passwordObscured = !_passwordObscured),
                            ),
                          ),

                          28.verticalSpace,

                          // OR divider
                          Row(
                            children: [
                              const Expanded(
                                  child: Divider(
                                      color: Pallets.grey90, thickness: 1)),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 16.w),
                                child: const TextView(
                                  text: "Or",
                                  fontSize: 14,
                                  color: Pallets.boldBlack,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const Expanded(
                                  child: Divider(
                                      color: Pallets.grey90, thickness: 1)),
                            ],
                          ),

                          20.verticalSpace,

                          // Google Button
                          CustomOutlinedButton(
                            onPressed: () =>
                                authBloc.add(const GoogleAuthEvent()),
                            borderColor: Pallets.grey90,
                            borderRadius: BorderRadius.circular(14.r),
                            padding: EdgeInsets.symmetric(vertical: 14.h),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset(Assets.images.svgs.googleAuth,
                                    height: 20.w),
                                12.horizontalSpace,
                                const TextView(
                                  text: "Continue with Google",
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Pallets.boldBlack,
                                ),
                              ],
                            ),
                          ),

                          // Apple only ever completes on iOS — same policy
                          // as IntroScreen, where this button is the one
                          // place OAuth is (was) actually wired up.
                          if (Platform.isIOS) ...[
                            12.verticalSpace,
                            CustomOutlinedButton(
                              onPressed: () =>
                                  authBloc.add(const AppleAuthEvent()),
                              borderColor: Pallets.grey90,
                              borderRadius: BorderRadius.circular(14.r),
                              padding: EdgeInsets.symmetric(vertical: 14.h),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(Assets.images.svgs.appleDark,
                                      height: 20.w),
                                  12.horizontalSpace,
                                  const TextView(
                                    text: "Continue with Apple",
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: Pallets.boldBlack,
                                  ),
                                ],
                              ),
                            ),
                          ],

                          20.verticalSpace,

                          // Create Account button
                          CustomButton(
                            onPressed: () => signUp(context),
                            bgColor: Pallets.blueBubbleColor,
                            borderRadius: BorderRadius.circular(14.r),
                            padding: EdgeInsets.symmetric(vertical: 14.h),
                            child: const TextView(
                              text: "Create Account",
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),

                          20.verticalSpace,

                          // Already have an account
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const TextView(
                                text: "Already have an account? ",
                                fontSize: 14,
                                color: Pallets.grey500,
                                fontWeight: FontWeight.w500,
                              ),
                              GestureDetector(
                                onTap: () => context.goNamed(PageUrl.login),
                                child: const TextView(
                                  text: "Sign In",
                                  fontSize: 14,
                                  color: Pallets.blueBubbleColor,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),

                          32.verticalSpace,
                        ],
                      ),
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

  void signUp(BuildContext context) {
    if (_formKey.currentState?.validate() ?? false) {
      authBloc.add(RegisterEvent(
        fullName: _fullNameController.text.trim(),
        email: _emailController.text.trim(),
        phoneNumber: _normalizedPhoneNumber(),
        username: _usernameController.text.trim(),
        password: _passwordController.text,
        countryId: _selectedCountry?.id,
        gender: _selectedGender,
        dateOfBirth: _selectedDob,
      ));
    }
  }

  /// E.164 (e.g. "+2348012345678") when the number resolves against the
  /// selected country, so the backend always gets an unambiguous value
  /// regardless of how the user typed it (with/without the leading 0,
  /// spaces, dashes, etc). Falls back to the raw typed text — which the
  /// validator has already confirmed is at least non-empty — if it can't
  /// be resolved (no country picked, or an unrecognized one).
  String _normalizedPhoneNumber() {
    final raw = _phoneController.text.trim();
    final isoCode = _isoCode;
    if (isoCode == null) return raw;

    try {
      final phone = PhoneNumber.parse(raw, callerCountry: isoCode);
      return phone.isValid() ? phone.international : raw;
    } catch (_) {
      return raw;
    }
  }

  void _listenToAuthBloc(BuildContext context, AuthState state) {
    if (state is AuthLoading || state is OauthLoadingState) {
      CustomDialogs.showLoading(context);
    }
    if (state is AuthFailure) {
      context.pop();
      CustomDialogs.error(state.error);
    }
    if (state is OauthFailureState) {
      context.pop();
      CustomDialogs.error(state.error);
    }
    if (state is RegisterSuccess) {
      context.pop();
      CustomDialogs.success("Signup successful.");
      context.pushNamed(PageUrl.verifyOtpScreen, queryParameters: {
        PathParam.email: _emailController.text.trim(),
        PathParam.otpType: VerifyOtpType.auth.name
      });
    }
    if (state is OauthSuccessState) {
      context.pop();
      // OAuth auto-creates the account server-side on first sign-in, so
      // this can land a brand-new user just as easily as a returning one —
      // resume wherever their onboarding actually is instead of assuming
      // "just registered".
      handleLoginSuccess(context, state.response.data.user);
    }
  }
}
