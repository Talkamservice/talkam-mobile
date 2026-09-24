import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:talkam/common/widgets/custom_dialogs.dart';
import 'package:talkam/common/widgets/error_widget.dart';
import 'package:talkam/common/widgets/image_widget.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/constants/dialog_texts.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/core/navigation/route_url.dart';
import 'package:talkam/features/group/data/models/groups_filter_model.dart';
import 'package:talkam/features/group/presentation/blocs/groups_cubit/groups_cubit.dart';
import 'package:talkam/features/home/presentation/bloc/drawer/drawer_cubit.dart';
import 'package:talkam/features/post/data/models/get_categories_response.dart';
import 'package:talkam/features/search/presentation/widget/group_result_item.dart';
import 'package:talkam/gen/assets.gen.dart';

class CategoryGroupList extends StatefulWidget {
  const CategoryGroupList({super.key, required this.category});

  final PostCategory category;

  @override
  State<CategoryGroupList> createState() => _CategoryGroupListState();
}

class _CategoryGroupListState extends State<CategoryGroupList> {
  // widget.category comes from the interest-topics taxonomy (see
  // CategoryList, which is what the user actually picks "Addiction" from),
  // so groups have to be filtered by that same id space — GroupsCubit's v2
  // `getGroups(categoryId: ...)` is what the Groups screen's own category
  // chips already use successfully for exactly this. The old
  // `PostEvent.getCategories(mergeGroups: true)` call queried the older,
  // unrelated `/user/post-categories` id space, so it could never actually
  // return this category's groups.
  final groupsCubit = GroupsCubit(injector.get());

  GroupsFilterModel get _filter =>
      GroupsFilterModel(category: widget.category.id.toString());

  @override
  void initState() {
    groupsCubit.getGroups(filter: _filter);
    super.initState();
  }

  @override
  void dispose() {
    groupsCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          10.verticalSpace,
          InkWell(
            onTap: () {
              context.read<DrawerCubit>().switchView(DrawerView.category, subCategory: widget.category);
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  IgnorePointer(
                    child: ImageWidget(
                      imageUrl: Assets.images.png.back1.path,
                      size: 30,
                      fit: BoxFit.cover,
                    ),
                  ),
                  16.horizontalSpace,
                  Expanded(
                    child: TextView(
                      text: widget.category.name,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
          8.verticalSpace,
          BlocConsumer<GroupsCubit, GroupsState>(
            bloc: groupsCubit,
            listener: (context, state) {},
            builder: (context, state) {
              return state.maybeWhen(
                orElse: () => 0.verticalSpace,
                getGroupsFailure: (error) => AppErrorWidget(
                  onTap: () => groupsCubit.getGroups(filter: _filter),
                ),
                getGroupsLoading: () => SizedBox(height: 300, child: CustomDialogs.getLoading(size: 50)),
                getGroupsSuccess: (groups, paginationData) {
                  if (groups.isEmpty) {
                    return const SizedBox(
                      height: 300,
                      child: Center(
                        child: TextView(text: "No groups in this category"),
                      ),
                    );
                  }

                  return ListView.builder(
                    itemCount: groups.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      final group = groups[index];
                      return InkWell(
                        onTap: () {
                          context.read<DrawerCubit>().closeDrawer();

                          if (group.isSuspended ?? false) {
                            CustomDialogs.error("You have been suspended from this group");
                          } else if (!group.isPublic && !(group.isFollowing ?? false)) {
                            CustomDialogs.showInfoMessage(context, privateGroupViewText);
                          } else {
                            context.pushNamed(PageUrl.groupsInfoScreen, extra: group.id.toString());
                          }
                        },
                        child: GroupResultItem(
                          group: group,
                          onJoinStateChanged: () => groupsCubit.getGroups(filter: _filter),
                        ),
                      );
                    },
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
