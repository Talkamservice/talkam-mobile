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
import 'package:talkam/features/group/presentation/blocs/groups_cubit/groups_cubit.dart';
import 'package:talkam/features/group/presentation/screens/refresh_group_listener.dart';
import 'package:talkam/features/group/presentation/widgets/categories_chips.dart';
import 'package:talkam/features/group/presentation/widgets/suggested_groups.dart';
import 'package:talkam/features/search/presentation/widget/group_result_item.dart';

class GroupExploreTab extends StatefulWidget {
  const GroupExploreTab({super.key});

  @override
  State<GroupExploreTab> createState() => _GroupExploreRecentTabState();
}

class _GroupExploreRecentTabState extends State<GroupExploreTab> with AutomaticKeepAliveClientMixin {
  final List<String> _groupCategories = ["Sports", "Technology", "Food & Drinks", "Health", "Politicians"];
  String _selectedTile = '';

  // final bloc = GroupsCubit(injector.get());

  @override
  void initState() {
    injector.get<GroupsCubit>().getGroups();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshGroupListener(
      onRefresh: () {
        injector.get<GroupsCubit>().getGroups();

      },
      child: Column(
        children: [
          Expanded(
            child: NestedScrollView(
              headerSliverBuilder: (context, innerBoxIsScrolled) {
                return [
                  SliverToBoxAdapter(
                    child: Column(
                      children: [
                        CategoriesChips(
                          onSelected: (p0) {
                            injector.get<GroupsCubit>().getGroups(filter: GroupsFilterModel(category: p0?.id.toString()));
                          },
                        ),
                        BlocProvider<GroupsCubit>.value(
                          value: injector.get<GroupsCubit>(),
                          child: const SuggestedGroups(),
                        ),
                        16.verticalSpace,
                      ],
                    ),
                  ),
                ];
              },
              body: BlocConsumer<GroupsCubit, GroupsState>(
                bloc: injector.get<GroupsCubit>(),
                listener: (context, state) {},
                builder: (context, state) {
                  return Column(
                    children: [
                      state.maybeWhen(orElse: () {
                        return AppErrorWidget(
                          onTap: () {
                            injector.get<GroupsCubit>().getGroups();
                          },
                        );
                      }, getGroupsLoading: () {
                        return SizedBox(
                          height: 200,
                          child: Center(
                            child: CustomDialogs.getLoading(size: 50),
                          ),
                        );
                      }, getGroupsSuccess: (groups, paginationData) {
                        if (groups.isEmpty) {
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
                              injector.get<GroupsCubit>().getGroups();
                            },
                            child: ListView.builder(
                              itemCount: groups.length,
                              itemBuilder: (context, index) {
                                return Column(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        if (groups[index].isSuspended ?? false) {
                                          CustomDialogs.error("You have been suspended from this group");
                                        } else if (!groups[index].isPublic && !(groups[index].isFollowing ?? false)) {
                                          CustomDialogs.showInfoMessage(context, privateGroupViewText);
                                        } else {
                                          context.pushNamed(PageUrl.groupsInfoScreen, extra: groups[index].id.toString());
                                        }
                                      },
                                      child: GroupResultItem(
                                        group: groups[index],
                                        onJoinStateChanged: () {
                                          injector.get<GroupsCubit>().getGroups(shouldRefresh: false);
                                        },
                                      ),
                                    ),
                                    Container(height: 1.0, color: Pallets.borderGrey),
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
