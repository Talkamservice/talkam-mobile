import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talkam/common/widgets/error_widget.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/constants/package_exports.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/features/post/presentation/widgets/post_loading_shimmer.dart';
import 'package:talkam/features/profile/presentation/bloc/connections_cubit/connections_cubit.dart';
import 'package:talkam/features/profile/presentation/widgets/user_connection_item.dart';

enum ConnectionsListType { following, followers }

/// Backs both the Following and Followers tabs on the signed-in user's own
/// profile — same list-item visual as the group feature's "All Members" tab,
/// just without the group-specific caption/admin menu.
class ConnectionsTab extends StatefulWidget {
  const ConnectionsTab({super.key, required this.type});

  final ConnectionsListType type;

  @override
  State<ConnectionsTab> createState() => _ConnectionsTabState();
}

class _ConnectionsTabState extends State<ConnectionsTab>
    with AutomaticKeepAliveClientMixin {
  final _cubit = injector.get<ConnectionsCubit>();

  bool get _isFollowing => widget.type == ConnectionsListType.following;

  @override
  void initState() {
    _isFollowing ? _cubit.fetchFollowing() : _cubit.fetchFollowers();
    super.initState();
  }

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocBuilder<ConnectionsCubit, ConnectionsState>(
      bloc: _cubit,
      builder: (context, state) {
        return state.maybeWhen(
          orElse: () => const Center(child: PostLoadingShimmer()),
          loading: () => const Center(child: PostLoadingShimmer()),
          failure: (error) => AppErrorWidget(
            message: error,
            onTap: () => _isFollowing
                ? _cubit.fetchFollowing()
                : _cubit.fetchFollowers(),
          ),
          success: (users) {
            if (users.isEmpty) {
              return Center(
                child: TextView(
                  text: _isFollowing
                      ? "Not following anyone yet"
                      : "No followers yet",
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              );
            }

            return RefreshIndicator(
              onRefresh: () => _isFollowing
                  ? _cubit.fetchFollowing()
                  : _cubit.fetchFollowers(),
              child: ListView.builder(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: EdgeInsets.only(top: 10.0.h),
                itemCount: users.length,
                itemBuilder: (context, index) => UserConnectionItem(
                  user: users[index],
                  initialFollowing: _isFollowing,
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
