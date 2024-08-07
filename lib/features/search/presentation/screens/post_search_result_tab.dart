import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:talkam/features/post/data/models/post_test_models.dart';
import 'package:talkam/features/post/presentation/widgets/post_item.dart';

class PostSearchResultTab extends StatefulWidget {
  const PostSearchResultTab({super.key});

  @override
  State<PostSearchResultTab> createState() => _PostSearchResultTabState();
}

class _PostSearchResultTabState extends State<PostSearchResultTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
              child: ListView.builder(
            itemBuilder: (context, index) =>
                PostItem(post: TestFactories.createTalkamPost()),
          ))
        ],
      ),
    );
  }
}
