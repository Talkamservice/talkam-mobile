import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:talkam/common/widgets/custom_dialogs.dart';
import 'package:talkam/core/constants/dialog_texts.dart';
import 'package:talkam/core/navigation/route_url.dart';
import 'package:talkam/core/theme/pallets.dart';
import 'package:talkam/features/group/presentation/screens/refresh_group_listener.dart';
import 'package:talkam/features/post/data/models/get_categories_response.dart';
import 'package:talkam/features/search/presentation/widget/group_result_item.dart';
import 'package:talkam/core/mock/mock_home_data.dart';

class GroupRecentTab extends StatefulWidget {
  const GroupRecentTab({super.key, this.selectedCategory});

  final PostCategory? selectedCategory;

  @override
  State<GroupRecentTab> createState() => _GroupRecentTabState();
}

class _GroupRecentTabState extends State<GroupRecentTab>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    final allGroups = [
      ...MockHomeData.talkamGroups,
      ...MockHomeData.privateTalkamGroups
    ];
    final groups = widget.selectedCategory == null
        ? allGroups
        : allGroups
            .where((group) => group.category?.id == widget.selectedCategory!.id)
            .toList();

    return ListView.builder(
      itemCount: groups.length,
      itemBuilder: (context, index) {
        final group = groups[index];
        return Column(
          children: [
            InkWell(
              onTap: () {
                if (group.isSuspended ?? false) {
                  CustomDialogs.error(
                      "You have been suspended from this group");
                } else if (!group.isPublic && !(group.isFollowing ?? false)) {
                  CustomDialogs.showInfoMessage(context, privateGroupViewText);
                } else {
                  context.pushNamed(PageUrl.groupsInfoScreen,
                      extra: group.id.toString());
                }
              },
              child: GroupResultItem(
                group: group,
                onJoinStateChanged: () {},
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
