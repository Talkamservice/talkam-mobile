import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talkam/common/widgets/custom_dialogs.dart';
import 'package:talkam/common/widgets/error_widget.dart';
import 'package:talkam/common/widgets/image_widget.dart';
import 'package:talkam/common/widgets/outlined_form_field.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/constants/package_exports.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/features/group/presentation/blocs/groups_cubit/groups_cubit.dart';
import 'package:talkam/features/search/data/models/get_group_response.dart';
import 'package:talkam/gen/assets.gen.dart';

class SelectGroupTab extends StatefulWidget {
  const SelectGroupTab({super.key});

  @override
  State<SelectGroupTab> createState() => _SelectGroupTabState();
}

class _SelectGroupTabState extends State<SelectGroupTab> {
  @override
  void initState() {
    super.initState();
    groupsCubit.getGroups(isFollowing: true); // Assuming fetchGroups method exists in GroupsCubit
  }

  final groupsCubit = GroupsCubit(injector.get());
  var filteredList = <TalkamGroup>[];
  var allLists = <TalkamGroup>[];

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        OutlinedFormField(
          hint: "Search ",
          radius: 100.r,
          onChange: (query) {
            filterList(query);
          },
          preffix: Padding(
            padding: const EdgeInsets.all(16.0),
            child: ImageWidget(imageUrl: Assets.images.svgs.searchMd),
          ),
        ),
        Expanded(
          child: BlocConsumer<GroupsCubit, GroupsState>(
            bloc: groupsCubit,
            listener: (context, state) {
              state.maybeWhen(
                orElse: () => null,
                getGroupsSuccess: (groups, paginationData) {
                  allLists = groups;
                  filteredList = groups;
                  setState(() {});
                },
              );
            },
            builder: (context, state) {
              return state.maybeWhen(
                orElse: () => 0.verticalSpace,
                getGroupsFailure: (error) => AppErrorWidget(

                  onTap: () {


                    groupsCubit.getGroups(isFollowing: true); // Re-fetch groups on error
                  },
                ),
                getGroupsLoading: () => CustomDialogs.getLoading(size: 50),
                getGroupsSuccess: (groups, paginationData) {
                  if (filteredList.isEmpty) {
                    return const Center(
                      child: TextView(text: "There are no groups yet"),
                    );
                  }

                  return ListView.builder(
                    itemCount: filteredList.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: _GroupItem(
                        group: filteredList[index],
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }

  void filterList(String query) {
    if (query.isEmpty) {
      filteredList = allLists;
    } else {
      filteredList = allLists
          .where(
            (element) => element.name!.toLowerCase().contains(query),
          )
          .toList();
    }

    setState(() {});
  }
}

class _GroupItem extends StatelessWidget {
  const _GroupItem({super.key, required this.group});

  final TalkamGroup group;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.pop(group);
      },
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Row(
          children: [
            ImageWidget(
              imageUrl: group.category?.iconImage! ?? Assets.images.png.sports.path,
              size: 30,
            ),
            8.horizontalSpace,
            Expanded(
              child: TextView(
                text: group.name!,
                fontSize: 16,
              ),
            ),
            8.horizontalSpace,
            ImageWidget(imageUrl: Assets.images.svgs.chevronRight)
          ],
        ),
      ),
    );
  }
}
