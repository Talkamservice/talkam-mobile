import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talkam/common/widgets/custom_dialogs.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/constants/package_exports.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/core/theme/pallets.dart';
import 'package:talkam/features/post/presentation/widgets/post_item.dart';
import 'package:talkam/features/post/presentation/widgets/post_loading_shimmer.dart';
import 'package:talkam/features/profile/presentation/widgets/refresh_post_listener.dart';
import 'package:talkam/features/post/data/models/get_posts_response.dart';
import 'package:talkam/features/profile/presentation/bloc/profile_posts_tab_cubit/profile_posts_tab_cubit.dart';

enum _PostsSubTab { active, scheduled }

class ProfilePostTab extends StatefulWidget {
  const ProfilePostTab({super.key, this.bottomPadding = 0});

  /// Extra scroll padding below the last post. Used where the tab sits behind
  /// the shell's bottom nav so the final post can be scrolled clear of it.
  final double bottomPadding;

  @override
  State<ProfilePostTab> createState() => _ProfilePostTabState();
}

class _ProfilePostTabState extends State<ProfilePostTab> with AutomaticKeepAliveClientMixin {
  final ProfilePostsTabCubit _activeCubit = injector.get();
  // A separate instance — not the DI singleton — so its state doesn't
  // collide with the "Active Posts" cubit above. Both sub-tabs stay loaded
  // and cached independently while switching between them.
  final ProfilePostsTabCubit _scheduledCubit = ProfilePostsTabCubit(injector.get());

  _PostsSubTab _subTab = _PostsSubTab.active;

  List<TalkamPost> _activePosts = [];
  List<TalkamPost> _scheduledPosts = [];

  final ScrollController _activeScrollController = ScrollController();
  final ScrollController _scheduledScrollController = ScrollController();

  @override
  void initState() {
    _activeCubit.fetchUserPosts();
    _scheduledCubit.fetchUserPosts(isScheduled: true);
    _activeScrollController.addListener(() {
      if (_activeScrollController.position.pixels == _activeScrollController.position.maxScrollExtent) {
        _activeCubit.loadMorePosts(_activePosts);
      }
    });
    _scheduledScrollController.addListener(() {
      if (_scheduledScrollController.position.pixels == _scheduledScrollController.position.maxScrollExtent) {
        _scheduledCubit.loadMorePosts(_scheduledPosts, isScheduled: true);
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _scheduledCubit.close();
    _activeScrollController.dispose();
    _scheduledScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Column(
      children: [
        10.verticalSpace,
        Row(
          children: [
            _SubTabButton(
              title: "Active Posts",
              isSelected: _subTab == _PostsSubTab.active,
              onTap: () => setState(() => _subTab = _PostsSubTab.active),
            ),
            _SubTabButton(
              title: "Scheduled Posts",
              isSelected: _subTab == _PostsSubTab.scheduled,
              onTap: () => setState(() => _subTab = _PostsSubTab.scheduled),
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.only(top: 6.h),
          child: const Divider(height: 1, color: Pallets.borderGrey),
        ),
        Expanded(
          child: IndexedStack(
            index: _subTab.index,
            children: [
              _PostsList(
                cubit: _activeCubit,
                scrollController: _activeScrollController,
                posts: _activePosts,
                onPostsUpdated: (posts) => setState(() => _activePosts = posts),
                isScheduled: false,
                emptyText: "No posts yet",
                bottomPadding: widget.bottomPadding,
              ),
              _PostsList(
                cubit: _scheduledCubit,
                scrollController: _scheduledScrollController,
                posts: _scheduledPosts,
                onPostsUpdated: (posts) => setState(() => _scheduledPosts = posts),
                isScheduled: true,
                emptyText: "No scheduled posts",
                bottomPadding: widget.bottomPadding,
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}

/// A half-width tab cell whose tap target fills the whole cell, but whose
/// selected-underline only spans the label's own width — `IntrinsicWidth`
/// sizes the label+underline column to its widest child (the text), then
/// `Center` places that narrower column in the middle of the full-width
/// tappable area.
class _SubTabButton extends StatelessWidget {
  const _SubTabButton({
    required this.title,
    required this.isSelected,
    required this.onTap,
  });

  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Center(
          child: IntrinsicWidth(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextView(
                  text: title,
                  align: TextAlign.center,
                  color: isSelected ? Pallets.boldBlackV2 : Pallets.grey400,
                  fontWeight: FontWeight.w600,
                ),
                10.verticalSpace,
                Container(
                  height: 3.0,
                  decoration: BoxDecoration(
                    color: isSelected ? Pallets.tabBarBlue : Colors.transparent,
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _PostsList extends StatelessWidget {
  const _PostsList({
    required this.cubit,
    required this.scrollController,
    required this.posts,
    required this.onPostsUpdated,
    required this.isScheduled,
    required this.emptyText,
    required this.bottomPadding,
  });

  final ProfilePostsTabCubit cubit;
  final ScrollController scrollController;
  final List<TalkamPost> posts;
  final void Function(List<TalkamPost> posts) onPostsUpdated;
  final bool isScheduled;
  final String emptyText;
  final double bottomPadding;

  @override
  Widget build(BuildContext context) {
    return RefreshPostListener(
      onRefresh: () {
        cubit.fetchUserPosts(reload: false, isScheduled: isScheduled);
      },
      child: BlocConsumer<ProfilePostsTabCubit, ProfilePostsTabState>(
        bloc: cubit,
        listener: (context, state) {
          state.maybeWhen(
            loaded: (List<TalkamPost> loadedPosts) {
              onPostsUpdated(loadedPosts);
            },
            orElse: () {},
          );
        },
        builder: (context, state) {
          return state.maybeWhen(
            loading: () => const Center(
              child: PostLoadingShimmer(),
            ),
            error: () => const SizedBox.shrink(),
            orElse: () {
              if (posts.isEmpty) {
                return Center(
                  child: TextView(
                    text: emptyText,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                );
              }

              return RefreshIndicator(
                onRefresh: () async {
                  cubit.fetchUserPosts(isScheduled: isScheduled);
                },
                child: ListView(
                  controller: scrollController,
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: EdgeInsets.only(
                    top: 10.0.h,
                    bottom: bottomPadding,
                  ),
                  children: [
                    for (final post in posts) ...[
                      PostItem(
                          post: post,
                          showScheduledPost: true,
                          isOwnPost: true),
                      6.verticalSpace,
                    ],
                    if (state is ProfilePostsTabLoadingMoreState)
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 16.h),
                        child: Center(child: CustomDialogs.getLoading(size: 50)),
                      )
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
