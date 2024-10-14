import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:talkam/common/widgets/error_widget.dart';
import 'package:talkam/common/widgets/image_widget.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/core/navigation/route_url.dart';
import 'package:talkam/core/theme/pallets.dart';
import 'package:talkam/features/group/presentation/blocs/groups_cubit/groups_cubit.dart';
import 'package:talkam/features/group/presentation/widgets/join_group_button.dart';
import 'package:talkam/features/group/presentation/widgets/suggestion_shimmer.dart';
import 'package:talkam/features/search/data/models/get_group_response.dart';

class SuggestedGroups extends StatefulWidget {
  const SuggestedGroups({
    super.key,
  });

  @override
  State<SuggestedGroups> createState() => _SuggestedGroupsState();
}

class _SuggestedGroupsState extends State<SuggestedGroups> {
  final bloc = GroupsCubit(injector.get());

  @override
  void initState() {
    bloc.getRecommendedGroups();
    super.initState();
  }

  bool isViible = true;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: isViible,
      child: BlocConsumer<GroupsCubit, GroupsState>(
        bloc: bloc,
        listener: (context, state) {},
        buildWhen: stateIsRecommended,
        builder: (context, state) {
          return state.maybeWhen(
            orElse: () {
              return 0.verticalSpace;
              // return AppPromptWidget(
              //   onTap: () {
              //     context.read<GroupsCubit>().getRecommendedGroups();
              //   },
              // );
            },
            getRecommendedSuccess: (response) {
              if (response.groups!.isNotEmpty) {
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 24.0, right: 18.0, left: 18.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextView(
                            text: "Suggested",
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w700,
                          ),
                          InkWell(
                            onTap: () {
                              isViible = false;
                              setState(() {});
                            },
                            child: const Icon(Icons.close,
                                size: 28, color: Pallets.boldBlackV2),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 18.0, bottom: 10),
                      child: SizedBox(
                        width: double.infinity,
                        height: 100.h,
                        child: ListView.separated(
                          padding: const EdgeInsets.symmetric(horizontal: 18),
                          scrollDirection: Axis.horizontal,
                          itemCount: response.groups!.length,
                          separatorBuilder: (_, __) => 14.horizontalSpace,
                          itemBuilder: (_, int index) {
                            return _SuggestedTile(
                              onTap: () {
                                context.pushNamed(PageUrl.groupsInfoScreen,
                                    extra:
                                        response.groups![index].id.toString());
                              },
                              group: response.groups![index],
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                );
              }

              return 0.verticalSpace;
            },
            getRecommendedFailure: (error) {
              return AppErrorWidget(
                message: error,
                showImage: false,
                onTap: () {
                  bloc.getRecommendedGroups();
                },
              );
            },
            getRecommendedLoading: () {
              // return 0.verticalSpace;

              return const SuggestionsShimmer();
            },
          );
        },
      ),
    );
  }

  bool stateIsRecommended(GroupsState previous, GroupsState current) {
    return current.maybeWhen(
      orElse: () => false,
      getRecommendedLoading: () => true,
      getRecommendedFailure: (error) => true,
      getRecommendedSuccess: (response) => true,
    );
  }
}

class _SuggestedTile extends StatelessWidget {
  final VoidCallback onTap;
  final TalkamGroup group;

  const _SuggestedTile({super.key, required this.onTap, required this.group});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap.call();
      },
      child: Container(
        width: 268.w,
        height: 100.h,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.0),
            border: Border.all(color: Pallets.borderGrey, width: 1.5)),
        child: Row(
          children: [
            ImageWidget(
              imageUrl: group.image.toString(),
              width: 93.w,
              height: 80.h,
              borderRadius: BorderRadius.circular(8.0),
            ),
            12.horizontalSpace,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextView(
                    text: group.name.toString(),
                    fontWeight: FontWeight.w700,
                    fontSize: 16.sp,
                    maxLines: 1,
                    textOverflow: TextOverflow.ellipsis,
                    color: Pallets.boldBlackV2,
                  ),
                  TextView(
                    text: "${group.totalMembers} Members",
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w500,
                    color: Pallets.boldBlackV2,
                  ),
                  2.verticalSpace,
                  Container(
                    width: 65,
                    height: 25,
                    decoration: BoxDecoration(
                      color: Pallets.tabBarBlue,
                      borderRadius: BorderRadius.circular(22.0),
                    ),
                    child: const Center(
                      child: TextView(
                        text: "View",
                        fontWeight: FontWeight.w700,
                        color: Pallets.white,
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
