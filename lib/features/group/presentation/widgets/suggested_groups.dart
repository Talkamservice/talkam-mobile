import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:talkam/common/widgets/image_widget.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/core/navigation/route_url.dart';
import 'package:talkam/core/theme/pallets.dart';
import 'package:talkam/features/ads/presentation/widgets/ad_indicator.dart';
import 'package:talkam/features/group/presentation/blocs/featured_groups/featured_groups_cubit.dart';
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
        final groups = state.maybeWhen(
          orElse: () => const <TalkamGroup>[],
          getRecommendedSuccess: (response) => response.groups ?? [],
        );

        if (groups.isEmpty) {
          return 0.verticalSpace;
        }

        return Column(
          children: [
            Padding(
              padding:
                  const EdgeInsets.only(top: 24.0, right: 18.0, left: 18.0),
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
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  scrollDirection: Axis.horizontal,
                  itemCount: groups.length,
                  separatorBuilder: (_, __) => 14.horizontalSpace,
                  itemBuilder: (_, int index) {
                    return _SuggestedTile(
                      onTap: () {
                        context.pushNamed(PageUrl.groupsInfoScreen,
                            extra: groups[index].id.toString());
                      },
                      group: groups[index],
                    );
                  },
                ),
              ),
            ),
          ],
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
                      Container(
                        decoration: BoxDecoration(
                          color: Pallets.blueBubbleColor,
                          borderRadius: BorderRadius.circular(22.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12.0, vertical: 4),
                          child: TextView(
                            text: "Join",
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
