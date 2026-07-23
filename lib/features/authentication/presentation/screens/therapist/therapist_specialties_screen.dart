import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talkam/common/widgets/custom_appbar.dart';
import 'package:talkam/common/widgets/custom_button.dart';
import 'package:talkam/common/widgets/custom_text_field.dart';
import 'package:talkam/common/widgets/inline_select_field.dart';
import 'package:talkam/common/widgets/step_progress_bar.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/constants/package_exports.dart';
import 'package:talkam/core/navigation/route_url.dart';
import 'package:talkam/core/theme/pallets.dart';
import 'package:talkam/features/therapist_application/presentation/bloc/therapist_application_bloc.dart';

const List<String> kSpecialtyOptions = [
  "Depression",
  "Trauma & PTSD",
  "Grief",
  "Bipolar",
  "Anxiety",
  "Addiction",
  "Relationships",
  "ADHD",
];

/// Step 3 of 5 — Specialties.
class TherapistSpecialtiesScreen extends StatefulWidget {
  const TherapistSpecialtiesScreen({super.key, required this.bloc});

  final TherapistApplicationBloc bloc;

  @override
  State<TherapistSpecialtiesScreen> createState() =>
      _TherapistSpecialtiesScreenState();
}

class _TherapistSpecialtiesScreenState
    extends State<TherapistSpecialtiesScreen> {
  final _bioController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _bioController.text = widget.bloc.state.specialties.bio;
  }

  @override
  void dispose() {
    _bioController.dispose();
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
                  step: 3,
                  totalSteps: 5,
                  label: "Specialties",
                ),
                20.verticalSpace,
                const TextView(
                  text: "Specialties",
                  fontSize: 26,
                  fontWeight: FontWeight.w800,
                  color: Pallets.boldBlackV2,
                ),
                8.verticalSpace,
                const TextView(
                  text: "Clients find you by these. Select all that apply.",
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Pallets.grey400,
                ),
                24.verticalSpace,
                const TextView(
                  text: "YOUR BIO (Shown on profile)",
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: Pallets.grey400,
                ),
                8.verticalSpace,
                CustomTextField(
                  hint: "Describe your self",
                  controller: _bioController,
                  maxLines: 5,
                  minLines: 4,
                  onChanged: (v) => widget.bloc.add(UpdateBioEvent(v)),
                ),
                20.verticalSpace,
                const TextView(
                  text: "Add your specialties",
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Pallets.boldBlackV2,
                ),
                8.verticalSpace,
                InlineSelectField<String>(
                  hint: "Specialties",
                  options: kSpecialtyOptions,
                  labelBuilder: (v) => v,
                  multiple: true,
                  values: state.specialties.specialties,
                  onMultipleChanged: (values) {
                    // Diff against current selection and dispatch per change
                    // so the bloc's toggle event stays the single source of
                    // truth for add/remove logic.
                    final current = state.specialties.specialties;
                    final added = values.where((v) => !current.contains(v));
                    final removed = current.where((v) => !values.contains(v));
                    for (final v in [...added, ...removed]) {
                      widget.bloc.add(ToggleSpecialtyEvent(v));
                    }
                  },
                ),
                40.verticalSpace,
                CustomButton(
                  elevation: 0,
                  onPressed: state.specialties.isValid
                      ? () => context.pushNamed(
                            PageUrl.therapistAvailabilityScreen,
                            extra: widget.bloc,
                          )
                      : null,
                  bgColor: Pallets.blueBubbleColor,
                  child: const TextView(
                    text: "Continue",
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
