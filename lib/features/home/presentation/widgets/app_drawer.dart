import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talkam/common/widgets/custom_text_field.dart';
import 'package:talkam/common/widgets/image_widget.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/constants/package_exports.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/core/mock/mock_home_data.dart';
import 'package:talkam/core/navigation/route_url.dart';
import 'package:talkam/core/theme/pallets.dart';
import 'package:talkam/core/utils/extensions/context_extension.dart';
import 'package:talkam/features/home/presentation/bloc/drawer/drawer_cubit.dart';
import 'package:talkam/features/home/presentation/widgets/category_group_list.dart';
import 'package:talkam/features/notifications/presentation/bloc/notification_bloc.dart';
import 'package:talkam/features/post/data/models/get_categories_response.dart';
import 'package:talkam/gen/assets.gen.dart';

import 'group_list.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({
    super.key,
    required this.onGroupsTap,
  });

  /// Switches the shell to the real Groups branch (and closes the drawer).
  final VoidCallback onGroupsTap;

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  String _groupSearchQuery = '';

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 280.w,
      decoration: BoxDecoration(color: context.theme.cardColor),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const _DrawerProfileHeader(),
              12.verticalSpace,
              const _DrawerQuickLinks(),
              16.verticalSpace,
              const _DrawerFollowingSection(),
              12.verticalSpace,
              _DrawerPrivateGroupsSection(onGroupsTap: widget.onGroupsTap),
              Divider(height: 24.h, color: Pallets.grey90),
              _DrawerGroupSearchField(
                onChanged: (value) => setState(() => _groupSearchQuery = value),
              ),
              8.verticalSpace,
              Expanded(
                child: BlocConsumer<DrawerCubit, DrawerState>(
                  buildWhen: _buildWhen,
                  listener: (context, state) {},
                  builder: (context, state) {
                    return state.maybeWhen(
                      orElse: () =>
                          GroupList(searchQuery: _groupSearchQuery),
                      categoryView: () =>
                          GroupList(searchQuery: _groupSearchQuery),
                      subCategoryView: (subCategory) => CategoryGroupList(
                        category: subCategory,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool _buildWhen(DrawerState previous, DrawerState current) {
    return current.maybeWhen(
      categoryView: () => true,
      subCategoryView: (subCategory) => true,
      orElse: () => false,
    );
  }
}

/// Live-filters the Groups list below it as the user types.
class _DrawerGroupSearchField extends StatelessWidget {
  const _DrawerGroupSearchField({required this.onChanged});

  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      hint: "Search",
      onChanged: onChanged,
      borderRadius: 24,
      prefixIcon: Padding(
        padding: EdgeInsets.only(left: 12.w, right: 6.w),
        child: ImageWidget(
          imageUrl: Assets.images.svgV2.searchIcon,
          size: 16.w,
          color: Pallets.grey400,
        ),
      ),
    );
  }
}

/// Avatar, name/username, follow counts, and the drawer's own close button.
///
/// Renders [MockHomeData.user] unconditionally — staging has no seed data
/// yet, so the real ProfileBloc.appUser is not used here for now.
class _DrawerProfileHeader extends StatelessWidget {
  const _DrawerProfileHeader();

  @override
  Widget build(BuildContext context) {
    final user = MockHomeData.user;

    return Padding(
      padding: EdgeInsets.only(top: 12.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              InkWell(
                customBorder: const CircleBorder(),
                onTap: () {
                  Navigator.of(context).pop();
                  context.pushNamed(PageUrl.profileTabScreen);
                },
                child: ImageWidget(
                  imageUrl: user.avatar ?? Assets.images.svgs.user,
                  shape: BoxShape.circle,
                  size: 56,
                ),
              ),
              const Spacer(),
              IconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: Icon(Icons.close, color: context.colorScheme.onSurface),
              ),
            ],
          ),
          4.verticalSpace,
          InkWell(
            onTap: () {
              Navigator.of(context).pop();
              context.pushNamed(PageUrl.profileTabScreen);
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextView(
                  text: user.name,
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
                TextView(
                  text: user.username,
                  fontSize: 14,
                  color: Pallets.grey400,
                ),
              ],
            ),
          ),
          10.verticalSpace,
          Row(
            children: [
              TextView(
                  text: "${MockHomeData.followingCount} ",
                  fontSize: 14,
                  fontWeight: FontWeight.w700),
              const TextView(
                  text: "Following", fontSize: 14, color: Pallets.grey400),
              12.horizontalSpace,
              TextView(
                  text: "${MockHomeData.followersCount} ",
                  fontSize: 14,
                  fontWeight: FontWeight.w700),
              const TextView(
                  text: "Followers", fontSize: 14, color: Pallets.grey400),
            ],
          ),
        ],
      ),
    );
  }
}

/// Messages / Notifications quick links.
class _DrawerQuickLinks extends StatelessWidget {
  const _DrawerQuickLinks();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _QuickLinkRow(
          iconUrl: Assets.images.svgV2.messageIcon,
          label: "Messages",
          onTap: () {
            Navigator.of(context).pop();
            context.pushNamed(PageUrl.messagingScreen);
          },
        ),
        BlocBuilder<NotificationsBloc, NotificationsState>(
          bloc: injector.get<NotificationsBloc>(),
          builder: (context, state) {
            final unread =
                injector.get<NotificationsBloc>().stats.unreadMessages;
            return _QuickLinkRow(
              iconUrl: Assets.images.svgV2.notificationIcon,
              label: "Notification",
              badge: unread != 0 ? unread.toString() : null,
              onTap: () => context.pushNamed(PageUrl.notificationScreen),
            );
          },
        ),
      ],
    );
  }
}

class _QuickLinkRow extends StatelessWidget {
  const _QuickLinkRow({
    required this.iconUrl,
    required this.label,
    required this.onTap,
    this.badge,
  });

  final String iconUrl;
  final String label;
  final VoidCallback onTap;
  final String? badge;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 8.h),
        child: Row(
          children: [
            ImageWidget(
              imageUrl: iconUrl,
              size: 22,
            ),
            10.horizontalSpace,
            Expanded(
              child: TextView(
                text: label,
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
            if (badge != null)
              CircleAvatar(
                radius: 8,
                backgroundColor: Pallets.errorRed,
                child: TextView(text: badge!, fontSize: 9, color: Colors.white),
              ),
          ],
        ),
      ),
    );
  }
}

/// "Following" — the categories the signed-in user follows. Sourced from
/// TalkamUser.interests — rendered from [MockHomeData.followingTopics]
/// unconditionally for now (staging has no seed data). Tapping one opens
/// that category's subcategory browser, same as the Groups list below.
class _DrawerFollowingSection extends StatelessWidget {
  const _DrawerFollowingSection();

  @override
  Widget build(BuildContext context) {
    return _DrawerListSection(
      title: "Following",
      items: MockHomeData.followingTopics,
      emptyLabel: "You're not following any topics yet",
      onItemTap: (category) => context
          .read<DrawerCubit>()
          .switchView(DrawerView.subCategory, subCategory: category),
    );
  }
}

/// "Private Groups" — no data source exists for this yet (no groups-you-own
/// endpoint), so this renders [MockHomeData.privateGroups] for now. These are
/// groups, not categories, so tapping one goes to the real Groups tab rather
/// than the category subview used by Following/the Groups list below.
class _DrawerPrivateGroupsSection extends StatelessWidget {
  const _DrawerPrivateGroupsSection({required this.onGroupsTap});

  final VoidCallback onGroupsTap;

  @override
  Widget build(BuildContext context) {
    return _DrawerListSection(
      title: "Private Groups",
      items: MockHomeData.privateGroups,
      emptyLabel: "No private groups yet",
      onItemTap: (category) => onGroupsTap(),
    );
  }
}

class _DrawerListSection extends StatelessWidget {
  const _DrawerListSection({
    required this.title,
    required this.items,
    required this.emptyLabel,
    required this.onItemTap,
  });

  final String title;
  final List<PostCategory> items;
  final String emptyLabel;
  final ValueChanged<PostCategory> onItemTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextView(text: title, fontSize: 15, fontWeight: FontWeight.w700),
        6.verticalSpace,
        if (items.isEmpty)
          TextView(text: emptyLabel, fontSize: 13, color: Pallets.grey400)
        else
          ...items.take(3).map(
                (category) => NavCategoryItem(
                  category: category,
                  onTap: () => onItemTap(category),
                ),
              ),
      ],
    );
  }
}

class NavCategoryItem extends StatelessWidget {
  const NavCategoryItem(
      {super.key,
      required this.category,
      required this.onTap,
      this.showArrow = true});

  final PostCategory category;
  final VoidCallback onTap;
  final bool? showArrow;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            ImageWidget(
              imageUrl: category.iconImage ?? Assets.images.png.sports.path,
              size: 26,
            ),
            8.horizontalSpace,
            Expanded(
              child: TextView(
                text: category.name,
                fontSize: 16,
              ),
            ),
            8.horizontalSpace,
            if (showArrow!)
              ImageWidget(imageUrl: Assets.images.svgs.chevronRight)
          ],
        ),
      ),
    );
  }
}
