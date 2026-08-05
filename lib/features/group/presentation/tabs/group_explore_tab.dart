import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:talkam/core/mock/mock_home_data.dart';
import 'package:talkam/features/group/presentation/widgets/suggested_groups.dart';
import 'package:talkam/features/post/presentation/widgets/post_item.dart';

class GroupExploreTab extends StatefulWidget {
  const GroupExploreTab({super.key});

  @override
  State<GroupExploreTab> createState() => _GroupExploreRecentTabState();
}

class _GroupExploreRecentTabState extends State<GroupExploreTab> with AutomaticKeepAliveClientMixin {
  
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SuggestedGroups(),
              16.verticalSpace,
            ],
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              final post = MockHomeData.posts[index];
              return PostItem(post: post);
            },
            childCount: MockHomeData.posts.length,
          ),
        ),
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}
