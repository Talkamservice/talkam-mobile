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
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/core/navigation/route_url.dart';
import 'package:talkam/core/theme/pallets.dart';
import 'package:talkam/features/post/data/models/get_categories_response.dart';
import 'package:talkam/features/post/presentation/bloc/post/post_bloc.dart';
import 'package:talkam/features/therapist_application/presentation/bloc/therapist_application_bloc.dart';

/// Still used by [TherapistEditProfileScreen]'s post-onboarding specialties
/// picker, which hasn't migrated to real interest-topic ids yet — this step
/// itself now sources specialties from `GET /user/interest-topics` below.
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
  final _postBloc = PostBloc(injector.get());

  @override
  void initState() {
    super.initState();
    _bioController.text = widget.bloc.state.specialties.bio;
    _postBloc.add(const PostEvent.getInterestTopics());
  }

  @override
  void dispose() {
    _bioController.dispose();
    _postBloc.close();
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
          if (state.specialtiesSaveStatus == StepSaveStatus.saving) {
            CustomDialogs.showLoading(context);
          }
          if (state.specialtiesSaveStatus == StepSaveStatus.success) {
            context.pop();
            widget.bloc.add(const ResetSaveStatusesEvent());
            context.pushNamed(
              PageUrl.therapistAvailabilityScreen,
              extra: widget.bloc,
            );
          }
          if (state.specialtiesSaveStatus == StepSaveStatus.error) {
            context.pop();
            CustomDialogs.error(
                state.specialtiesSaveError ?? "Something went wrong");
          }
        },
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
                BlocBuilder<PostBloc, PostState>(
                  bloc: _postBloc,
                  builder: (context, postState) {
                    final categories = postState.maybeWhen(
                      orElse: () => const <PostCategory>[],
                      getInterestTopicsSuccess: (response) => response.data,
                    );

                    final isLoading = postState.maybeWhen(
                      orElse: () => false,
                      getInterestTopicsLoading: () => true,
                    );
                    if (isLoading) {
                      return Center(child: CustomDialogs.getLoading(size: 32));
                    }

                    final ids = categories
                        .map((c) => int.parse(c.id.toString()))
                        .toList();
                    String labelFor(int id) => categories
                        .firstWhere((c) => int.parse(c.id.toString()) == id)
                        .name
                        .toString();

                    return InlineSelectField<int>(
                      hint: "Specialties",
                      options: ids,
                      labelBuilder: labelFor,
                      multiple: true,
                      values: state.specialties.specialties,
                      onMultipleChanged: (values) {
                        // Diff against current selection and dispatch per
                        // change so the bloc's toggle event stays the single
                        // source of truth for add/remove logic.
                        final current = state.specialties.specialties;
                        final added = values.where((v) => !current.contains(v));
                        final removed =
                            current.where((v) => !values.contains(v));
                        for (final v in [...added, ...removed]) {
                          widget.bloc.add(ToggleSpecialtyEvent(v));
                        }
                      },
                    );
                  },
                ),
                40.verticalSpace,
                CustomButton(
                  elevation: 0,
                  onPressed: state.specialties.isValid
                      ? () => widget.bloc.add(const SaveSpecialtiesEvent())
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
