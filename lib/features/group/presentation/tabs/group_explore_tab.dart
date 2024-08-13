import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talkam/common/widgets/custom_dialogs.dart';
import 'package:talkam/common/widgets/error_widget.dart';
import 'package:talkam/common/widgets/text_view.dart';

import 'package:talkam/core/constants/package_exports.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/core/navigation/route_url.dart';
import 'package:talkam/core/theme/pallets.dart';
import 'package:talkam/features/group/data/models/groups_filter_model.dart';
import 'package:talkam/features/group/presentation/blocs/groups_cubit/groups_cubit.dart';
import 'package:talkam/features/group/presentation/widgets/categories_chips.dart';
import 'package:talkam/features/group/presentation/widgets/suggested_groups.dart';
import 'package:talkam/features/search/presentation/widget/group_result_item.dart';

class GroupExploreTab extends StatefulWidget {
  const GroupExploreTab({super.key});

  @override
  State<GroupExploreTab> createState() => _GroupExploreRecentTabState();
}

class _GroupExploreRecentTabState extends State<GroupExploreTab>
    with AutomaticKeepAliveClientMixin {
  final List<String> _groupCategories = [
    "Sports",
    "Technology",
    "Food & Drinks",
    "Health",
    "Politicians"
  ];
  String _selectedTile = '';
  final bloc = GroupsCubit(injector.get());

  @override
  void initState() {
    bloc.getGroups();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
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
                          bloc.getGroups(
                              filter: GroupsFilterModel(
                                  category: p0?.id.toString()));
                        },
                      ),
                      BlocProvider<GroupsCubit>.value(
                        value: bloc,
                        child: const SuggestedGroups(),
                      ),
                    ],
                  ),
                ),
              ];
            },
            body: BlocConsumer<GroupsCubit, GroupsState>(
              bloc: bloc,
              listener: (context, state) {},
              builder: (context, state) {
                return Column(
                  children: [
                    state.maybeWhen(orElse: () {
                      return AppPromptWidget(
                        onTap: () {
                          bloc.getGroups();
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
                        return const SizedBox(
                          height: 300,
                          child: Center(
                            child: TextView(text: "No groups in this category"),
                          ),
                        );
                      }
                      return Expanded(
                        child: RefreshIndicator(
                          onRefresh: () async {
                            bloc.getGroups();
                          },
                          child: ListView.builder(
                            itemCount: groups.length,
                            itemBuilder: (context, index) {
                              return Column(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      context.pushNamed(
                                          PageUrl.groupsInfoScreen,
                                          extra: groups[index]);
                                    },
                                    child:
                                        GroupResultItem(group: groups[index]),
                                  ),
                                  Container(
                                      height: 1.0, color: Pallets.borderGrey),
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
