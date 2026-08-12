import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:talkam/common/widgets/error_widget.dart';
import 'package:talkam/common/widgets/image_widget.dart';
import 'package:talkam/common/widgets/subscribe_button.dart';
import 'package:talkam/common/widgets/custom_dialogs.dart';
import 'package:talkam/common/widgets/custom_text_field.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/core/mock/mock_home_data.dart';
import 'package:talkam/core/navigation/route_url.dart';
import 'package:talkam/core/theme/pallets.dart';
import 'package:talkam/core/utils/extensions/context_extension.dart';
import 'package:talkam/core/utils/guest_user_helper.dart';
import 'package:talkam/features/group/presentation/widgets/join_group_button.dart';
import 'package:talkam/features/post/data/models/get_posts_response.dart';
import 'package:talkam/features/post/presentation/widgets/post_item.dart';
import 'package:talkam/features/post/presentation/widgets/post_loading_shimmer.dart';
import 'package:talkam/features/profile/presentation/bloc/follow_cubit/follow_cubit.dart';
import 'package:talkam/features/profile/presentation/bloc/profile_bloc/profile_bloc.dart';
import 'package:talkam/features/search/data/models/get_group_response.dart';
import 'package:talkam/features/search/data/models/get_search_response.dart';
import 'package:talkam/features/search/presentation/blocs/groups_search/groups_search_cubit.dart';
import 'package:talkam/features/search/presentation/blocs/post_search/post_search_cubit.dart';
import 'package:talkam/features/search/presentation/blocs/search/search_cubit.dart';
import 'package:talkam/features/search/presentation/blocs/user_search/user_search_cubit.dart';
import 'package:talkam/features/search/presentation/widget/recent_searches_loading_shimmer.dart';
import 'package:talkam/features/search/presentation/widget/trending_searches_loading_shimmer.dart';
import 'package:talkam/gen/assets.gen.dart';

enum _SearchTab { post, people, groups }

class SearchResultScreen extends StatefulWidget {
  final String query;
  final int initialTab;

  const SearchResultScreen({
    super.key,
    this.query = '',
    this.initialTab = 0,
  });

  @override
  State<SearchResultScreen> createState() => _SearchResultScreenState();
}

class _SearchResultScreenState extends State<SearchResultScreen> {
  late _SearchTab _selectedTab;
  late final PageController _pageController;
  final TextEditingController _textController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  final _postBloc = PostSearchCubit(injector.get());
  final _userBloc = UserSearchCubit(injector.get());
  final _groupBloc = GroupsSearchCubit(injector.get());
  final _searchCubit = SearchCubit(injector.get());

  bool _showSuggestions = false;

  @override
  void initState() {
    super.initState();
    _selectedTab = _SearchTab.values[widget.initialTab];
    _pageController = PageController(initialPage: widget.initialTab);
    _textController.text = widget.query;
    _showSuggestions = widget.query.trim().isEmpty;
    if (widget.query.trim().isNotEmpty) {
      _postBloc.searchPosts(widget.query);
      _userBloc.searchUser(widget.query);
      _groupBloc.searchGroup(widget.query);
    }
    _focusNode.addListener(() {
      if (_focusNode.hasFocus && !_showSuggestions) {
        setState(() => _showSuggestions = true);
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _textController.dispose();
    _focusNode.dispose();
    _searchCubit.close();
    super.dispose();
  }

  void _onSearch(String query) {
    if (query.trim().isEmpty) return;
    _postBloc.searchPosts(query);
    _userBloc.searchUser(query);
    _groupBloc.searchGroup(query);
    _focusNode.unfocus();
    setState(() => _showSuggestions = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colorScheme.surface,
      body: SafeArea(
        child: Column(
          children: [
            // ── Search bar + Cancel ──────────────────────────────────────
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              child: Row(
                children: [
                  Expanded(
                    child: CustomTextField(
                      controller: _textController,
                      focusNode: _focusNode,
                      textInputAction: TextInputAction.search,
                      onFieldSubmitted: _onSearch,
                      onChanged: (val) {
                        if (val.trim().isEmpty && !_showSuggestions) {
                          setState(() => _showSuggestions = true);
                        }
                      },
                      onTap: () {
                        if (!_showSuggestions) {
                          setState(() => _showSuggestions = true);
                        }
                      },
                      hint: 'Search...',
                      prefixIcon: Padding(
                        padding: const EdgeInsets.only(left: 14, right: 8),
                        child: ImageWidget(
                          imageUrl: Assets.images.svgV2.searchIcon,
                          size: 24,
                          color: Pallets.blueBubbleColor,
                        ),
                      ),
                    ),
                  ),
                  12.horizontalSpace,
                  GestureDetector(
                    onTap: () {
                      if (context.canPop()) {
                        context.pop();
                      } else {
                        context.goNamed(PageUrl.homeScreen);
                      }
                    },
                    child: TextView(
                      text: 'Cancel',
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: context.colorScheme.onSurface,
                    ),
                  ),
                ],
              ),
            ),

            if (_showSuggestions)
              // ── Recent / Trending suggestions ───────────────────────────
              Expanded(
                child: _SearchSuggestions(
                  bloc: _searchCubit,
                  onSelect: (word) {
                    _textController.text = word;
                    _onSearch(word);
                  },
                ),
              )
            else ...[
              // ── Tabs ─────────────────────────────────────────────────────
              _SearchTabBar(
                selected: _selectedTab,
                onTabSelected: (tab) {
                  setState(() => _selectedTab = tab);
                  _pageController.jumpToPage(tab.index);
                },
              ),

              // ── Tab content ───────────────────────────────────────────────
              Expanded(
                child: PageView(
                  controller: _pageController,
                  physics: const NeverScrollableScrollPhysics(),
                  onPageChanged: (i) {
                    setState(() => _selectedTab = _SearchTab.values[i]);
                  },
                  children: [
                    _PostTab(bloc: _postBloc, query: widget.query),
                    _PeopleTab(bloc: _userBloc, query: widget.query),
                    _GroupsTab(bloc: _groupBloc, query: widget.query),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

// ── Tab bar ────────────────────────────────────────────────────────────────────

class _SearchTabBar extends StatelessWidget {
  final _SearchTab selected;
  final ValueChanged<_SearchTab> onTabSelected;

  const _SearchTabBar({required this.selected, required this.onTabSelected});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: _SearchTab.values.map((tab) {
        final isSelected = tab == selected;
        return Expanded(
          child: InkWell(
            onTap: () => onTabSelected(tab),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 14.h),
              child: Column(
                children: [
                  TextView(
                    text: tab.label,
                    fontSize: 15,
                    fontWeight: isSelected ? FontWeight.w700 : FontWeight.w400,
                    color: isSelected
                        ? context.colorScheme.onSurface
                        : Pallets.grey400,
                  ),
                  6.verticalSpace,
                  Container(
                    height: 3,
                    width: 60.w,
                    decoration: BoxDecoration(
                      color: isSelected
                          ? Pallets.blueBubbleColor
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}

// ── Recent / Trending suggestions ────────────────────────────────────────────

class _SearchSuggestions extends StatefulWidget {
  const _SearchSuggestions({required this.bloc, required this.onSelect});

  final SearchCubit bloc;
  final ValueChanged<String> onSelect;

  @override
  State<_SearchSuggestions> createState() => _SearchSuggestionsState();
}

class _SearchSuggestionsState extends State<_SearchSuggestions> {
  List<SearchResponse> _recent = [];
  List<SearchResponse> _trending = [];
  bool _recentLoading = true;
  bool _trendingLoading = true;
  dynamic _pendingDeleteId;

  @override
  void initState() {
    super.initState();
    // Fetched here (not by the parent screen) so this widget is guaranteed
    // to already be subscribed via BlocConsumer before either response
    // arrives — BlocConsumer only reacts to emissions after it subscribes,
    // it doesn't replay whatever state the cubit is already sitting on.
    widget.bloc.fetchRecentSearches();
    widget.bloc.fetchTrendingSearches();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SearchCubit, SearchState>(
      bloc: widget.bloc,
      listener: (context, state) {
        state.maybeWhen(
          orElse: () {},
          fetchRecentSearchesSuccess: (response) {
            setState(() {
              _recent = response.data;
              _recentLoading = false;
            });
          },
          fetchRecentSearchesFailure: (_) {
            setState(() => _recentLoading = false);
          },
          fetchTrendingSearchesSuccess: (response) {
            setState(() {
              _trending = response.data;
              _trendingLoading = false;
            });
          },
          fetchTrendingSearchesFailure: (_) {
            setState(() => _trendingLoading = false);
          },
          deleteSearchSuccess: (_) {
            setState(() {
              _recent.removeWhere((item) => item.id == _pendingDeleteId);
              _pendingDeleteId = null;
            });
          },
          deleteSearchFailure: (error) {
            _pendingDeleteId = null;
            CustomDialogs.error(error);
          },
        );
      },
      builder: (context, state) {
        return SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const TextView(
                text: 'Recent Search',
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
              8.verticalSpace,
              if (_recentLoading)
                const RecentSearchesLoadingShimmer()
              else if (_recent.isEmpty)
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.h),
                  child: const TextView(
                    text: 'No recent searches',
                    fontSize: 13,
                    color: Pallets.grey400,
                  ),
                )
              else
                ..._recent.map((item) => _SuggestionRow(
                      icon: Icons.history,
                      text: item.word,
                      onTap: () => widget.onSelect(item.word),
                      isDeleting: _pendingDeleteId == item.id,
                      onDelete: () {
                        setState(() => _pendingDeleteId = item.id);
                        widget.bloc.deleteSearch(item.id.toString());
                      },
                    )),
              20.verticalSpace,
              const TextView(
                text: 'Trending',
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
              8.verticalSpace,
              if (_trendingLoading)
                const TrendingSearchesLoadingShimmer()
              else if (_trending.isEmpty)
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.h),
                  child: const TextView(
                    text: 'No trending searches',
                    fontSize: 13,
                    color: Pallets.grey400,
                  ),
                )
              else
                ..._trending.map((item) => _SuggestionRow(
                      icon: Icons.trending_up,
                      text: item.word,
                      onTap: () => widget.onSelect(item.word),
                    )),
            ],
          ),
        );
      },
    );
  }
}

class _SuggestionRow extends StatelessWidget {
  const _SuggestionRow({
    required this.icon,
    required this.text,
    required this.onTap,
    this.onDelete,
    this.isDeleting = false,
  });

  final IconData icon;
  final String text;
  final VoidCallback onTap;
  final VoidCallback? onDelete;
  final bool isDeleting;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10.h),
        child: Row(
          children: [
            Icon(icon, size: 18, color: Pallets.grey400),
            10.horizontalSpace,
            Expanded(
              child: TextView(
                text: text,
                fontSize: 14,
                maxLines: 1,
                textOverflow: TextOverflow.ellipsis,
              ),
            ),
            if (onDelete != null)
              isDeleting
                  ? SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Pallets.grey400,
                      ),
                    )
                  : InkWell(
                      onTap: onDelete,
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child:
                            Icon(Icons.close, size: 18, color: Pallets.grey400),
                      ),
                    ),
          ],
        ),
      ),
    );
  }
}

extension on _SearchTab {
  String get label {
    switch (this) {
      case _SearchTab.post:
        return 'Post';
      case _SearchTab.people:
        return 'People';
      case _SearchTab.groups:
        return 'Groups';
    }
  }
}

// ── Post Tab ──────────────────────────────────────────────────────────────────

class _PostTab extends StatefulWidget {
  final PostSearchCubit bloc;
  final String query;
  const _PostTab({required this.bloc, required this.query});

  @override
  State<_PostTab> createState() => _PostTabState();
}

class _PostTabState extends State<_PostTab> with AutomaticKeepAliveClientMixin {
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()
      ..addListener(() {
        if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent) {
          widget.bloc.fetchNextPage(widget.query);
        }
      });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocBuilder<PostSearchCubit, PostSearchState>(
      bloc: widget.bloc,
      builder: (context, state) {
        return state.maybeWhen(
          orElse: () => const SizedBox.shrink(),
          getPostSearchLoading: () => const Center(child: PostLoadingShimmer()),
          getPostSearchFailed: (error) => Center(
            child: TextView(text: error),
          ),
          postSearchLoaded: (posts, meta, relatedTopics) {
            // Use mock posts as fallback when API returns empty
            final display = posts.isEmpty ? MockHomeData.posts : posts;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: ListView.separated(
                    controller: _scrollController,
                    itemCount:
                        meta.canLoadMore ? display.length + 1 : display.length,
                    separatorBuilder: (_, __) =>
                        Container(height: 1, color: Pallets.borderGrey),
                    itemBuilder: (context, index) {
                      if (index >= display.length) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      return PostItem(post: display[index]);
                    },
                  ),
                ),
                // Related Topics
                if (relatedTopics.isNotEmpty)
                  _RelatedTopicsSection(topics: relatedTopics),
              ],
            );
          },
        );
      },
    );
  }
}

// ── Related Topics ─────────────────────────────────────────────────────────────

class _RelatedTopicsSection extends StatefulWidget {
  const _RelatedTopicsSection({required this.topics});

  final List<String> topics;

  @override
  State<_RelatedTopicsSection> createState() => _RelatedTopicsSectionState();
}

class _RelatedTopicsSectionState extends State<_RelatedTopicsSection> {
  final Set<String> _selected = {};

  @override
  Widget build(BuildContext context) {
    return Container(
      color: context.colorScheme.surface,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextView(
            text: 'RELATED TOPICS',
            fontSize: 11,
            fontWeight: FontWeight.w600,
            color: Pallets.grey400,
          ),
          10.verticalSpace,
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: widget.topics.map((topic) {
              final active = _selected.contains(topic);
              return GestureDetector(
                onTap: () => setState(() {
                  if (active) {
                    _selected.remove(topic);
                  } else {
                    _selected.add(topic);
                  }
                }),
                child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                  decoration: BoxDecoration(
                    color:
                        active ? Pallets.blueBubbleColor : Colors.transparent,
                    borderRadius: BorderRadius.circular(40.r),
                    border: Border.all(
                      color:
                          active ? Pallets.blueBubbleColor : Pallets.borderGrey,
                    ),
                  ),
                  child: TextView(
                    text: topic,
                    fontSize: 13,
                    color:
                        active ? Colors.white : context.colorScheme.onSurface,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

// ── People Tab ────────────────────────────────────────────────────────────────

class _PeopleTab extends StatefulWidget {
  final UserSearchCubit bloc;
  final String query;
  const _PeopleTab({required this.bloc, required this.query});

  @override
  State<_PeopleTab> createState() => _PeopleTabState();
}

class _PeopleTabState extends State<_PeopleTab>
    with AutomaticKeepAliveClientMixin {
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()
      ..addListener(() {
        if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent) {
          widget.bloc.fetchNextPage(widget.query);
        }
      });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocBuilder<UserSearchCubit, UserSearchState>(
      bloc: widget.bloc,
      builder: (context, state) {
        return state.maybeWhen(
          orElse: () => const Center(child: PostLoadingShimmer()),
          getUserSearchLoading: () => const Center(child: PostLoadingShimmer()),
          getUserSearchFailed: (error) => AppErrorWidget(
            message: error,
            onTap: () => widget.bloc.searchUser(widget.query),
          ),
          userSearchLoaded: (people, meta) {
            if (people.isEmpty) {
              return const Center(child: TextView(text: "No people found"));
            }
            return ListView.separated(
              controller: _scrollController,
              itemCount:
                  meta.canLoadMore == true ? people.length + 1 : people.length,
              separatorBuilder: (_, __) =>
                  Container(height: 1, color: Pallets.borderGrey),
              itemBuilder: (context, index) {
                if (index >= people.length) {
                  return const Center(child: CircularProgressIndicator());
                }
                return _PersonItem(user: people[index]);
              },
            );
          },
        );
      },
    );
  }
}

class _PersonItem extends StatefulWidget {
  final PostCreator user;
  const _PersonItem({required this.user});

  @override
  State<_PersonItem> createState() => _PersonItemState();
}

class _PersonItemState extends State<_PersonItem> {
  final _followCubit = injector.get<FollowCubit>();
  late bool _isFollowing = widget.user.isFollowing ?? false;

  @override
  void dispose() {
    _followCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        GuestUserHelper.handleGuestUserAction(action: () {
          final me = injector.get<ProfileBloc>().appUser;
          if (me?.id == widget.user.id) {
            context.pushNamed(PageUrl.profileScreen);
          } else {
            context.pushNamed(PageUrl.userProfileScreen,
                extra: widget.user.id.toString());
          }
        });
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ImageWidget(
              imageUrl: widget.user.avatar ?? Assets.images.svgs.user,
              size: 48,
              shape: BoxShape.circle,
              fit: BoxFit.cover,
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
                          text: widget.user.usersName,
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          maxLines: 1,
                          textOverflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (widget.user.isSubscribed) ...[
                        4.horizontalSpace,
                        const Icon(Icons.verified,
                            color: Pallets.blueBubbleColor, size: 15),
                      ],
                    ],
                  ),
                  4.verticalSpace,
                  TextView(
                    text: '@${widget.user.username ?? widget.user.usersName}',
                    fontSize: 13,
                    color: Pallets.grey400,
                  ),
                ],
              ),
            ),
            12.horizontalSpace,
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
                text: _isFollowing ? 'Following' : 'Follow',
                color: _isFollowing ? Pallets.grey400 : Pallets.blueBubbleColor,
                onTap: () => GuestUserHelper.handleGuestUserAction(
                  action: () =>
                      _followCubit.toggleFollow(widget.user.id.toString()),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Groups Tab ─────────────────────────────────────────────────────────────────

class _GroupsTab extends StatefulWidget {
  final GroupsSearchCubit bloc;
  final String query;
  const _GroupsTab({required this.bloc, required this.query});

  @override
  State<_GroupsTab> createState() => _GroupsTabState();
}

class _GroupsTabState extends State<_GroupsTab>
    with AutomaticKeepAliveClientMixin {
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()
      ..addListener(() {
        if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent) {
          widget.bloc.fetchNextPage(widget.query);
        }
      });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocBuilder<GroupsSearchCubit, GroupsSearchState>(
      bloc: widget.bloc,
      builder: (context, state) {
        return state.maybeWhen(
          orElse: () => const Center(child: PostLoadingShimmer()),
          getGroupSearchLoading: () =>
              const Center(child: PostLoadingShimmer()),
          getGroupSearchFailed: (error) => AppErrorWidget(
            message: error,
            onTap: () => widget.bloc.searchGroup(widget.query),
          ),
          groupSearchLoaded: (groups, meta) {
            if (groups.isEmpty) {
              return const Center(child: TextView(text: "No groups found"));
            }
            return ListView.separated(
              controller: _scrollController,
              padding: EdgeInsets.symmetric(vertical: 8.h),
              itemCount:
                  meta.canLoadMore == true ? groups.length + 1 : groups.length,
              separatorBuilder: (_, __) => 8.verticalSpace,
              itemBuilder: (context, index) {
                if (index >= groups.length) {
                  return const Center(child: CircularProgressIndicator());
                }
                return _GroupSearchItem(group: groups[index]);
              },
            );
          },
        );
      },
    );
  }
}

class _GroupSearchItem extends StatelessWidget {
  final TalkamGroup group;
  const _GroupSearchItem({required this.group});

  String _formatCount(int count) {
    if (count >= 1000) {
      return '${(count / 1000).toStringAsFixed(1).replaceAll(RegExp(r'\.0$'), '')}k';
    }
    return '$count';
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: InkWell(
        onTap: () => context.pushNamed(PageUrl.groupsInfoScreen,
            extra: group.id.toString()),
        child: Container(
          padding: EdgeInsets.all(14.w),
          decoration: BoxDecoration(
            color: context.theme.cardColor,
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8.r),
                child: ImageWidget(
                  imageUrl: group.image ?? '',
                  width: 60,
                  height: 60,
                  fit: BoxFit.cover,
                ),
              ),
              12.horizontalSpace,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextView(
                      text: group.name ?? '',
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      maxLines: 1,
                      textOverflow: TextOverflow.ellipsis,
                    ),
                    4.verticalSpace,
                    TextView(
                      text: '${_formatCount(group.totalMembers ?? 0)} Members',
                      fontSize: 13,
                      color: Pallets.grey400,
                    ),
                  ],
                ),
              ),
              12.horizontalSpace,
              JoinGroupButton(
                group: group,
                onStateChanged: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
