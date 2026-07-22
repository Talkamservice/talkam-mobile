import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:go_router/go_router.dart';
import 'package:talkam/common/widgets/custom_appbar.dart';
import 'package:talkam/common/widgets/custom_button.dart';
import 'package:talkam/common/widgets/custom_dialogs.dart';
import 'package:talkam/common/widgets/custom_dropdown.dart';
import 'package:talkam/common/widgets/custom_outlined_button.dart';
import 'package:talkam/common/widgets/custom_text_field.dart';
import 'package:talkam/common/widgets/date_picker_field.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/core/navigation/path_params.dart';
import 'package:talkam/core/navigation/route_url.dart';
import 'package:talkam/core/theme/pallets.dart';
import 'package:talkam/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:talkam/features/authentication/presentation/screens/verify_otp_screen.dart';
import 'package:talkam/gen/assets.gen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final authBloc = AuthBloc(injector.get());

  bool _passwordObscured = true;
  String? _selectedCountry;
  String? _selectedGender;
  DateTime? _selectedDob;
  final _scrollController = ScrollController();
  double _scrollOffset = 0;

  static const List<String> _countries = [
    'Nigeria',
    'Ghana',
    'Kenya',
    'South Africa',
    'United States',
    'United Kingdom',
    'Canada',
    'Australia',
  ];

  static const List<String> _genders = [
    'Male',
    'Female',
    'Non-binary',
  ];

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      setState(() => _scrollOffset = _scrollController.offset);
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
    super.dispose();
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
                            keyboardType: TextInputType.phone,
                            validator: RequiredValidator(
                                    errorText: "Phone number is required")
                                .call,
                          ),

                          16.verticalSpace,

                          // Username
                          CustomTextField(
                            label: "Username",
                            hint: "Use a unique name",
                            controller: _usernameController,
                            validator: MultiValidator([
                              RequiredValidator(
                                  errorText: "Username is required"),
                              MinLengthValidator(3,
                                  errorText:
                                      "Username must be at least 3 characters"),
                            ]).call,
                          ),

                          16.verticalSpace,

                          // Country
                          CustomDropdown<String>(
                            label: "Country",
                            hint: "Select your country",
                            value: _selectedCountry,
                            items: _countries
                                .map((c) =>
                                    DropdownMenuItem(value: c, child: Text(c)))
                                .toList(),
                            onChanged: (val) =>
                                setState(() => _selectedCountry = val),
                            validator: (val) =>
                                val == null ? "Please select a country" : null,
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
                          CustomDropdown<String>(
                            label: "Gender",
                            hint: "Select gender",
                            value: _selectedGender,
                            items: _genders
                                .map((g) =>
                                    DropdownMenuItem(value: g, child: Text(g)))
                                .toList(),
                            onChanged: (val) =>
                                setState(() => _selectedGender = val),
                            validator: (val) =>
                                val == null ? "Please select a gender" : null,
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
                            onPressed: () {},
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

                          12.verticalSpace,

                          // Apple Button
                          CustomOutlinedButton(
                            onPressed: () {},
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
          email: _emailController.text, password: _passwordController.text));
    }
  }

  void _listenToAuthBloc(BuildContext context, AuthState state) {
    if (state is AuthLoading) {
      CustomDialogs.showLoading(context);
    }
    if (state is AuthFailure) {
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
  }
}
