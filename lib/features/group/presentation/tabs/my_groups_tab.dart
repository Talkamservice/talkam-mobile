import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talkam/common/widgets/custom_dialogs.dart';
import 'package:talkam/common/widgets/error_widget.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/constants/dialog_texts.dart';

import 'package:talkam/core/constants/package_exports.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/core/navigation/route_url.dart';
import 'package:talkam/core/theme/pallets.dart';
import 'package:talkam/features/group/data/models/groups_filter_model.dart';
import 'package:talkam/features/group/presentation/blocs/featured_groups/featured_groups_cubit.dart';
import 'package:talkam/features/group/presentation/blocs/groups_cubit/groups_cubit.dart';
import 'package:talkam/features/group/presentation/screens/refresh_group_listener.dart';
import 'package:talkam/features/group/presentation/widgets/categories_chips.dart';
import 'package:talkam/features/group/presentation/widgets/group_loading_shimmer.dart';
import 'package:talkam/features/group/presentation/widgets/suggested_groups.dart';
import 'package:talkam/features/search/presentation/widget/group_result_item.dart';
import 'package:talkam/core/mock/mock_home_data.dart';

class MyGroupsTab extends StatefulWidget {
  const MyGroupsTab({super.key});

  @override
  State<MyGroupsTab> createState() => _GroupExploreRecentTabState();
}

class _GroupExploreRecentTabState extends State<MyGroupsTab> with AutomaticKeepAliveClientMixin {
  final List<String> _groupCategories = ["Sports", "Technology", "Food & Drinks", "Health", "Politicians"];
  String _selectedTile = '';

  final bloc = GroupsCubit(injector.get());

  @override
  void initState() {
    bloc.getGroups(isFollowing: true);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return RefreshGroupListener(
      onRefresh: () {
        bloc.getGroups(isFollowing: true);
      },
      child: Column(
        children: [
          Expanded(
            child: NestedScrollView(
              headerSliverBuilder: (context, innerBoxIsScrolled) {
                return [];
              },
              body: BlocConsumer<GroupsCubit, GroupsState>(
                bloc: bloc,
                listener: (context, state) {},
                builder: (context, state) {
                  return Column(
                    children: [
                      BlocProvider<FeaturedGroupsCubit>.value(
                        value: injector.get<FeaturedGroupsCubit>(),
                        child: const SuggestedGroups(),
                      ),
                      16.verticalSpace,
                      state.maybeWhen(orElse: () {
                        return AppErrorWidget(
                          onTap: () {
                            bloc.getGroups(isFollowing: true);
                          },
                        );
                      }, getGroupsLoading: () {
                        return const Expanded(
                          child: Center(
                            child: GroupLoadingShimmer(),
                          ),
                        );
                      }, getGroupsSuccess: (groups, paginationData) {
                        final displayGroups = groups.isEmpty ? MockHomeData.privateTalkamGroups : groups;

                        if (displayGroups.isEmpty) {
                          return const Expanded(
                            child: SizedBox(
                              height: 300,
                              child: Center(
                                child: TextView(text: "No groups in this category"),
                              ),
                            ),
                          );
                        }
                        return Expanded(
                          child: RefreshIndicator(
                            onRefresh: () async {
                              bloc.getGroups(isFollowing: true);
                            },
                            child: ListView.builder(
                              itemCount: displayGroups.length,
                              itemBuilder: (context, index) {
                                return Column(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        if (displayGroups[index].isSuspended ?? false) {
                                          CustomDialogs.error("You have been suspended from this group");
                                        } else if (!displayGroups[index].isPublic && !(displayGroups[index].isFollowing ?? false)) {
                                          CustomDialogs.showInfoMessage(context, privateGroupViewText);
                                        } else {
                                          context.pushNamed(PageUrl.groupsInfoScreen, extra: displayGroups[index].id.toString());
                                        }
                                      },
                                      child: GroupResultItem(
                                        group: displayGroups[index],
                                        onJoinStateChanged: () {
                                          bloc.getGroups(shouldRefresh: false, isFollowing: true);
                                        },
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),
                        );
                      }),
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;

  bool stateIsGetGroups(GroupsState previous, GroupsState current) {
    return current.maybeWhen(
      orElse: () => false,
      getGroupsLoading: () => true,
      getGroupsFailure: (error) => true,
      getGroupsSuccess: (__, _) => true,
    );
  }
}
