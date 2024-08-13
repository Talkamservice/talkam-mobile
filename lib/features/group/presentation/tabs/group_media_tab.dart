import 'package:flutter/material.dart';
import 'package:talkam/features/post/data/models/post_test_models.dart';
import 'package:talkam/features/post/presentation/widgets/post_item.dart';

class GroupMediaTab extends StatefulWidget {
  const GroupMediaTab({super.key});

  @override
  State<GroupMediaTab> createState() => _GroupMediaTabState();
}

class _GroupMediaTabState extends State<GroupMediaTab> {
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
