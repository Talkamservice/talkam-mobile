import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:talkam/common/widgets/custom_dialogs.dart';
import 'package:talkam/common/widgets/image_widget.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/core/mock/mock_home_data.dart';
import 'package:talkam/common/widgets/subscribe_button.dart';
import 'package:talkam/core/theme/pallets.dart';
import 'package:talkam/core/utils/guest_user_helper.dart';
import 'package:talkam/features/profile/presentation/bloc/profile_bloc/profile_bloc.dart';
import 'package:talkam/gen/assets.gen.dart';
import 'package:talkam/core/services/network/url_config.dart';
import 'package:talkam/core/utils/helper_utils.dart';
import 'package:talkam/core/navigation/route_url.dart';
import 'package:talkam/features/group/presentation/widgets/group_action_sheet.dart';

import '../../../../core/utils/extensions/context_extension.dart';
import '../../../search/data/models/get_group_response.dart';

class GroupDetailsHeader extends StatefulWidget {
  const GroupDetailsHeader(
      {super.key, required this.group, this.onFollowUpdated});

  final TalkamGroup group;
  final VoidCallback? onFollowUpdated;

  @override
  State<GroupDetailsHeader> createState() => _GroupDetailsHeaderState();
}

class _GroupDetailsHeaderState extends State<GroupDetailsHeader> {
  @override
  Widget build(BuildContext context) {
    final avatars = MockHomeData.groupMemberAvatars(widget.group);
    final memberCount = MockHomeData.groupMemberCount(widget.group);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            ImageWidget(
              imageUrl: widget.group.image ?? '',
              height: 250,
              width: 1.sw,
              fit: BoxFit.cover,
            ),
            SafeArea(
              bottom: false,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                child: Row(
                  children: [
                    _HeaderIconButton(
                      icon: Icons.arrow_back_ios_new_rounded,
                      onTap: () => context.pop(),
                    ),
                    const Spacer(),
                    _HeaderIconButton(
                      iconWidget: ImageWidget(
                        imageUrl: Assets.images.svgV2.searchIcon,
                        size: 20,
                        color: Colors.white,
                      ),
                      onTap: () {
                        context.pushNamed(
                          PageUrl.searchResultScreen,
                          extra: {'initialTab': 2},
                        );
                      },
                    ),
                    12.horizontalSpace,
                    _HeaderIconButton(
                      icon: Icons.more_vert,
                      onTap: () {
                        CustomDialogs.showCustomDialog(
                          GroupActionSheet(group: widget.group),
                          context,
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextView(
                      text: widget.group.name ?? "",
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  if (widget.group.isAdmin)
                    TextButton.icon(
                      onPressed: () {
                        context.pushNamed(
                          PageUrl.createGroupScreen,
                          extra: widget.group,
                        );
                      },
                      icon: Icon(
                        Icons.edit_outlined,
                        size: 18.sp,
                        color: Pallets.blueBubbleColor,
                      ),
                      label: const TextView(
                        text: "Edit",
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Pallets.blueBubbleColor,
                      ),
                    ),
                ],
              ),
              10.verticalSpace,
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      context.pushNamed(
                        PageUrl.groupMembersScreen,
                        extra: widget.group,
                      );
                    },
                    child: Row(
                      children: [
                        _MemberAvatarsStack(avatarUrls: avatars),
                        8.horizontalSpace,
                        TextView(
                          text: "${_formatMemberCount(memberCount)} Members",
                          fontSize: 13,
                          color: Pallets.darkGrey,
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  FollowGroupButton(
                    group: widget.group,
                    onFollowUpdated: widget.onFollowUpdated,
                  ),
                  8.horizontalSpace,
                  InkWell(
                    onTap: () {
                      Helpers.share("${UrlConfig.webUrl}group/${widget.group.id}");
                    },
                    customBorder: const CircleBorder(),
                    child: Container(
                      width: 34.w,
                      height: 34.w,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Pallets.grey90),
                      ),
                      child: ImageWidget(
                        imageUrl: Assets.images.svgV2.userAdd,
                        size: 16,
                      ),
                    ),
                  ),
                ],
              ),
              12.verticalSpace,
              TextView(
                text: widget.group.description?.toString() ?? "",
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: context.colorScheme.onSurface,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

String _formatMemberCount(int count) {
  if (count < 1000) return count.toString();
  final k = count / 1000;
  return "${k % 1 == 0 ? k.toStringAsFixed(0) : k.toStringAsFixed(1)}K";
}

class _HeaderIconButton extends StatelessWidget {
  const _HeaderIconButton({this.icon, this.iconWidget, required this.onTap});

  final IconData? icon;
  final Widget? iconWidget;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      customBorder: const CircleBorder(),
      child: Container(
        width: 36.w,
        height: 36.w,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.black.withValues(alpha: 0.35),
        ),
        child: iconWidget ?? Icon(icon, color: Colors.white, size: 20),
      ),
    );
  }
}

/// Overlapping circular avatars, e.g. the small preview of a group's members
/// shown next to its member count.
class _MemberAvatarsStack extends StatelessWidget {
  const _MemberAvatarsStack({required this.avatarUrls});

  final List<String> avatarUrls;

  static const double _size = 28;
  static const double _overlap = 18;

  @override
  Widget build(BuildContext context) {
    final shown = avatarUrls.take(4).toList();
    if (shown.isEmpty) return const SizedBox.shrink();

    return SizedBox(
      width: _overlap * (shown.length - 1) + _size,
      height: _size,
      child: Stack(
        children: [
          for (int i = 0; i < shown.length; i++)
            Positioned(
              left: i * _overlap,
              child: Container(
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.fromBorderSide(
                      BorderSide(color: Colors.white, width: 2)),
                ),
                child: ImageWidget(
                  imageUrl: shown[i],
                  size: _size,
                  shape: BoxShape.circle,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class FollowGroupButton extends StatefulWidget {
  FollowGroupButton({
    super.key,
    required this.group,
    required this.onFollowUpdated,
  });

  final TalkamGroup group;
  final VoidCallback? onFollowUpdated;

  @override
  State<FollowGroupButton> createState() => _FollowGroupButtonState();
}

class _FollowGroupButtonState extends State<FollowGroupButton> {
  final bloc = ProfileBloc(injector.get());

  @override
  Widget build(BuildContext context) {
    // Determine following status (using isPublic or similar logic if isFollowing doesn't exist)
    bool isFollowing = widget.group.isFollowing ?? false;

    return GuestUserHelper.guestUserWidget(
        widget: BlocConsumer<ProfileBloc, ProfileState>(
          bloc: bloc,
          listener: (context, state) {
            if (state is UpdateInterestFailureState) {
              CustomDialogs.error(state.error);
            }

            if (state is UpdateInterestSuccessState) {
              // Update state
              widget.onFollowUpdated?.call();
            }
          },
          builder: (context, state) {
            return SubscribeButton(
              color: isFollowing ? Pallets.grey60 : Pallets.blueBubbleColor,
              onTap: () {
                bloc.add(UpdateInterestEvent(widget.group.id.toString()));
              },
              child: state is UpdateInterestLoadingState
                  ? const SizedBox(
                      height: 16,
                      width: 16,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Pallets.white,
                      ),
                    )
                  : TextView(
                      text: isFollowing ? "Subscribed" : "Subscribe",
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
            );
          },
        ),
        guestWidget: 0.verticalSpace);
  }
}
