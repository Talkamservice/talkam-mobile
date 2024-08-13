import 'package:flutter/material.dart';
import 'package:talkam/features/post/data/models/post_test_models.dart';
import 'package:talkam/features/post/presentation/widgets/post_item.dart';

class GroupPostsTab extends StatefulWidget {
  const GroupPostsTab({super.key});

  @override
  State<GroupPostsTab> createState() => _GroupPostsTabState();
}

class _GroupPostsTabState extends State<GroupPostsTab> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.zero,
            itemBuilder: (context, index) {
              return PostItem(post: TestFactories.createTalkamPost());
            },
          ),
        )
      ],
    );
  }
}
