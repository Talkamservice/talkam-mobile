import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:talkam/common/widgets/custom_dialogs.dart';
import 'package:talkam/common/widgets/image_widget.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/core/mock/mock_home_data.dart';
import 'package:talkam/core/theme/pallets.dart';
import 'package:talkam/core/utils/guest_user_helper.dart';
import 'package:talkam/features/post/data/models/get_categories_response.dart';
import 'package:talkam/features/profile/presentation/bloc/profile_bloc/profile_bloc.dart';
import 'package:talkam/gen/assets.gen.dart';

class CategoriesScreenHeader extends StatefulWidget {
  const CategoriesScreenHeader(
      {super.key, required this.category, this.onFollowUpdated});

  final PostCategory category;
  final VoidCallback? onFollowUpdated;

  @override
  State<CategoriesScreenHeader> createState() => _CategoriesScreenHeaderState();
}

class _CategoriesScreenHeaderState extends State<CategoriesScreenHeader> {
  @override
  Widget build(BuildContext context) {
    final avatars = MockHomeData.groupMemberAvatars(widget.category);
    final memberCount = MockHomeData.groupMemberCount(widget.category);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            ImageWidget(
              imageUrl: widget.category.backgroundImage ?? '',
              height: 210,
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
                      icon: Icons.arrow_back,
                      onTap: () => context.pop(),
                    ),
                    const Spacer(),
                    _HeaderIconButton(
                      icon: Icons.more_vert,
                      onTap: () => CustomDialogs.showToast("Coming soon"),
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
              TextView(
                text: widget.category.name ?? "",
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
              10.verticalSpace,
              Row(
                children: [
                  _MemberAvatarsStack(avatarUrls: avatars),
                  8.horizontalSpace,
                  TextView(
                    text: "${_formatMemberCount(memberCount)} Members",
                    fontSize: 13,
                    color: Pallets.grey60,
                  ),
                  const Spacer(),
                  FollowCategoryButton(
                    category: widget.category,
                    onFollowUpdated: widget.onFollowUpdated,
                  ),
                  8.horizontalSpace,
                  InkWell(
                    onTap: () => CustomDialogs.showToast("Coming soon"),
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
                        imageUrl: Assets.images.svgs.groupsAdd,
                        size: 16,
                      ),
                    ),
                  ),
                ],
              ),
              12.verticalSpace,
              TextView(
                text: widget.category.description?.toString() ?? "",
                fontSize: 14,
                color: Pallets.grey60,
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
  const _HeaderIconButton({required this.icon, required this.onTap});

  final IconData icon;
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
        child: Icon(icon, color: Colors.white, size: 20),
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

class FollowCategoryButton extends StatefulWidget {
  FollowCategoryButton({
    super.key,
    required this.category,
    required this.onFollowUpdated,
  });

  final PostCategory category;
  final VoidCallback? onFollowUpdated;

  @override
  State<FollowCategoryButton> createState() => _FollowCategoryButtonState();
}

class _FollowCategoryButtonState extends State<FollowCategoryButton> {
  final bloc = ProfileBloc(injector.get());

  @override
  Widget build(BuildContext context) {
    return GuestUserHelper.guestUserWidget(
        widget: BlocConsumer<ProfileBloc, ProfileState>(
          bloc: bloc,
          listener: (context, state) {
            if (state is UpdateInterestFailureState) {
              CustomDialogs.error(state.error);
            }

            if (state is UpdateInterestSuccessState) {
              widget.category.isFollowing = !widget.category.isFollowing;
              widget.onFollowUpdated?.call();
            }
          },
          builder: (context, state) {
            return TextButton(
                style: TextButton.styleFrom(
                    backgroundColor: widget.category.isFollowing
                        ? Pallets.red
                        : Pallets.primary,
                    foregroundColor: Pallets.white,
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                    shape: const StadiumBorder()),
                onPressed: () {
                  bloc.add(UpdateInterestEvent(widget.category.id.toString()));
                },
                child: Builder(builder: (context) {
                  if (state is UpdateInterestLoadingState) {
                    return const SizedBox(
                      height: 16,
                      width: 16,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Pallets.white,
                      ),
                    );
                  }

                  return TextView(
                    text: widget.category.isFollowing
                        ? "Subscribed"
                        : "Subscribe",
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  );
                }));
          },
        ),
        guestWidget: 0.verticalSpace);
  }
}
