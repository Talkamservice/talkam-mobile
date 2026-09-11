import 'package:talkam/core/di/injector.dart';
import 'package:talkam/features/group/presentation/blocs/featured_groups/featured_groups_cubit.dart';
import 'package:talkam/features/group/presentation/blocs/groups_cubit/groups_cubit.dart';
import 'package:talkam/features/home/presentation/bloc/drawer/drawer_data_cubit.dart';

/// Keeps every group list in the app in sync after a membership or follow
/// change — joining, leaving, sending/cancelling a join request, or
/// toggling follow all move a group in/out of these lists.
mixin RefreshGroupsMixin {
  void refreshAllGroupLists({bool silent = false}) {
    // Sidebar's "Groups"/"Following" sections.
    injector.get<DrawerDataCubit>().fetch(silent: true);
    // Broadcasts to any open Explore/My Groups tab (via RefreshGroupListener)
    // so it refetches its own list.
    injector.get<GroupsCubit>().refreshGroups(silent: silent);
    // The Suggested carousel — a join/follow should drop the group from it.
    injector.get<FeaturedGroupsCubit>().getRecommendedGroups(reload: !silent);
  }
}
