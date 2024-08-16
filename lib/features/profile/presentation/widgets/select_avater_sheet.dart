import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:talkam/common/widgets/custom_button.dart';
import 'package:talkam/common/widgets/custom_dialogs.dart';
import 'package:talkam/common/widgets/custom_outlined_button.dart';
import 'package:talkam/common/widgets/error_widget.dart';
import 'package:talkam/common/widgets/image_widget.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/constants/package_exports.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/core/theme/pallets.dart';
import 'package:talkam/features/authentication/data/models/get_avatars_response.dart';
import 'package:talkam/features/profile/presentation/bloc/profile_bloc/profile_bloc.dart';

class SelectAvatarSheet extends StatefulWidget {
  const SelectAvatarSheet({
    super.key,
    required this.onAvatarSelected,
    required this.onBackgroundSelector,
    this.selectBackgroundColor = true,
    // required this.tittle
  });

  final Function(dynamic) onAvatarSelected;
  final Function(Color) onBackgroundSelector;
  final bool? selectBackgroundColor;

  @override
  State<SelectAvatarSheet> createState() => _SelectAvatarSheetState();
}

class _SelectAvatarSheetState extends State<SelectAvatarSheet> {
  int selectedIndex = 0;
  int selectedImageIndex = 0;
  int selectedColorIndex = 0;
  final bloc = ProfileBloc(injector.get());

  TalkamAvatar? selectedImage;

  @override
  void initState() {
    bloc.add(GetAvatarsEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: Pallets.white),
      height: 400,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            16.verticalSpace,
            Expanded(
              child: IndexedStack(
                index: selectedIndex,
                children: [
                  BlocConsumer<ProfileBloc, ProfileState>(
                    bloc: bloc,
                    buildWhen: _buildWhen,
                    listener: _listenToProfileStates,
                    builder: (context, state) {
                      if (state is GetAvatarsLoadingState) {
                        return SizedBox(
                          height: 200.h,
                          child: Center(
                            child: CustomDialogs.getLoading(size: 50),
                          ),
                        );
                      }

                      if (state is GetAvatarsSuccessState) {
                        return RefreshIndicator(
                          onRefresh: () async {
                            bloc.add(GetAvatarsEvent());
                          },
                          child: GridView.builder(
                              shrinkWrap: true,
                              itemCount: state.response.data.length,
                              // physics: const NeverScrollableScrollPhysics(),
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      childAspectRatio: 1,
                                      mainAxisSpacing: 10,
                                      crossAxisSpacing: 10,
                                      mainAxisExtent: 80,
                                      crossAxisCount: 4),
                              itemBuilder: (context, index) => InkWell(
                                  onTap: () {
                                    selectedImageIndex = index;
                                    selectedImage = state.response.data[index];
                                    widget.onAvatarSelected(
                                        state.response.data[index]);
                                    setState(() {});
                                  },
                                  child: IgnorePointer(
                                    child: ImageWidget(
                                      imageUrl: state.response.data[index].image,
                                      shape: BoxShape.circle,
                                      fit: BoxFit.scaleDown,

                                      border: selectedImageIndex == index

                                          ? Border.all(
                                              width: 1, color: Pallets.primary)
                                          : null,
                                    ),
                                  ))),
                        );
                      }

                      return AppErrorWidget(
                        onTap: () {
                          injector.get<ProfileBloc>().add(GetAvatarsEvent());
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
            16.verticalSpace,
            Row(
              children: [
                Expanded(
                  child: CustomOutlinedButton(
                      outlinedColr: Pallets.red,
                      foreGroundColor: Pallets.red,
                      onPressed: () {
                        context.pop();
                      },
                      child: const TextView(
                        text: "Cancel",
                        fontWeight: FontWeight.w700,
                      )),
                ),
                10.horizontalSpace,
                Expanded(
                  child: CustomButton(
                    text: "Save",
                    foregroundColor: Pallets.white,
                    onPressed: selectedImage != null
                        ? () {
                            context.pop(selectedImage?.image);
                            // widget.onAvatarSelected(selectedImage);
                          }
                        : null,
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  void _listenToProfileStates(BuildContext context, ProfileState state) {
    // if (state is UploadImageLoadingState) {
    //   CustomDialogs.showLoading(context);
    // }
    // if (state is UploadImagesSuccessState) {
    //   context.pop();
    //   context.pop();
    //   CustomDialogs.success('Avatar uploaded!');
    // }
    //
    // if (state is UploadImageFailureState) {
    //   context.pop();
    //   CustomDialogs.error(state.error);
    // }
  }

  bool _buildWhen(ProfileState previous, ProfileState current) {
    return current is GetAvatarsLoadingState ||
        current is GetAvatarsFailureState ||
        current is GetAvatarsSuccessState;
  }
}

class SwitchButton extends StatefulWidget {
  const SwitchButton(
      {super.key,
      required this.tittle,
      required this.selected,
      required this.onSelected});

  final String tittle;
  final bool selected;
  final VoidCallback onSelected;

  @override
  State<SwitchButton> createState() => _SwitchButtonState();
}

class _SwitchButtonState extends State<SwitchButton> {
  @override
  Widget build(BuildContext context) {
    return TextButton(
        style: TextButton.styleFrom(
            foregroundColor: Pallets.black,
            backgroundColor: widget.selected ? Pallets.grey75 : Pallets.white,
            shape: const StadiumBorder()),
        onPressed: () => widget.onSelected(),
        child: TextView(text: widget.tittle));
  }
}
