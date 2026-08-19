import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:phone_numbers_parser/phone_numbers_parser.dart';
import 'package:talkam/common/widgets/custom_appbar.dart';
import 'package:talkam/common/widgets/custom_button.dart';
import 'package:talkam/common/widgets/custom_dialogs.dart';
import 'package:talkam/common/widgets/edit_avatar.dart';
import 'package:talkam/common/widgets/outlined_form_field.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/constants/package_exports.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/core/theme/pallets.dart';
import 'package:talkam/features/post/dormain/mixins/refresh_posts_mixin.dart';
import 'package:talkam/features/profile/data/models/update_profile_payload.dart';
import 'package:talkam/features/profile/presentation/bloc/profile_bloc/profile_bloc.dart';
import 'package:talkam/features/profile/presentation/widgets/select_avater_sheet.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({
    super.key,
  });

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen>
    with RefreshPostsMixin {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController bioController = TextEditingController();

  final formkey = GlobalKey<FormState>();
  final profileBloc = injector.get<ProfileBloc>();

  var selectedImage;
  String? _email;

  /// Snapshot of the initial values so Save only enables once something
  /// actually changes (mirrors the enabled/disabled mockup variants).
  late String _initialName;
  late String _initialPhone;
  late String _initialBio;
  late dynamic _initialImage;

  static const int _bioMaxLength = 300;

  @override
  void initState() {
    super.initState();
    final user = profileBloc.appUser;
    selectedImage = user?.avatar;
    nameController.text = user?.name ?? '';
    _email = user?.email;

    _initialName = nameController.text;
    _initialPhone = phoneController.text;
    _initialBio = bioController.text;
    _initialImage = selectedImage;

    nameController.addListener(_onChanged);
    phoneController.addListener(_onChanged);
    bioController.addListener(_onChanged);
    setState(() {});
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    bioController.dispose();
    super.dispose();
  }

  void _onChanged() => setState(() {});

  /// Optional field (starts blank, not yet wired to the backend) — only
  /// validate format once the user actually types something.
  String? _validatePhone(String? value) {
    final raw = value?.trim() ?? '';
    if (raw.isEmpty) return null;

    try {
      final phone = PhoneNumber.parse(raw);
      if (!phone.isValid()) {
        return "Enter a valid phone number";
      }
    } catch (_) {
      return "Enter a valid phone number";
    }
    return null;
  }

  bool get _hasChanges =>
      nameController.text != _initialName ||
      phoneController.text != _initialPhone ||
      bioController.text != _initialBio ||
      selectedImage != _initialImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(
        padding: EdgeInsets.all(0.0),
        tittleText: "Edit Profile",
        centerTile: false,
        actions: [],
      ),
      body: BlocConsumer<ProfileBloc, ProfileState>(
        bloc: profileBloc,
        listener: _listenToProfileBloc,
        builder: (context, state) {
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Form(
                key: formkey,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      24.verticalSpace,

                      // ── Avatar + Change Photo ─────────────────────────
                      EditAvatar(
                        imageUrl: selectedImage,
                        onTap: () => selectImage(context),
                      ),

                      28.verticalSpace,

                      // ── Full Name ─────────────────────────────────────
                      OutlinedFormField(
                        placeHolder: "Full Name",
                        hint: "Enter your name",
                        controller: nameController,
                        validator: MultiValidator([
                          RequiredValidator(errorText: "Field is required"),
                        ]).call,
                        suffix: const Icon(
                          Icons.remove_red_eye_outlined,
                          color: Pallets.grey75,
                        ),
                      ),
                      16.verticalSpace,

                      // ── Email (read-only) ─────────────────────────────
                      OutlinedFormField(
                        placeHolder: "Email Address",
                        hint: _email ?? "Email Address",
                        enabled: false,
                        filled: true,
                        fillColor: Pallets.bgLight,
                      ),
                      16.verticalSpace,

                      // ── Phone Number ──────────────────────────────────
                      // NOTE: the user model / update payload has no phone
                      // field yet, so this is UI-only until the backend adds
                      // support. Wire into the payload once available.
                      OutlinedFormField(
                        placeHolder: "Phone Number",
                        hint: "+234 801 234 5678",
                        controller: phoneController,
                        inputType: TextInputType.phone,
                        validator: _validatePhone,
                        suffix: const Icon(
                          Icons.remove_red_eye_outlined,
                          color: Pallets.grey75,
                        ),
                      ),
                      16.verticalSpace,

                      // ── Bio ───────────────────────────────────────────
                      // NOTE: also UI-only until the backend exposes a bio
                      // field on the profile update payload.
                      OutlinedFormField(
                        placeHolder: "Bio",
                        hint: "Finding my way through life, one day at a time.",
                        controller: bioController,
                        maxLine: 5,
                        minLine: 5,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(_bioMaxLength),
                        ],
                      ),
                      6.verticalSpace,
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextView(
                          text: "${bioController.text.length}/$_bioMaxLength",
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: Pallets.grey400,
                        ),
                      ),

                      32.verticalSpace,

                      // ── Save ──────────────────────────────────────────
                      CustomButton(
                        elevation: 0,
                        bgColor: _hasChanges
                            ? Pallets.blueBubbleColor
                            : Pallets.lightBlue,
                        onPressed: _hasChanges ? _onSave : null,
                        child: const TextView(
                          text: "Save Changes",
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
        },
      ),
    );
  }

  void _onSave() {
    if (formkey.currentState?.validate() ?? false) {
      profileBloc.add(
        UpdateProfileEvent(
          UpdateProfilePayload(
            avatar: selectedImage,
            name: nameController.text.trim(),
          ),
        ),
      );
    }
  }

  Future<void> selectImage(BuildContext context) async {
    var image = await CustomDialogs.showBottomSheet(
        context,
        SelectAvatarSheet(
          onAvatarSelected: (p0) {},
          onBackgroundSelector: (p0) {},
        ));
    if (image != null) {
      selectedImage = image;
    }
    setState(() {});
  }

  void _listenToProfileBloc(BuildContext context, ProfileState state) {
    if (state is UpdateProfileLoading) {
      CustomDialogs.showLoading(context);
    }
    if (state is UpdateProfileFailure) {
      context.pop();
      CustomDialogs.error(state.error);
    }
    if (state is UpdateProfileSuccess) {
      refreshPost(reload: false);
      CustomDialogs.success("Profile updated");
      context.pop();
      context.pop();
    }
  }
}
