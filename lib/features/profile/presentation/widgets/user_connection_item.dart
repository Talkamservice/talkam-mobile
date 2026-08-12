import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talkam/common/widgets/custom_dialogs.dart';
import 'package:talkam/common/widgets/image_widget.dart';
import 'package:talkam/common/widgets/subscribe_button.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/constants/package_exports.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/core/navigation/route_url.dart';
import 'package:talkam/core/services/data/session_manager.dart';
import 'package:talkam/core/theme/pallets.dart';
import 'package:talkam/core/utils/extensions/context_extension.dart';
import 'package:talkam/core/utils/guest_user_helper.dart';
import 'package:talkam/features/post/data/models/get_posts_response.dart';
import 'package:talkam/features/profile/presentation/bloc/follow_cubit/follow_cubit.dart';
import 'package:talkam/gen/assets.gen.dart';

/// A single row in the Following/Followers lists — same visual language as
/// [GroupMemberItem] (avatar, name + verified badge, username, action pill)
/// minus the group-specific "Member of {group}" caption and admin menu.
class UserConnectionItem extends StatefulWidget {
  const UserConnectionItem({
    super.key,
    required this.user,
    this.initialFollowing = false,
  });

  final PostCreator user;

  /// Whether the signed-in user is already following [user]. The API
  /// doesn't return per-row follow-back state, so callers pass the best
  /// known default (e.g. `true` for every row on the Following tab).
  final bool initialFollowing;

  @override
  State<UserConnectionItem> createState() => _UserConnectionItemState();
}

class _UserConnectionItemState extends State<UserConnectionItem> {
  final _followCubit = injector.get<FollowCubit>();
  late bool _isFollowing = widget.initialFollowing;

  bool get _isMe => SessionManager().isMe(widget.user.id.toString());

  @override
  void dispose() {
    _followCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = widget.user;

    return InkWell(
      onTap: () {
        GuestUserHelper.handleGuestUserAction(
          action: () {
            if (_isMe) {
              context.pushNamed(PageUrl.profileScreen);
            } else {
              context.pushNamed(PageUrl.userProfileScreen,
                  extra: user.id.toString());
            }
          },
        );
      },
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ImageWidget(
              imageUrl: user.avatar ?? Assets.images.svgs.user,
              size: 50,
              shape: BoxShape.circle,
            ),
            12.horizontalSpace,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Flexible(
                        child: TextView(
                          text: displayName,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: context.colorScheme.onSurface,
                          maxLines: 1,
                          textOverflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (user.isSubscribed) ...[
                        4.horizontalSpace,
                        const Icon(Icons.verified,
                            color: Colors.orange, size: 16),
                      ],
                    ],
                  ),
                  TextView(
                    text:
                        "@${user.username ?? displayName.replaceAll(' ', '')}",
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                    color: Pallets.darkGrey,
                  ),
                ],
              ),
            ),
            if (!_isMe)
              BlocListener<FollowCubit, FollowState>(
                bloc: _followCubit,
                listener: (context, state) {
                  state.maybeWhen(
                    orElse: () {},
                    success: (following) =>
                        setState(() => _isFollowing = following),
                    failure: (error) => CustomDialogs.error(error),
                  );
                },
                child: SubscribeButton(
                  color:
                      _isFollowing ? Pallets.grey60 : Pallets.blueBubbleColor,
                  onTap: () => GuestUserHelper.handleGuestUserAction(
                    action: () => _followCubit.toggleFollow(user.id.toString()),
                  ),
                  child: TextView(
                    text: _isFollowing ? "Following" : "Follow",
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  String get displayName => (widget.user.name).isNotEmpty
      ? widget.user.name
      : (widget.user.username ?? "").isNotEmpty
          ? widget.user.username!
          : widget.user.email;
}
