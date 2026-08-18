import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talkam/common/widgets/custom_appbar.dart';
import 'package:talkam/common/widgets/custom_button.dart';
import 'package:talkam/common/widgets/custom_dialogs.dart';
import 'package:talkam/common/widgets/custom_text_field.dart';
import 'package:talkam/common/widgets/inline_select_field.dart';
import 'package:talkam/common/widgets/step_progress_bar.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/constants/package_exports.dart';
import 'package:talkam/core/navigation/route_url.dart';
import 'package:talkam/core/theme/pallets.dart';
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
  final _yearsController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _yearsController.text = widget.bloc.state.personalInfo.yearsExperience;
  }

  @override
  void dispose() {
    _yearsController.dispose();
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
      body: BlocConsumer<TherapistApplicationBloc, TherapistApplicationState>(
        bloc: widget.bloc,
        listener: (context, state) {
          if (state.personalSaveStatus == StepSaveStatus.saving) {
            CustomDialogs.showLoading(context);
          }
          if (state.personalSaveStatus == StepSaveStatus.success) {
            context.pop();
            widget.bloc.add(const ResetSaveStatusesEvent());
            context.pushNamed(
              PageUrl.therapistQualificationsScreen,
              extra: widget.bloc,
            );
          }
          if (state.personalSaveStatus == StepSaveStatus.error) {
            context.pop();
            CustomDialogs.error(
                state.personalSaveError ?? "Something went wrong");
          }
        },
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
                InlineSelectField<String>(
                  label: "Credential type",
                  hint: "Clinical Psychologist",
                  options: kCredentialTypes,
                  labelBuilder: (v) => v,
                  value: state.personalInfo.credentialType,
                  onSingleChanged: (v) =>
                      widget.bloc.add(UpdateCredentialTypeEvent(v)),
                ),
                16.verticalSpace,
                CustomTextField(
                  label: "Years of experience",
                  hint: "Enter your years of experience",
                  controller: _yearsController,
                  keyboardType: TextInputType.number,
                  onChanged: (v) =>
                      widget.bloc.add(UpdateYearsExperienceEvent(v)),
                ),
                40.verticalSpace,
                CustomButton(
                  elevation: 0,
                  onPressed: state.personalInfo.isValid
                      ? () => widget.bloc.add(const SavePersonalInfoEvent())
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
