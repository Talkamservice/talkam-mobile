import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talkam/common/widgets/custom_appbar.dart';
import 'package:talkam/common/widgets/custom_button.dart';
import 'package:talkam/common/widgets/custom_text_field.dart';
import 'package:talkam/common/widgets/inline_select_field.dart';
import 'package:talkam/common/widgets/step_progress_bar.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/constants/package_exports.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/core/navigation/route_url.dart';
import 'package:talkam/core/theme/pallets.dart';
import 'package:talkam/features/profile/presentation/bloc/profile_bloc/profile_bloc.dart';
import 'package:talkam/features/therapist_application/presentation/bloc/therapist_application_bloc.dart';

const List<String> kCredentialTypes = [
  "Clinical Psychologist",
  "Licensed Counselor",
  "Psychiatrist",
  "Marriage & Family Therapist",
  "Licensed Clinical Social Worker",
];

/// Step 1 of 5 — Personal Information.
class TherapistPersonalInfoScreen extends StatefulWidget {
  const TherapistPersonalInfoScreen({super.key, required this.bloc});

  final TherapistApplicationBloc bloc;

  @override
  State<TherapistPersonalInfoScreen> createState() =>
      _TherapistPersonalInfoScreenState();
}

class _TherapistPersonalInfoScreenState
    extends State<TherapistPersonalInfoScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.bloc.state.personalInfo.fullName;
    _phoneController.text = widget.bloc.state.personalInfo.phone;

    // Prefill from the signed-in account so the therapist doesn't retype an
    // email we already have — matches the design's pre-filled field.
    final existingEmail = widget.bloc.state.personalInfo.email.isNotEmpty
        ? widget.bloc.state.personalInfo.email
        : injector.get<ProfileBloc>().appUser?.email ?? '';
    _emailController.text = existingEmail;
    if (existingEmail.isNotEmpty) {
      widget.bloc.add(UpdateEmailEvent(existingEmail));
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
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
      body: BlocBuilder<TherapistApplicationBloc, TherapistApplicationState>(
        bloc: widget.bloc,
        builder: (context, state) {
          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const StepProgressBar(
                  step: 1,
                  totalSteps: 5,
                  label: "Personal Information",
                ),
                20.verticalSpace,
                const TextView(
                  text: "Tell us about yourself",
                  fontSize: 26,
                  fontWeight: FontWeight.w800,
                  color: Pallets.boldBlackV2,
                ),
                24.verticalSpace,
                CustomTextField(
                  label: "Full Name",
                  hint: "Enter your name",
                  controller: _nameController,
                  onChanged: (v) => widget.bloc.add(UpdateFullNameEvent(v)),
                ),
                16.verticalSpace,
                CustomTextField(
                  label: "Email address",
                  hint: "Enter your Email Address",
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (v) => widget.bloc.add(UpdateEmailEvent(v)),
                ),
                16.verticalSpace,
                CustomTextField(
                  label: "Phone Number",
                  hint: "Enter your number",
                  controller: _phoneController,
                  keyboardType: TextInputType.phone,
                  onChanged: (v) => widget.bloc.add(UpdatePhoneEvent(v)),
                ),
                16.verticalSpace,
                InlineSelectField<String>(
                  label: "Credential type",
                  hint: "Clinical Psychologist",
                  options: kCredentialTypes,
                  labelBuilder: (v) => v,
                  value: state.personalInfo.credentialType,
                  onSingleChanged: (v) =>
                      widget.bloc.add(UpdateCredentialTypeEvent(v)),
                ),
                40.verticalSpace,
                CustomButton(
                  elevation: 0,
                  onPressed: state.personalInfo.isValid
                      ? () => context.pushNamed(
                            PageUrl.therapistQualificationsScreen,
                            extra: widget.bloc,
                          )
                      : null,
                  bgColor: Pallets.blueBubbleColor,
                  child: const TextView(
                    text: "Save and Continue",
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                24.verticalSpace,
              ],
            ),
          );
        },
      ),
    );
  }
}
