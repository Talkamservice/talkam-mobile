import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:talkam/common/widgets/animated_diff_list.dart';
import 'package:talkam/common/widgets/image_widget.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/core/navigation/route_url.dart';
import 'package:talkam/core/theme/pallets.dart';
import 'package:talkam/features/ads/presentation/widgets/ad_indicator.dart';
import 'package:talkam/features/group/presentation/blocs/featured_groups/featured_groups_cubit.dart';
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
  @override
  void initState() {
    injector.get<FeaturedGroupsCubit>().getRecommendedGroups();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FeaturedGroupsCubit, FeaturedGroupsState>(
      bloc: injector.get<FeaturedGroupsCubit>(),
      builder: (context, state) {
        return state.maybeWhen(
          orElse: () => 0.verticalSpace,
          getRecommendedLoading: () => const SuggestionsShimmer(),
          getRecommendedSuccess: (response) {
            final groups = response.groups ?? [];
            if (groups.isEmpty) {
              return 0.verticalSpace;
            }

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
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 18.0, bottom: 10),
                  child: SizedBox(
                    width: double.infinity,
                    height: 100.h,
                    child: AnimatedDiffList<TalkamGroup>(
                      padding: const EdgeInsets.symmetric(horizontal: 18),
                      scrollDirection: Axis.horizontal,
                      items: groups,
                      keyOf: (group) => group.id!,
                      itemBuilder: (context, group, index) {
                        return Padding(
                          padding: EdgeInsets.only(
                              right: index == groups.length - 1 ? 0 : 14),
                          child: _SuggestedTile(
                            onTap: () {
                              context.pushNamed(PageUrl.groupsInfoScreen,
                                  extra: group.id.toString());
                            },
                            group: group,
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
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
      child: Stack(
        children: [
          Container(
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
                      Theme(
                        data: Theme.of(context).copyWith(
                          textButtonTheme: TextButtonThemeData(
                            style: TextButton.styleFrom(
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                          ),
                        ),
                        child: IntrinsicWidth(
                          child: JoinGroupButton(
                            group: group,
                            showIcon: false,
                            onStateChanged: () {
                              // JoinGroupButton already mutated
                              // group.isFollowing/hasRequested by the time
                              // this fires, so only remove it from
                              // Suggested when the user actually joined or
                              // requested to join — not when they just
                              // cancelled a pending request, which should
                              // leave the group suggested.
                              final joinedOrRequested =
                                  (group.isFollowing ?? false) ||
                                      (group.hasRequested ?? false);
                              if (joinedOrRequested) {
                                injector
                                    .get<FeaturedGroupsCubit>()
                                    .removeGroupLocally(group.id!);
                              }
                              injector
                                  .get<GroupsCubit>()
                                  .refreshAllGroupLists(silent: true);
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          if (group.isPromoted)
            Positioned(
                left: 2,
                bottom: 1,
                child: AdIndicator(
                  promoter: "",
                  padding: 4,
                )),
        ],
      ),
    );
  }
}
