import 'package:flutter/material.dart';
import 'package:talkam/features/ads/presentation/widgets/post_ad_item.dart';
import 'package:talkam/features/post/data/models/post_test_models.dart';

class RunningAdsScreen extends StatelessWidget {
  const RunningAdsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: PostAdItem(post: TestFactories.createTalkamPost(),
          ),
        ),
      ),
    );
  }
}
