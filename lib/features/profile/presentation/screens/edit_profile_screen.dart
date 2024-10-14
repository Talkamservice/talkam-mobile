import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:talkam/common/widgets/custom_appbar.dart';
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
import 'package:talkam/core/utils/validators.dart';
import 'package:talkam/features/post/dormain/mixins/refresh_posts_mixin.dart';
import 'package:talkam/features/profile/data/models/update_profile_payload.dart';
import 'package:talkam/features/profile/presentation/bloc/profile_bloc/profile_bloc.dart';
import 'package:talkam/features/profile/presentation/widgets/select_avater_sheet.dart';
import 'package:talkam/gen/assets.gen.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({
    super.key,
  });

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen>  with RefreshPostsMixin{
  @override
  void initState() {
    selectedImage = injector.get<ProfileBloc>().appUser?.avatar;

    usernameController.text =
        injector.get<ProfileBloc>().appUser?.username ?? '';

    setState(() {});

    super.initState();
  }

  final TextEditingController usernameController = TextEditingController();
  bool passwordObscured = true;
  final formkey = GlobalKey<FormState>();
  final profileBloc = injector.get<ProfileBloc>();
  var selectedImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        padding: EdgeInsets.all(0.0),
        tittleText: "Edit Profile",
        centerTile: false,
        showDivider: true,
        actions: [],
      ),
      body: BlocConsumer<ProfileBloc, ProfileState>(
        bloc: injector.get<ProfileBloc>(),
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
                          SpaceValidator(errorText: "Username must not contain space")
                        ]).call,
                      ),
                      38.verticalSpace,
                      CustomButton(
                        child: const TextView(
                          text: "Save changes",
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                        ),
                        onPressed: () {
                          if (formkey.currentState?.validate() ?? false) {
                            injector.get<ProfileBloc>().add(UpdateProfileEvent(
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
    var image = await CustomDialogs.showBottomSheet(
        context,
        SelectAvatarSheet(
          onAvatarSelected: (p0) {},
          onBackgroundSelector: (p0) {},
        ));
    if(image!= null){
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

      refreshPost(reload:false);
      CustomDialogs.success("Profile updated");
      context.pop();
      context.pop();
    }
  }
}
