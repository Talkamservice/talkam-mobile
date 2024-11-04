import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../common/widgets/image_widget.dart';
import '../../../../gen/assets.gen.dart';

class AnalyticsReactionsBar extends StatelessWidget {
  const AnalyticsReactionsBar({super.key, required this.comments, required this.likes, required this.dislikes, required this.shares});

  final int comments;
  final int likes;
  final int dislikes;
  final int shares;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: Colors.blue.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12)
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  ImageWidget(imageUrl: Assets.images.svgs.comment, color: Colors.black,),
                  4.horizontalSpace,
                   Text("$comments")
                ],
              ),
              Row(
                children: [
                  ImageWidget(
                    imageUrl: Assets.images.svgs.thumbsUp,
                    color: Colors.black,
                  ),
                  4.horizontalSpace,
                   Text("$likes")
                ],
              ),
              Row(
                children: [
                  ImageWidget(
                      imageUrl: Assets.images.svgs.thumbsDownSvg_,
                      color: Colors.black
                  ),
                  4.horizontalSpace,
                    Text("$dislikes")
                ],
              ),
              Row(
                children: [
                  ImageWidget(imageUrl: Assets.images.svgs.adShare, color: Colors.black,),
                  3.horizontalSpace,
                   Text("$shares")
                ],
              ),
            ],
          ),
        )
    );
  }
}
