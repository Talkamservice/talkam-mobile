import 'package:flutter/material.dart';
import 'package:talkam/features/ads/presentation/widget/post_ad_item.dart';
import 'package:talkam/features/post/data/models/get_posts_response.dart';
import 'package:talkam/features/post/data/models/post_test_models.dart';

class RunningAdsScreen extends StatefulWidget {
  const RunningAdsScreen({super.key});

  @override
  State<RunningAdsScreen> createState() => _RunningAdsScreenState();
}

class _RunningAdsScreenState extends State<RunningAdsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(

        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              PostAdItem(post: TestFactories.createTalkamPost())
            ],
          ),
        ),
      ),
    );
  }
}
