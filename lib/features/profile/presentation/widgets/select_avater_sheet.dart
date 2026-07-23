import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talkam/common/widgets/custom_button.dart';
import 'package:talkam/common/widgets/custom_dialogs.dart';
import 'package:talkam/common/widgets/custom_outlined_button.dart';
import 'package:talkam/common/widgets/image_widget.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/constants/package_exports.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/core/theme/pallets.dart';
import 'package:talkam/core/utils/avatar_fallback.dart';
import 'package:talkam/features/authentication/data/models/get_avatars_response.dart';
import 'package:talkam/features/profile/presentation/bloc/profile_bloc/profile_bloc.dart';

class SelectAvatarSheet extends StatefulWidget {
  const SelectAvatarSheet({
    super.key,
    required this.onAvatarSelected,
    required this.onBackgroundSelector,
    this.selectBackgroundColor = true,
  });

  final Function(dynamic) onAvatarSelected;
  final Function(Color) onBackgroundSelector;
  final bool? selectBackgroundColor;

  @override
  State<SelectAvatarSheet> createState() => _SelectAvatarSheetState();
}

class _SelectAvatarSheetState extends State<SelectAvatarSheet> {
  final bloc = ProfileBloc(injector.get());

  /// Either a remote avatar url or one of the [kFallbackAvatarEmojis].
  String? _selectedAvatar;

  @override
  void initState() {
    bloc.add(GetAvatarsEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Pallets.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24.r),
          topRight: Radius.circular(24.r),
        ),
      ),
      padding: EdgeInsets.only(bottom: 20.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // ── Handle bar ─────────────────────────────────────────────
          Padding(
            padding: EdgeInsets.only(top: 12.h, bottom: 16.h),
            child: Container(
              width: 48.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: Pallets.boldBlackV2,
                borderRadius: BorderRadius.circular(4.r),
              ),
            ),
          ),

          // ── Title ──────────────────────────────────────────────────
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: const Align(
              alignment: Alignment.centerLeft,
              child: TextView(
                text: "Select Avatar",
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: Pallets.boldBlackV2,
              ),
            ),
          ),
          12.verticalSpace,
          Divider(height: 1, thickness: 1, color: Pallets.grey90),

          // ── Avatar grid ────────────────────────────────────────────
          Flexible(
            child: BlocBuilder<ProfileBloc, ProfileState>(
              bloc: bloc,
              buildWhen: _buildWhen,
              builder: (context, state) {
                if (state is GetAvatarsLoadingState) {
                  return SizedBox(
                    height: 200.h,
                    child: Center(child: CustomDialogs.getLoading(size: 50)),
                  );
                }

                if (state is GetAvatarsSuccessState) {
                  return state.response.data.isEmpty
                      ? _buildFallbackGrid(
                          'The server returned no avatars.',
                        )
                      : _buildRemoteGrid(state.response.data);
                }

                if (state is GetAvatarsFailureState) {
                  return _buildFallbackGrid(state.error);
                }

                return _buildFallbackGrid('Avatars have not loaded yet.');
              },
            ),
          ),

          // ── Actions ────────────────────────────────────────────────
          Padding(
            padding: EdgeInsets.fromLTRB(24.w, 16.h, 24.w, 0),
            child: Row(
              children: [
                Expanded(
                  child: CustomOutlinedButton(
                    outlinedColr: Pallets.errorRed,
                    onPressed: () => context.pop(),
                    child: const TextView(
                      text: "Cancel",
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: Pallets.errorRed,
                    ),
                  ),
                ),
                12.horizontalSpace,
                Expanded(
                  child: CustomButton(
                    elevation: 0,
                    onPressed: _selectedAvatar != null
                        ? () => context.pop(_selectedAvatar)
                        : null,
                    child: const TextView(
                      text: "Save",
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: Pallets.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRemoteGrid(List<TalkamAvatar> avatars) {
    return GridView.builder(
      shrinkWrap: true,
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
      itemCount: avatars.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 5,
        mainAxisSpacing: 12.h,
        crossAxisSpacing: 12.w,
        childAspectRatio: 1,
      ),
      itemBuilder: (context, index) {
        final avatar = avatars[index];
        return _AvatarTile(
          isSelected: _selectedAvatar == avatar.image,
          onTap: () {
            setState(() => _selectedAvatar = avatar.image);
            widget.onAvatarSelected(avatar);
          },
          child: ImageWidget(
            imageUrl: avatar.image,
            shape: BoxShape.circle,
            fit: BoxFit.cover,
          ),
        );
      },
    );
  }

  /// Placeholder emoji avatars, shown when the avatars endpoint gives us
  /// nothing so the profile step stays usable.
  Widget _buildFallbackGrid(String reason) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(24.w, 16.h, 24.w, 0),
          child: AvatarFallbackNotice(
            reason: reason,
            onRetry: () => bloc.add(GetAvatarsEvent()),
          ),
        ),
        Flexible(
          child: GridView.builder(
            shrinkWrap: true,
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
            itemCount: kFallbackAvatarEmojis.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 5,
              mainAxisSpacing: 12.h,
              crossAxisSpacing: 12.w,
              childAspectRatio: 1,
            ),
            itemBuilder: (context, index) {
              final emoji = kFallbackAvatarEmojis[index];
              return _AvatarTile(
                isSelected: _selectedAvatar == emoji,
                onTap: () {
                  setState(() => _selectedAvatar = emoji);
                  widget.onAvatarSelected(emoji);
                },
                child: Center(
                  child: Text(emoji, style: TextStyle(fontSize: 26.sp)),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  bool _buildWhen(ProfileState previous, ProfileState current) {
    return current is GetAvatarsLoadingState ||
        current is GetAvatarsFailureState ||
        current is GetAvatarsSuccessState;
  }
}

/// Circular, tappable avatar slot with the selected ring from the design.
class _AvatarTile extends StatelessWidget {
  const _AvatarTile({
    required this.child,
    required this.isSelected,
    required this.onTap,
  });

  final Widget child;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Pallets.bgLight,
          border: Border.all(
            color: isSelected ? Pallets.blueBubbleColor : Colors.transparent,
            width: 2,
          ),
        ),
        child: ClipOval(child: child),
      ),
    );
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
