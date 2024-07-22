import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:talkam/common/widgets/custom_button.dart';
import 'package:talkam/common/widgets/custom_dialogs.dart';
import 'package:talkam/common/widgets/image_widget.dart';
import 'package:talkam/common/widgets/outlined_form_field.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/constants/package_exports.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/core/navigation/route_url.dart';
import 'package:talkam/core/theme/pallets.dart';
import 'package:talkam/core/utils/extensions/context_extension.dart';
import 'package:talkam/features/profile/data/models/update_profile_payload.dart';
import 'package:talkam/features/profile/presentation/bloc/profile_bloc/profile_bloc.dart';
import 'package:talkam/features/profile/presentation/widgets/select_avater_sheet.dart';
import 'package:talkam/gen/assets.gen.dart';

class UsernameScreen extends StatefulWidget {
  const UsernameScreen({super.key});

  @override
  State<UsernameScreen> createState() => _UsernameScreenState();
}

class _UsernameScreenState extends State<UsernameScreen> {
  final TextEditingController usernameController = TextEditingController();
  bool passwordObscured = true;
  final formkey = GlobalKey<FormState>();
  final profileBloc = ProfileBloc(injector.get());
  var selectedImage;

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
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      29.verticalSpace,
                      const TextView(
                        text: 'Profile',
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                      ),
                      4.verticalSpace,
                      const TextView(
                        text: "Set how you’ll appear to other users",
                      ),
                      16.verticalSpace,
                      ImageWidget(
                          size: 100,
                          shape: BoxShape.circle,
                          imageUrl: selectedImage ?? Assets.images.svgs.user),
                      5.verticalSpace,
                      TextButton(
                          style: TextButton.styleFrom(
                              // padding: EdgeInsets.all(),
                              foregroundColor: context.colorScheme.onSurface,
                              shape: const StadiumBorder(
                                  side: BorderSide(color: Pallets.borderGrey))),
                          onPressed: () {
                            selectImage(context);
                          },
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              ImageWidget(
                                  imageUrl: Assets.images.svgs.uploadAvatar),
                              5.horizontalSpace,
                              const TextView(text: "Set avatar"),
                            ],
                          )),
                      25.verticalSpace,
                      OutlinedFormField(
                        placeHolder: "Username",
                        hint: "Use a unique username",
                        controller: usernameController,
                        validator: MultiValidator([
                          RequiredValidator(errorText: "Field is required"),
                        ]).call,
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
                            profileBloc.add(UpdateProfileEvent(
                                UpdateProfilePayload(
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
      context.pop();
      CustomDialogs.success("Profile updated");
      context.goNamed(PageUrl.homeScreen);
    }
  }
}
