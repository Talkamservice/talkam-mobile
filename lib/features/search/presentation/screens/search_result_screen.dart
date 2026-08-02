import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:talkam/common/widgets/image_widget.dart';
import 'package:talkam/common/widgets/subscribe_button.dart';
import 'package:talkam/common/widgets/custom_text_field.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/core/mock/mock_home_data.dart';
import 'package:talkam/core/navigation/route_url.dart';
import 'package:talkam/core/theme/pallets.dart';
import 'package:talkam/core/utils/extensions/context_extension.dart';
import 'package:talkam/core/utils/guest_user_helper.dart';
import 'package:talkam/features/post/presentation/widgets/post_item.dart';
import 'package:talkam/features/post/presentation/widgets/post_loading_shimmer.dart';
import 'package:talkam/features/profile/presentation/bloc/profile_bloc/profile_bloc.dart';
import 'package:talkam/features/search/presentation/blocs/groups_search/groups_search_cubit.dart';
import 'package:talkam/features/search/presentation/blocs/post_search/post_search_cubit.dart';
import 'package:talkam/features/search/presentation/blocs/user_search/user_search_cubit.dart';
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

  @override
  void initState() {
    super.initState();
    _selectedTab = _SearchTab.values[widget.initialTab];
    _pageController = PageController(initialPage: widget.initialTab);
    _textController.text = widget.query;
    _postBloc.searchPosts(widget.query);
    _userBloc.searchUser(widget.query);
    _groupBloc.searchGroup(widget.query);
  }

  @override
  void dispose() {
    _pageController.dispose();
    _textController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _onSearch(String query) {
    if (query.trim().isEmpty) return;
    _postBloc.searchPosts(query);
    _userBloc.searchUser(query);
    _groupBloc.searchGroup(query);
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
                    fontWeight:
                        isSelected ? FontWeight.w700 : FontWeight.w400,
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

class _PostTabState extends State<_PostTab>
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
    return BlocBuilder<PostSearchCubit, PostSearchState>(
      bloc: widget.bloc,
      builder: (context, state) {
        return state.maybeWhen(
          orElse: () => const SizedBox.shrink(),
          getPostSearchLoading: () =>
              const Center(child: PostLoadingShimmer()),
          getPostSearchFailed: (error) => Center(
            child: TextView(text: error),
          ),
          postSearchLoaded: (posts, meta) {
            // Use mock posts as fallback when API returns empty
            final display =
                posts.isEmpty ? MockHomeData.posts : posts;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: 16.w, vertical: 12.h),
                  child: TextView(
                    text: '${display.length * 9} RESULTS',
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Pallets.grey400,
                  ),
                ),
                Expanded(
                  child: ListView.separated(
                    controller: _scrollController,
                    itemCount: meta.canLoadMore
                        ? display.length + 1
                        : display.length,
                    separatorBuilder: (_, __) =>
                        Container(height: 1, color: Pallets.borderGrey),
                    itemBuilder: (context, index) {
                      if (index >= display.length) {
                        return const Center(
                            child: CircularProgressIndicator());
                      }
                      return PostItem(post: display[index]);
                    },
                  ),
                ),
                // Related Topics
                _RelatedTopicsSection(),
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
  @override
  State<_RelatedTopicsSection> createState() => _RelatedTopicsSectionState();
}

class _RelatedTopicsSectionState extends State<_RelatedTopicsSection> {
  final Set<String> _selected = {'Anxiety', 'Depression'};

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
            children: MockSearchData.relatedTopics.map((topic) {
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
                  padding: EdgeInsets.symmetric(
                      horizontal: 16.w, vertical: 8.h),
                  decoration: BoxDecoration(
                    color: active ? Pallets.blueBubbleColor : Colors.transparent,
                    borderRadius: BorderRadius.circular(40.r),
                    border: Border.all(
                      color: active ? Pallets.blueBubbleColor : Pallets.borderGrey,
                    ),
                  ),
                  child: TextView(
                    text: topic,
                    fontSize: 13,
                    color: active ? Colors.white : context.colorScheme.onSurface,
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
        // Use mock people as fallback
        final people = MockSearchData.searchPeople;
        return ListView.separated(
          controller: _scrollController,
          itemCount: people.length,
          separatorBuilder: (_, __) =>
              Container(height: 1, color: Pallets.borderGrey),
          itemBuilder: (context, index) =>
              _PersonItem(user: people[index]),
        );
      },
    );
  }
}

class _PersonItem extends StatefulWidget {
  final MockSearchUser user;
  const _PersonItem({required this.user});

  @override
  State<_PersonItem> createState() => _PersonItemState();
}

class _PersonItemState extends State<_PersonItem> {
  bool _following = false;

  @override
  void initState() {
    super.initState();
    _following = widget.user.isFollowing;
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
          crossAxisAlignment: CrossAxisAlignment.start,
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
                      TextView(
                        text: widget.user.name,
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                      if (widget.user.isVerified) ...[
                        4.horizontalSpace,
                        const Icon(Icons.verified,
                            color: Pallets.blueBubbleColor, size: 15),
                      ],
                    ],
                  ),
                  4.verticalSpace,
                  TextView(
                    text: '@${widget.user.username}',
                    fontSize: 13,
                    color: Pallets.grey400,
                  ),
                  6.verticalSpace,
                  TextView(
                    text: widget.user.bio,
                    fontSize: 13,
                    color: context.colorScheme.onSurface,
                    maxLines: 2,
                    textOverflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            12.horizontalSpace,
            SubscribeButton(
              text: _following ? 'Following' : 'Follow',
              color: _following ? Pallets.grey400 : Pallets.blueBubbleColor,
              onTap: () {
                GuestUserHelper.handleGuestUserAction(action: () {
                  setState(() => _following = !_following);
                });
              },
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
        final entries = MockSearchData.searchGroupEntries;
        return ListView.separated(
          controller: _scrollController,
          padding: EdgeInsets.symmetric(vertical: 8.h),
          itemCount: entries.length,
          separatorBuilder: (_, __) => 8.verticalSpace,
          itemBuilder: (context, index) =>
              _GroupSearchItem(entry: entries[index]),
        );
      },
    );
  }
}

class _GroupSearchItem extends StatefulWidget {
  final MockGroupSearchEntry entry;
  const _GroupSearchItem({required this.entry});

  @override
  State<_GroupSearchItem> createState() => _GroupSearchItemState();
}

class _GroupSearchItemState extends State<_GroupSearchItem> {
  late bool _joined;

  @override
  void initState() {
    super.initState();
    _joined = widget.entry.isJoined;
  }

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
                imageUrl: widget.entry.image,
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
                    text: widget.entry.name,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                  4.verticalSpace,
                  TextView(
                    text:
                        '${_formatCount(widget.entry.memberCount)} Members',
                    fontSize: 13,
                    color: Pallets.grey400,
                  ),
                ],
              ),
            ),
            12.horizontalSpace,
            GestureDetector(
              onTap: () {
                GuestUserHelper.handleGuestUserAction(action: () {
                  setState(() => _joined = !_joined);
                });
              },
              child: Container(
                padding: EdgeInsets.symmetric(
                    horizontal: 18.w, vertical: 8.h),
                decoration: BoxDecoration(
                  color: Pallets.blueBubbleColor,
                  borderRadius: BorderRadius.circular(40.r),
                ),
                child: TextView(
                  text: _joined ? 'Joined' : 'Join',
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
}
