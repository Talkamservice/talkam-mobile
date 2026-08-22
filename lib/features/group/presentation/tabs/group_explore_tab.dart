import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talkam/common/widgets/custom_dialogs.dart';
import 'package:talkam/common/widgets/error_widget.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/constants/dialog_texts.dart';
import 'package:talkam/core/constants/package_exports.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/core/navigation/route_url.dart';
import 'package:talkam/features/group/data/models/groups_filter_model.dart';
import 'package:talkam/features/group/presentation/blocs/featured_groups/featured_groups_cubit.dart';
import 'package:talkam/features/group/presentation/blocs/groups_cubit/groups_cubit.dart';
import 'package:talkam/features/group/presentation/screens/refresh_group_listener.dart';
import 'package:talkam/features/group/presentation/widgets/group_loading_shimmer.dart';
import 'package:talkam/features/group/presentation/widgets/suggested_groups.dart';
import 'package:talkam/features/post/data/models/get_categories_response.dart';
import 'package:talkam/features/search/presentation/widget/group_result_item.dart';

class GroupExploreTab extends StatefulWidget {
  const GroupExploreTab({super.key, this.selectedCategory});

  final PostCategory? selectedCategory;

  @override
  State<GroupExploreTab> createState() => _GroupExploreRecentTabState();
}

class _GroupExploreRecentTabState extends State<GroupExploreTab>
    with AutomaticKeepAliveClientMixin {
  final bloc = GroupsCubit(injector.get());
  final _scrollController = ScrollController();

  GroupsFilterModel? get _filter => widget.selectedCategory == null
      ? null
      : GroupsFilterModel(category: widget.selectedCategory!.id.toString());

  @override
  void initState() {
    bloc.getGroups(filter: _filter);
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 300) {
        final state = bloc.state;
        state.maybeWhen(
          orElse: () {},
          getGroupsSuccess: (groups, paginationData) {
            bloc.fetchNextPage(groups, paginationData, filter: _filter);
          },
        );
      }
    });
    super.initState();
  }

  @override
  void didUpdateWidget(covariant GroupExploreTab oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.selectedCategory?.id != widget.selectedCategory?.id) {
      bloc.getGroups(filter: _filter);
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return RefreshGroupListener(
      onRefresh: () {
        bloc.getGroups(filter: _filter);
      },
      child: BlocConsumer<GroupsCubit, GroupsState>(
        bloc: bloc,
        listener: (context, state) {},
        builder: (context, state) {
          return CustomScrollView(
            controller: _scrollController,
            slivers: [
              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BlocProvider<FeaturedGroupsCubit>.value(
                      value: injector.get<FeaturedGroupsCubit>(),
                      child: const SuggestedGroups(),
                    ),
                    16.verticalSpace,
                  ],
                ),
              ),
              state.maybeWhen(
                orElse: () => SliverToBoxAdapter(
                  child: AppErrorWidget(
                    onTap: () => bloc.getGroups(filter: _filter),
                  ),
                ),
                getGroupsLoading: () => const SliverToBoxAdapter(
                  child: Center(child: GroupLoadingShimmer()),
                ),
                getGroupsSuccess: (groups, paginationData) {
                  if (groups.isEmpty) {
                    return const SliverToBoxAdapter(
                      child: SizedBox(
                        height: 300,
                        child: Center(
                          child: TextView(text: "No groups in this category"),
                        ),
                      ),
                    );
                  }

                  return SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final group = groups[index];
                        return InkWell(
                          onTap: () {
                            if (group.isSuspended ?? false) {
                              CustomDialogs.error(
                                  "You have been suspended from this group");
                            } else if (!group.isPublic &&
                                !(group.isFollowing ?? false)) {
                              CustomDialogs.showInfoMessage(
                                  context, privateGroupViewText);
                            } else {
                              context.pushNamed(PageUrl.groupsInfoScreen,
                                  extra: group.id.toString());
                            }
                          },
                          child: GroupResultItem(
                            group: group,
                            onJoinStateChanged: () {
                              bloc.getGroups(
                                  shouldRefresh: false, filter: _filter);
                            },
                          ),
                        );
                      },
                      childCount: groups.length,
                    ),
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
