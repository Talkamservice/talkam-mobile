import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talkam/common/widgets/custom_dialogs.dart';
import 'package:talkam/common/widgets/custom_text_field.dart';
import 'package:talkam/common/widgets/image_widget.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/constants/dialog_texts.dart';
import 'package:talkam/core/constants/package_exports.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/core/mock/mock_home_data.dart';
import 'package:talkam/core/navigation/route_url.dart';
import 'package:talkam/core/services/data/session_manager.dart';
import 'package:talkam/core/theme/pallets.dart';
import 'package:talkam/core/utils/extensions/context_extension.dart';
import 'package:talkam/features/group/presentation/blocs/groups_cubit/groups_cubit.dart';
import 'package:talkam/features/home/presentation/bloc/drawer/drawer_cubit.dart';
import 'package:talkam/features/home/presentation/widgets/category_group_list.dart';
import 'package:talkam/features/notifications/presentation/bloc/notification_bloc.dart';
import 'package:talkam/features/post/data/models/get_categories_response.dart';
import 'package:talkam/features/profile/presentation/bloc/connections_summary_cubit/connections_summary_cubit.dart';
import 'package:talkam/features/profile/presentation/bloc/profile_bloc/profile_bloc.dart';
import 'package:talkam/features/search/data/models/get_group_response.dart';
import 'package:talkam/gen/assets.gen.dart';

import 'category_list.dart';

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
  String _categorySearchQuery = '';

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 1.sw,
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: Row(
          children: [
            Container(
              width: 0.9.sw,
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
                      // Everything from "Following" down scrolls together as
                      // one region, instead of the category list below it
                      // being the only scrollable piece.
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const _DrawerFollowingSection(),
                              12.verticalSpace,
                              _DrawerGroupsSection(
                                  onGroupsTap: widget.onGroupsTap),
                              Divider(height: 24.h, color: Pallets.grey90),
                              _DrawerCategorySearchField(
                                onChanged: (value) => setState(
                                    () => _categorySearchQuery = value),
                              ),
                              8.verticalSpace,
                              BlocConsumer<DrawerCubit, DrawerState>(
                                buildWhen: _buildWhen,
                                listener: (context, state) {},
                                builder: (context, state) {
                                  return state.maybeWhen(
                                    orElse: () => CategoryList(
                                        searchQuery: _categorySearchQuery),
                                    categoryView: () => CategoryList(
                                        searchQuery: _categorySearchQuery),
                                    subCategoryView: (subCategory) =>
                                        CategoryGroupList(
                                      category: subCategory,
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: () => Navigator.of(context).pop(),
                child: Container(color: Colors.transparent),
              ),
            ),
          ],
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

/// Live-filters the Categories list below it as the user types.
class _DrawerCategorySearchField extends StatelessWidget {
  const _DrawerCategorySearchField({required this.onChanged});

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
/// Renders the real signed-in user (`ProfileBloc.appUser`), falling back to
/// the device-local guest alias for anonymous sessions.
class _DrawerProfileHeader extends StatefulWidget {
  const _DrawerProfileHeader();

  @override
  State<_DrawerProfileHeader> createState() => _DrawerProfileHeaderState();
}

class _DrawerProfileHeaderState extends State<_DrawerProfileHeader> {
  // Singleton — HomeScreen kicks off the fetch on launch, so by the time the
  // drawer opens the counts are (usually) already loaded. Calling
  // fetchCounts() again here is a no-op unless nothing has loaded yet (e.g.
  // the drawer somehow opens before HomeScreen's initState ran).
  final _connectionsSummaryCubit = injector.get<ConnectionsSummaryCubit>();

  @override
  void initState() {
    _connectionsSummaryCubit.fetchCounts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      bloc: injector.get<ProfileBloc>(),
      builder: (context, state) {
        final user = injector.get<ProfileBloc>().appUser;
        final anonymousUsername = SessionManager.instance.anonymousUsername;
        final isAnonymous =
            !SessionManager.instance.isLoggedIn || anonymousUsername.isNotEmpty;

        final name = isAnonymous
            ? (anonymousUsername.isNotEmpty
                ? anonymousUsername
                : (user?.name ?? "Guest"))
            : (user?.name ?? "");
        final username =
            isAnonymous ? anonymousUsername : (user?.username ?? "");
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
                      imageUrl: user?.avatar ?? Assets.images.svgs.user,
                      shape: BoxShape.circle,
                      size: 56,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon:
                        Icon(Icons.close, color: context.colorScheme.onSurface),
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
                      text: name,
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                    if (username.isNotEmpty)
                      TextView(
                        text: "@$username",
                        fontSize: 14,
                        color: Pallets.grey400,
                      ),
                  ],
                ),
              ),
              10.verticalSpace,
              BlocBuilder<ConnectionsSummaryCubit, ConnectionsSummaryState>(
                bloc: _connectionsSummaryCubit,
                builder: (context, state) {
                  final counts = state.maybeWhen(
                    orElse: () => (following: 0, followers: 0),
                    success: (followingCount, followersCount) =>
                        (following: followingCount, followers: followersCount),
                  );
                  return Row(
                    children: [
                      TextView(
                          text: "${counts.following} ",
                          fontSize: 14,
                          fontWeight: FontWeight.w700),
                      const TextView(
                          text: "Following",
                          fontSize: 14,
                          color: Pallets.grey400),
                      12.horizontalSpace,
                      TextView(
                          text: "${counts.followers} ",
                          fontSize: 14,
                          fontWeight: FontWeight.w700),
                      const TextView(
                          text: "Followers",
                          fontSize: 14,
                          color: Pallets.grey400),
                    ],
                  );
                },
              ),
            ],
          ),
        );
      },
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

/// "Following" — the categories the signed-in user follows, sourced from
/// the real `TalkamUser.interests`. Tapping one opens that category's
/// subcategory browser, same as the Groups list below.
class _DrawerFollowingSection extends StatelessWidget {
  const _DrawerFollowingSection();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      bloc: injector.get<ProfileBloc>(),
      builder: (context, state) {
        return _DrawerListSection(
          title: "Following",
          items: injector.get<ProfileBloc>().appUser?.interests ?? const [],
          emptyLabel: "You're not following any topics yet",
          onItemTap: (category) => context
              .read<DrawerCubit>()
              .switchView(DrawerView.subCategory, subCategory: category),
        );
      },
    );
  }
}

class _DrawerGroupsSection extends StatelessWidget {
  const _DrawerGroupsSection({required this.onGroupsTap});
  final VoidCallback onGroupsTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const TextView(
            text: "Groups", fontSize: 15, fontWeight: FontWeight.w700),
        6.verticalSpace,
        InkWell(
          onTap: onGroupsTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
            child: Row(
              children: [
                const Icon(Icons.group,
                    color: Pallets.blueBubbleColor, size: 26),
                8.horizontalSpace,
                const TextView(
                    text: "All", fontSize: 16, color: Pallets.blueBubbleColor),
              ],
            ),
          ),
        ),
        BlocBuilder<GroupsCubit, GroupsState>(
          bloc: injector.get<GroupsCubit>(),
          builder: (context, state) {
            return state.maybeWhen(
              orElse: () => const SizedBox.shrink(),
              getGroupsLoading: () => const Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: SizedBox(
                  height: 18,
                  width: 18,
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
              ),
              getGroupsFailure: (_) => const TextView(
                  text: "No groups yet", fontSize: 13, color: Pallets.grey400),
              getGroupsSuccess: (groups, _) {
                if (groups.isEmpty) {
                  return const TextView(
                      text: "No groups yet",
                      fontSize: 13,
                      color: Pallets.grey400);
                }
                return Column(
                  children: groups
                      .take(3)
                      .map((group) => _DrawerGroupItem(group: group))
                      .toList(),
                );
              },
            );
          },
        ),
        InkWell(
          onTap: () {
            Navigator.of(context).pop();
            context.pushNamed(PageUrl.createGroupScreen);
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
            child: Row(
              children: [
                const Icon(Icons.add_circle_outline,
                    color: Pallets.blueBubbleColor, size: 26),
                8.horizontalSpace,
                const TextView(
                    text: "Create group",
                    fontSize: 16,
                    color: Pallets.blueBubbleColor),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _DrawerGroupItem extends StatelessWidget {
  const _DrawerGroupItem({required this.group});

  final TalkamGroup group;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pop();
        if (group.isSuspended ?? false) {
          CustomDialogs.error("You have been suspended from this group");
        } else if (!group.isPublic && !(group.isFollowing ?? false)) {
          CustomDialogs.showInfoMessage(context, privateGroupViewText);
        } else {
          context.pushNamed(PageUrl.groupsInfoScreen,
              extra: group.id.toString());
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            ImageWidget(
              imageUrl: group.image ?? Assets.images.png.sports.path,
              size: 26,
              shape: BoxShape.circle,
            ),
            8.horizontalSpace,
            Expanded(
              child: TextView(
                text: group.name ?? "",
                fontSize: 16,
              ),
            ),
            8.horizontalSpace,
            ImageWidget(imageUrl: Assets.images.svgs.chevronRight),
          ],
        ),
      ),
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
      onItemTap: (category) {
        context.pushNamed(
          PageUrl.groupsInfoScreen,
          extra: {
            'groupId': category.id.toString(),
            'isPrivate': true,
          },
        );
      },
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
