import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:image/image.dart';
import 'package:talkam/common/models/get_countries_response.dart';
import 'package:talkam/common/models/get_states_response.dart';
import 'package:talkam/common/widgets/country_state_picker.dart';
import 'package:talkam/common/widgets/custom_button.dart';
import 'package:talkam/common/widgets/custom_dialogs.dart';
import 'package:talkam/common/widgets/dropdown_field_form.dart';
import 'package:talkam/common/widgets/image_widget.dart';
import 'package:talkam/common/widgets/outlined_form_field.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/constants/package_exports.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/core/navigation/route_url.dart';
import 'package:talkam/core/services/data/session_manager.dart';
import 'package:talkam/core/theme/pallets.dart';
import 'package:talkam/core/utils/extensions/context_extension.dart';
import 'package:talkam/core/utils/time_util.dart';
import 'package:talkam/core/utils/validators.dart';
import 'package:talkam/features/profile/data/models/update_profile_payload.dart';
import 'package:talkam/features/profile/presentation/bloc/profile_bloc/profile_bloc.dart';
import 'package:talkam/features/profile/presentation/widgets/select_avater_sheet.dart';
import 'package:talkam/gen/assets.gen.dart';

class UsernameScreen extends StatefulWidget {
  const UsernameScreen({
    super.key,
  });

  @override
  State<UsernameScreen> createState() => _UsernameScreenState();
}

class _UsernameScreenState extends State<UsernameScreen> {
  final TextEditingController usernameController = TextEditingController();
  bool passwordObscured = true;
  final formkey = GlobalKey<FormState>();
  final profileBloc = ProfileBloc(injector.get());
  var selectedImage;
  TalkamCountry? _country;
  TalkamState? _state;
  DateTime? dob;

  var gender;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      29.verticalSpace,
                      const Center(
                        child: TextView(
                          text: 'Profile',
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                        ),
                      ),
                      4.verticalSpace,
                      const Center(
                        child: TextView(
                          text: "Set how you’ll appear to other users",
                        ),
                      ),
                      16.verticalSpace,
                      Center(child: ImageWidget(size: 100, shape: BoxShape.circle, imageUrl: selectedImage ?? Assets.images.svgs.user)),
                      5.verticalSpace,
                      Center(
                        child: TextButton(
                            style: TextButton.styleFrom(
                                // padding: EdgeInsets.all(),
                                foregroundColor: context.colorScheme.onSurface,
                                shape: const StadiumBorder(side: BorderSide(color: Pallets.borderGrey))),
                            onPressed: () {
                              selectImage(context);
                            },
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                ImageWidget(imageUrl: Assets.images.svgs.uploadAvatar),
                                5.horizontalSpace,
                                const TextView(text: "Set avatar"),
                              ],
                            )),
                      ),
                      25.verticalSpace,
                      OutlinedFormField(
                        placeHolder: "Username",
                        hint: "Use a unique username",
                        controller: usernameController,
                        validator:
                            MultiValidator([RequiredValidator(errorText: "Field is required"), SpaceValidator(errorText: "Username must not contain space")])
                                .call,
                      ),
                      20.verticalSpace,
                      TextView(
                        text: "Date of birth",
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w600,
                      ),
                      8.verticalSpace,
                      TextButton(
                          style: TextButton.styleFrom(
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                              foregroundColor: Pallets.grey,
                              padding: const EdgeInsets.all(16),
                              side: const BorderSide(
                                color: Pallets.borderGrey,
                                width: 0.7,
                              )),
                          onPressed: () async {
                            dob = await selectDate(context);
                            setState(() {});
                            // pickDateAndTime(context);
                          },
                          child: Row(
                            children: [
                              Expanded(
                                  child: TextView(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      text: dob != null ? TimeUtil.formatDate(dob!.toIso8601String()) : "Date of birth")),
                              const Icon(Icons.keyboard_arrow_right)
                            ],
                          )),
                      20.verticalSpace,
                      CustomDropdownFieldButton<String>(
                          label: "Gender",
                          hint: "Male / Female",
                          value: gender,
                          onChanged: (p0) {
                            gender = p0!;
                            setState(() {});
                          },
                          items: const [
                            DropdownMenuItem<String>(
                              value: "Male",
                              child: TextView(
                                text: "Male",
                              ),
                            ),
                            DropdownMenuItem<String>(
                              value: "Female",
                              child: TextView(
                                text: "Female",
                              ),
                            ),
                            DropdownMenuItem<String>(
                              value: "Others",
                              child: TextView(
                                text: "Others",
                              ),
                            ),
                            DropdownMenuItem<String>(
                              value: "Choose not to specify",
                              child: TextView(
                                text: "Choose not to specify",
                              ),
                            ),
                          ]),
                      20.verticalSpace,
                      TalkamCountryStatePicker(
                        country: _country,
                        state: _state,
                        onChanged: (TalkamCountry? country, TalkamState? state) {
                          _country = country;
                          _state = state;
                        },
                      ),
                      38.verticalSpace,
                      CustomButton(
                        child: const TextView(
                          text: "Save and Continue",
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                        ),
                        onPressed: () {
                          if (formkey.currentState?.validate() ?? false) {
                            profileBloc.add(UpdateProfileEvent(UpdateProfilePayload(
                                dob: dob,
                                gender: gender,
                                countryId: _country?.id.toString(),
                                stateId: _state?.id.toString(),
                                avatar: selectedImage,
                                username: usernameController.text.trim())));
                          }
                        },
                      )
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

  Future<DateTime?> selectDate(BuildContext context) async {
    final now = DateTime.now();
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: DateTime(now.year - 200),
      lastDate: DateTime(now.year + 5),
    );
    if (pickedDate != null && pickedDate != now) {
      return pickedDate;
    } else {
      return null; // User canceled or did not select
    }
  }

  Future<void> selectImage(BuildContext context) async {
    selectedImage = await CustomDialogs.showBottomSheet(
        context,
        SelectAvatarSheet(
          onAvatarSelected: (p0) {},
          onBackgroundSelector: (p0) {},
        ));
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
      SessionManager().hasOnboarded = true;
      context.pop();
      CustomDialogs.success("Profile updated");
      context.goNamed(PageUrl.homeScreen);
    }
  }
}
