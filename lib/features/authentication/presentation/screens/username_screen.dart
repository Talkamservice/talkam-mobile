import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talkam/common/widgets/custom_appbar.dart';
import 'package:talkam/common/widgets/custom_button.dart';
import 'package:talkam/common/widgets/custom_dialogs.dart';
import 'package:talkam/common/widgets/image_widget.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/constants/package_exports.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/core/navigation/route_url.dart';
import 'package:talkam/core/theme/pallets.dart';
import 'package:talkam/core/utils/avatar_fallback.dart';
import 'package:talkam/features/authentication/data/models/get_avatars_response.dart';
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
  // The shared singleton, not a fresh instance — ProfileBloc._onUpdateProfile
  // carries forward `appUser?.onboarding`/`business` from whichever instance
  // handles the event, so a throwaway instance here would wipe those fields
  // back to null on the real singleton it re-emits into.
  ProfileBloc get profileBloc => injector.get<ProfileBloc>();

  /// Remote avatar url, or one of [kFallbackAvatarEmojis] while the avatars
  /// endpoint is returning nothing. Used purely for the preview.
  String? selectedAvatar;

  /// The chosen preset's id — the value the backend actually wants for
  /// `avatar`. Null when a fallback emoji was picked (can't be persisted) or
  /// nothing was picked yet.
  String? selectedAvatarId;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileBloc, ProfileState>(
      bloc: profileBloc,
      listener: _listenToProfileBloc,
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: CustomAppBar(
            bgColor: Colors.transparent,
            elevation: 0,
            actions: [
              Padding(
                padding: EdgeInsets.only(right: 24.w),
                child: Center(
                  child: TextView(
                    text: "Skip",
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Pallets.boldBlackV2,
                    onTap: _skip,
                  ),
                ),
              ),
            ],
          ),
          bottomNavigationBar: SafeArea(
            child: Padding(
              padding: EdgeInsets.fromLTRB(24.w, 8.h, 24.w, 20.h),
              child: CustomButton(
                elevation: 0,
                onPressed: _saveAndContinue,
                child: const TextView(
                  text: "Next",
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          body: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ── Header ─────────────────────────────────────────────
                const TextView(
                  text: "Profile",
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                  color: Pallets.boldBlackV2,
                ),
                8.verticalSpace,
                const TextView(
                  text: "Set how you’ll appear to other users",
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Pallets.grey400,
                  lineHeight: 1.4,
                ),

                24.verticalSpace,

                // ── Avatar preview ─────────────────────────────────────
                Center(child: _buildAvatarPreview()),

                20.verticalSpace,

                // ── Change avatar pill ─────────────────────────────────
                Center(
                  child: GestureDetector(
                    onTap: _selectAvatar,
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 15.w, vertical: 8.h),
                      decoration: BoxDecoration(
                        color: Pallets.bgLight,
                        borderRadius: BorderRadius.circular(100),
                        border: Border.all(color: Pallets.grey90, width: 1),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ImageWidget(
                            imageUrl: Assets.images.svgs.uploadAvatar,
                            size: 20.w,
                            color: Pallets.boldBlackV2,
                          ),
                          10.horizontalSpace,
                          const TextView(
                            text: "Change Avatar",
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: Pallets.boldBlackV2,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                24.verticalSpace,

                // Placeholder avatars can't be persisted — say so up front.
                if (isFallbackAvatar(selectedAvatar))
                  AvatarFallbackNotice(
                    reason:
                        'Pick a real avatar once the avatars endpoint is live.',
                  ),

                24.verticalSpace,
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildAvatarPreview() {
    final size = 260.w;

    if (isFallbackAvatar(selectedAvatar)) {
      return Container(
        height: size,
        width: size,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Pallets.bgLight,
        ),
        child: Center(
          child: Text(selectedAvatar!, style: TextStyle(fontSize: 120.sp)),
        ),
      );
    }

    if (selectedAvatar != null) {
      return ImageWidget(
        imageUrl: selectedAvatar!,
        size: size,
        shape: BoxShape.circle,
        fit: BoxFit.cover,
      );
    }

    // Empty state — the flat grey circle from the design.
    return Container(
      height: size,
      width: size,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Pallets.bgLight,
      ),
    );
  }

  Future<void> _selectAvatar() async {
    // SelectAvatarSheet's popped value stays a plain image-url/emoji String
    // (other screens depend on that contract) — this callback is the only
    // place the full TalkamAvatar (and therefore its preset id) is exposed.
    TalkamAvatar? tappedAvatar;

    final result = await CustomDialogs.showBottomSheet(
      context,
      SelectAvatarSheet(
        onAvatarSelected: (value) {
          if (value is TalkamAvatar) tappedAvatar = value;
        },
        onBackgroundSelector: (_) {},
      ),
    );

    if (result is String && result.isNotEmpty) {
      setState(() {
        selectedAvatar = result;
        selectedAvatarId =
            (tappedAvatar != null && tappedAvatar!.image == result)
                ? tappedAvatar!.id.toString()
                : null;
      });
    }
  }

  void _saveAndContinue() {
    // Emoji placeholders (and anything without a resolved preset id) are
    // local only — don't try to persist them.
    if (selectedAvatarId == null) {
      _skip();
      return;
    }

    profileBloc.add(UpdateProfileEvent(
      UpdateProfilePayload(avatar: selectedAvatarId),
    ));
  }

  /// Both Skip and Next continue into user-type selection — onboarding isn't
  /// finished until that (and consent, after it) is confirmed.
  void _skip() {
    context.pushNamed(PageUrl.userTypeSelectionScreen);
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
      context.pushNamed(PageUrl.userTypeSelectionScreen);
    }
  }
}
