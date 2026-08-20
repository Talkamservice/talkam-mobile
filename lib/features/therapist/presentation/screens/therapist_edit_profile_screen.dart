import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:talkam/common/widgets/custom_appbar.dart';
import 'package:talkam/common/widgets/custom_button.dart';
import 'package:talkam/common/widgets/custom_dialogs.dart';
import 'package:talkam/common/widgets/custom_text_field.dart';
import 'package:talkam/common/widgets/edit_avatar.dart';
import 'package:talkam/common/widgets/image_widget.dart';
import 'package:talkam/common/widgets/inline_select_field.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/constants/package_exports.dart';
import 'package:talkam/core/theme/pallets.dart';
import 'package:talkam/core/utils/string_extension.dart';
import 'package:talkam/features/authentication/presentation/screens/therapist/therapist_specialties_screen.dart'
    show kSpecialtyOptions;
import 'package:talkam/features/therapist/data/models/availability_slot.dart';
import 'package:talkam/features/therapist/data/models/therapist_editable_profile.dart';
import 'package:talkam/features/therapist/presentation/bloc/therapist_profile_edit/therapist_profile_edit_bloc.dart';
import 'package:talkam/features/therapist/presentation/widgets/availability_section.dart';
import 'package:talkam/features/therapist/presentation/widgets/availability_slot_sheet.dart';
import 'package:talkam/features/therapist/presentation/widgets/session_rate_field.dart';

final List<int> _yearsOfExperienceOptions = [
  for (var y = kMinYearsExperience; y <= kMaxYearsExperience; y++) y,
];

/// The signed-in therapist's Edit Profile screen.
///
/// Distinct from the member `EditProfileScreen`, which has no experience,
/// availability or rate fields — the therapist settings tile used to point
/// there despite promising "Edit name, experience, and bio".
class TherapistEditProfileScreen extends StatefulWidget {
  const TherapistEditProfileScreen({super.key});

  @override
  State<TherapistEditProfileScreen> createState() =>
      _TherapistEditProfileScreenState();
}

class _TherapistEditProfileScreenState
    extends State<TherapistEditProfileScreen> {
  // Screen-scoped: a GetIt singleton would leak this draft into the next open.
  final TherapistProfileEditBloc _bloc = TherapistProfileEditBloc();

  final _nameController = TextEditingController();
  final _titleController = TextEditingController();
  final _bioController = TextEditingController();
  final _rateController = TextEditingController();

  @override
  void initState() {
    super.initState();

    // Seeded once from the bloc's synchronously-loaded draft and never
    // re-synced from state — rewriting a controller mid-edit jumps the caret.
    final draft = _bloc.state.draft;
    _nameController.text = draft.fullName;
    _titleController.text = draft.title;
    _bioController.text = draft.bio;
    _rateController.text =
        draft.sessionRate.isEmpty ? '' : draft.sessionRate.formatNumber();

    // The bio counter is the only field whose UI depends on its own text.
    _bioController.addListener(_onBioChanged);
  }

  void _onBioChanged() => setState(() {});

  @override
  void dispose() {
    _bioController.removeListener(_onBioChanged);
    _nameController.dispose();
    _titleController.dispose();
    _bioController.dispose();
    _rateController.dispose();
    _bloc.close();
    super.dispose();
  }

  /// Therapists need a real photo of themselves, not one of the preset
  /// avatars the member Edit Profile screen offers — so this picks straight
  /// from the device gallery rather than showing [SelectAvatarSheet].
  Future<void> _changePhoto() async {
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picked == null) return;
    if (!mounted) return;
    _bloc.add(SetPendingAvatarEvent(picked.path));
  }

  Future<void> _addSlot(WeeklyAvailability availability) async {
    final slot = await AvailabilitySlotSheet.show(
      context,
      availability: availability,
    );
    if (slot != null) _bloc.add(UpsertAvailabilitySlotEvent(slot));
  }

  Future<void> _editSlot(
    WeeklyAvailability availability,
    AvailabilitySlot slot,
  ) async {
    final updated = await AvailabilitySlotSheet.show(
      context,
      availability: availability,
      editing: slot,
    );
    if (updated != null) _bloc.add(UpsertAvailabilitySlotEvent(updated));
  }

  /// Confirms before throwing away unsaved edits.
  ///
  /// Routed through PopScope rather than WillPopScope because the iOS
  /// edge-swipe bypasses the latter; PopScope is honoured by both that and
  /// Android predictive back. `Navigator.pop` is imperative and does not
  /// re-consult PopScope, so the confirm path can leave cleanly.
  void _confirmDiscard() {
    if (!_bloc.state.hasChanges) {
      Navigator.of(context).pop();
      return;
    }
    CustomDialogs.showConfirmDialog(
      context,
      tittle: "Discard changes?",
      message: "Your unsaved edits will be lost.",
      confirmButtonBgColor: Pallets.errorRed,
      onYes: () {
        Navigator.of(context).pop(); // the dialog
        Navigator.of(context).pop(); // the screen
      },
      onCancel: () => Navigator.of(context).pop(),
    );
  }

  void _onStateChanged(BuildContext context, TherapistProfileEditState state) {
    switch (state.status) {
      case TherapistProfileEditStatus.saved:
        CustomDialogs.success("Profile updated");
        Navigator.of(context).pop();
      case TherapistProfileEditStatus.failure:
        CustomDialogs.error(state.errorMessage ?? "Something went wrong.");
      case _:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TherapistProfileEditBloc, TherapistProfileEditState>(
      bloc: _bloc,
      listener: _onStateChanged,
      builder: (context, state) {
        final draft = state.draft;
        final saving = state.status == TherapistProfileEditStatus.saving;

        return PopScope(
          // Only intercept when there is something to lose — a clean form
          // should just close.
          canPop: !state.hasChanges,
          onPopInvokedWithResult: (didPop, _) {
            if (didPop) return;
            _confirmDiscard();
          },
          child: Scaffold(
            backgroundColor: Colors.white,
            appBar: CustomAppBar(
              tittleText: "Edit Profile",
              centerTile: false,
              onBackPressed: _confirmDiscard,
            ),
            body: SafeArea(
              // iOS number keypads have no Done key, so give the user two ways
              // out: drag the list, or tap anywhere off the field.
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () => FocusScope.of(context).unfocus(),
                child: SingleChildScrollView(
                  keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.onDrag,
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      24.verticalSpace,
                      EditAvatar(
                        imageUrl: draft.pendingAvatarPath ?? draft.avatarUrl,
                        imageType: draft.pendingAvatarPath != null
                            ? ImageWidgetType.file
                            : ImageWidgetType.network,
                        onTap: _changePhoto,
                      ),
                      28.verticalSpace,
                      CustomTextField(
                        label: "Full Name",
                        hint: "Dr. Adewale Kehinde",
                        controller: _nameController,
                        textInputAction: TextInputAction.next,
                        forceError:
                            state.saveAttempted && !draft.isFullNameValid,
                        onChanged: (v) => _bloc.add(SetFullNameEvent(v)),
                      ),
                      16.verticalSpace,
                      CustomTextField(
                        label: "Title/Credential",
                        hint: "Clinical Psychologist - PhD",
                        controller: _titleController,
                        textInputAction: TextInputAction.next,
                        forceError: state.saveAttempted && !draft.isTitleValid,
                        onChanged: (v) => _bloc.add(SetTitleEvent(v)),
                      ),
                      16.verticalSpace,
                      InlineSelectField<int>(
                        label: "Years of Experience",
                        hint: "Select years",
                        options: _yearsOfExperienceOptions,
                        labelBuilder: (y) => y == 1 ? "1 year" : "$y years",
                        value: draft.yearsExperience,
                        onSingleChanged: (v) =>
                            _bloc.add(SetYearsExperienceEvent(v)),
                      ),
                      24.verticalSpace,
                      AvailabilitySection(
                        availability: draft.availability,
                        showRequiredError:
                            state.saveAttempted && !draft.hasAvailability,
                        onAdd: () => _addSlot(draft.availability),
                        onEdit: (slot) => _editSlot(draft.availability, slot),
                        onRemove: (slot) =>
                            _bloc.add(RemoveAvailabilitySlotEvent(slot.id)),
                      ),
                      24.verticalSpace,
                      InlineSelectField<String>(
                        label: "Specialties",
                        hint: "Select your specialties",
                        options: kSpecialtyOptions,
                        labelBuilder: (s) => s,
                        multiple: true,
                        values: draft.specialties,
                        onMultipleChanged: (v) =>
                            _bloc.add(SetSpecialtiesEvent(v)),
                      ),
                      if (state.saveAttempted && !draft.hasSpecialties) ...[
                        6.verticalSpace,
                        TextView(
                          text: "Pick at least one specialty.",
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Pallets.errorRed,
                        ),
                      ],
                      24.verticalSpace,
                      _BioField(
                        controller: _bioController,
                        showError: state.saveAttempted && !draft.isBioValid,
                        onChanged: (v) => _bloc.add(SetBioEvent(v)),
                      ),
                      24.verticalSpace,
                      SessionRateField(
                        controller: _rateController,
                        rate: draft.rate,
                        sessionDurationMinutes: draft.sessionDurationMinutes,
                        showError: state.saveAttempted,
                        onChanged: (digits) =>
                            _bloc.add(SetSessionRateEvent(digits)),
                      ),
                      32.verticalSpace,
                      CustomButton(
                        elevation: 0,
                        // CustomButton's disabled styling is broken
                        // (withAlpha(-200)); every V2 screen swaps bgColor.
                        bgColor: state.hasChanges && !saving
                            ? Pallets.blueBubbleColor
                            : Pallets.lightBlue,
                        onPressed: state.hasChanges && !saving
                            ? () => _bloc.add(const SaveTherapistProfileEvent())
                            : null,
                        child: TextView(
                          text: saving ? "Saving..." : "Save Changes",
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                      32.verticalSpace,
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

/// Multiline bio with a live character counter.
///
/// `CustomTextField` has no maxLength/counter of its own, so the limit is
/// enforced by a formatter and the count drawn alongside the label — the same
/// approach the member Edit Profile screen takes.
class _BioField extends StatelessWidget {
  const _BioField({
    required this.controller,
    required this.onChanged,
    required this.showError,
  });

  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  final bool showError;

  @override
  Widget build(BuildContext context) {
    final used = controller.text.length;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomTextField(
          label: "Bio",
          hint: "Finding my way through life, one day at a time.",
          controller: controller,
          maxLines: 5,
          minLines: 5,
          forceError: showError,
          inputFormatters: [LengthLimitingTextInputFormatter(kBioMaxLength)],
          onChanged: onChanged,
        ),
        6.verticalSpace,
        Align(
          alignment: Alignment.centerRight,
          child: TextView(
            text: "$used/$kBioMaxLength",
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: showError ? Pallets.errorRed : Pallets.grey400,
          ),
        ),
      ],
    );
  }
}
