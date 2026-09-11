import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talkam/common/widgets/custom_dialogs.dart';
import 'package:talkam/common/widgets/error_widget.dart';
import 'package:talkam/common/widgets/image_widget.dart';
import 'package:talkam/common/widgets/outlined_form_field.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/constants/package_exports.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/core/theme/pallets.dart';
import 'package:talkam/features/group/presentation/blocs/groups_cubit/groups_cubit.dart';
import 'package:talkam/features/search/data/models/get_group_response.dart';
import 'package:talkam/gen/assets.gen.dart';

/// Bottom sheet for attaching a post to one of the groups the user is
/// already a member of — see [showCreatePostSheet]'s `group` param and
/// `CreatePostSheet`'s "Add to group" pill.
class SelectGroupTab extends StatefulWidget {
  const SelectGroupTab({super.key});

  @override
  State<SelectGroupTab> createState() => _SelectGroupTabState();
}

class _SelectGroupTabState extends State<SelectGroupTab> {
  final groupsCubit = GroupsCubit(injector.get());
  var filteredList = <TalkamGroup>[];
  var allLists = <TalkamGroup>[];

  @override
  void initState() {
    super.initState();
    groupsCubit.getGroups(isJoined: true);
  }

  @override
  void dispose() {
    groupsCubit.close();
    super.dispose();
  }

  void filterList(String query) {
    final q = query.toLowerCase();
    setState(() {
      filteredList = q.isEmpty
          ? allLists
          : allLists
              .where((group) => (group.name ?? '').toLowerCase().contains(q))
              .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 0.75.sh,
      decoration: BoxDecoration(
        color: Pallets.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24.r),
          topRight: Radius.circular(24.r),
        ),
      ),
      child: Column(
        children: [
          // ── Handle bar ─────────────────────────────────────────────
          Padding(
            padding: EdgeInsets.only(top: 12.h, bottom: 16.h),
            child: Container(
              width: 48.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: Pallets.boldBlackV2,
                borderRadius: BorderRadius.circular(4.r),
              ),
            ),
          ),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Align(
                  alignment: Alignment.centerLeft,
                  child: TextView(
                    text: "Select a group",
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Pallets.boldBlackV2,
                  ),
                ),
                12.verticalSpace,
                OutlinedFormField(
                  hint: "Search your groups",
                  radius: 100.r,
                  onChange: filterList,
                  preffix: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: ImageWidget(imageUrl: Assets.images.svgs.searchMd),
                  ),
                ),
              ],
            ),
          ),
          12.verticalSpace,

          Expanded(
            child: BlocConsumer<GroupsCubit, GroupsState>(
              bloc: groupsCubit,
              listener: (context, state) {
                state.maybeWhen(
                  orElse: () => null,
                  getGroupsSuccess: (groups, paginationData) {
                    setState(() {
                      allLists = groups;
                      filteredList = groups;
                    });
                  },
                );
              },
              builder: (context, state) {
                return state.maybeWhen(
                  orElse: () => const SizedBox.shrink(),
                  getGroupsFailure: (error) => Center(
                    child: AppErrorWidget(
                      message: error,
                      onTap: () => groupsCubit.getGroups(isJoined: true),
                    ),
                  ),
                  getGroupsLoading: () =>
                      Center(child: CustomDialogs.getLoading(size: 50)),
                  getGroupsSuccess: (groups, paginationData) {
                    if (filteredList.isEmpty) {
                      return Center(
                        child: TextView(
                          text: allLists.isEmpty
                              ? "You haven't joined any groups yet"
                              : "No groups match your search",
                          fontSize: 14,
                          color: Pallets.grey400,
                        ),
                      );
                    }

                    return ListView.separated(
                      padding: EdgeInsets.symmetric(
                        horizontal: 24.w,
                        vertical: 8.h,
                      ),
                      itemCount: filteredList.length,
                      separatorBuilder: (context, index) => 4.verticalSpace,
                      itemBuilder: (context, index) => _GroupItem(
                        group: filteredList[index],
                      ),
                    );
                  },
                );
              },
            ),
          ),
          8.verticalSpace,
        ],
      ),
    );
  }
}

class _GroupItem extends StatelessWidget {
  const _GroupItem({required this.group});

  final TalkamGroup group;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(12.r),
      onTap: () => Navigator.of(context).pop(group),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 8.h),
        child: Row(
          children: [
            ImageWidget(
              imageUrl: group.image ?? Assets.images.svgs.user,
              size: 40,
              shape: BoxShape.circle,
            ),
            12.horizontalSpace,
            Expanded(
              child: TextView(
                text: group.name ?? "Untitled group",
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: Pallets.boldBlackV2,
                maxLines: 1,
                textOverflow: TextOverflow.ellipsis,
              ),
            ),
            8.horizontalSpace,
            Icon(Icons.chevron_right_rounded,
                color: Pallets.grey400, size: 22.w),
          ],
        ),
      ),
    );
  }
}
