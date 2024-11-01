import 'package:flutter/material.dart';
import 'package:talkam/common/widgets/custom_dialogs.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/constants/package_exports.dart';
import 'package:talkam/core/theme/pallets.dart';
import 'package:talkam/core/utils/extensions/context_extension.dart';
import 'package:talkam/features/post/data/models/get_posts_response.dart';
import 'package:talkam/features/post/presentation/widgets/post_action_sheet.dart';
import 'package:talkam/features/post/presentation/widgets/post_content.dart';
import 'package:talkam/features/post/presentation/widgets/post_item_components.dart';
import '../../../../../common/widgets/custom_appbar.dart';
import '../../../../../common/widgets/image_widget.dart';
import '../../../../../gen/assets.gen.dart';


class ViewAnalyticsPage extends StatelessWidget {
  const ViewAnalyticsPage ({super.key, required this.post});

  final TalkamPost post;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CustomAppBar(
          padding: EdgeInsets.only(right: 10.0),
          tittleText: "Back",
          centerTile: false,
          showDivider: true,
        ),
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.only(left:16, right:16, top:20,),
          child: ListView(
            children: [
              Container(
                decoration: BoxDecoration(color: context.theme.cardColor, borderRadius: BorderRadius.circular(10), border: Border.all(color: Pallets.borderGrey)),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                    PostHeader(
                      showGroupAndCategory: true,
                      userName: "sample username",
                      enablePromoteAddPill: false,
                      post: post,
                      category: post.category,
                      onMenuTap: () async {
                        var isReported = await CustomDialogs.showBottomSheet(
                            context,
                            PostActionSheet(
                              post: post,
                              onPostDeleted: () {},
                            ));
                        if (isReported ?? false) {
                          post.isReported = true;
                        }
                      },
                    ),
                    10.verticalSpace,
                    PostContent(
                      post: post,
                      mediaHeight: 113,
                    ),
                  ],
                ),
              ),
            ),
              14.verticalSpace,
              Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(color: context.theme.cardColor, borderRadius: BorderRadius.circular(10), border: Border.all(color: Pallets.borderGrey)),
                child: Column(
                  children: [
                    Container(
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
                                  const Text("20")
                              ],
                              ),
                              Row(
                                children: [
                              ImageWidget(
                              imageUrl: Assets.images.svgs.thumbsUp,
                                color: Colors.black,
                              ),
                                4.horizontalSpace,
                                const Text("50")
                              ],
                              ),
                              Row(
                                children: [
                                  ImageWidget(
                                    imageUrl: Assets.images.svgs.thumbsDownSvg_,
                                    color: Colors.black
                                  ),
                                  4.horizontalSpace,
                                const Text("10")
                              ],
                              ),
                              Row(
                                children: [
                                  ImageWidget(imageUrl: Assets.images.svgs.share, color: Colors.black,),
                                  3.horizontalSpace,
                                  const Text("30")
                              ],
                              ),
                            ],
                          ),
                        )
                    ),
                    10.verticalSpace,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const TextView(
                                  text: "Impressions",
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: Pallets.textGrey,
                                ),
                                5.horizontalSpace,
                                ImageWidget(imageUrl: Assets.images.svgs.infoCircle, height: 13.33, width: 13.33, color: const Color(0xFF858585), )
                              ],
                            ),
                            8.verticalSpace,
                            const TextView(
                              text: "1,000",
                              fontSize: 16,
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const TextView(
                                  text: "Engagements",
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: Pallets.textGrey,
                                ),
                                5.horizontalSpace,
                                ImageWidget(imageUrl: Assets.images.svgs.infoCircle, height: 13.33, width: 13.33, color: const Color(0xFF858585), )
                              ],
                            ),
                            8.verticalSpace,
                            const TextView(
                              text: "40",
                              fontSize: 16,
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const TextView(
                                  text: "New followers",
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: Pallets.textGrey,
                                ),
                                5.horizontalSpace,
                                ImageWidget(imageUrl: Assets.images.svgs.infoCircle, height: 13.33, width: 13.33, color: const Color(0xFF858585), )
                              ],
                            ),
                            8.verticalSpace,
                            const TextView(
                              text: "20",
                              fontSize: 16,
                            ),
                          ],
                        )
                      ],
                    ),
                    15.verticalSpace,
                    const Divider(
                      thickness: 1,
                      color: Pallets.buttonGrey,
                    ),
                    15.verticalSpace,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const TextView(
                                  text: "Profile visit",
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: Pallets.textGrey,
                                ),
                                5.horizontalSpace,
                                ImageWidget(imageUrl: Assets.images.svgs.infoCircle, height: 13.33, width: 13.33, color: const Color(0xFF858585), )
                              ],
                            ),
                            8.verticalSpace,
                            const TextView(
                              text: "600",
                              fontSize: 16,
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const TextView(
                                  text: "Clicks",
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: Pallets.textGrey,
                                ),
                                5.horizontalSpace,
                                ImageWidget(imageUrl: Assets.images.svgs.infoCircle, height: 13.33, width: 13.33, color: const Color(0xFF858585), )
                              ],
                            ),
                            8.verticalSpace,
                            const TextView(
                              text: "200",
                              fontSize: 16,
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const TextView(
                                  text: "Profile visit",
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: Pallets.textGrey,
                                ),
                                5.horizontalSpace,
                                ImageWidget(imageUrl: Assets.images.svgs.infoCircle, height: 13.33, width: 13.33, color: const Color(0xFF858585), )
                              ],
                            ),
                            8.verticalSpace,
                            const TextView(
                              text: "600",
                              fontSize: 16,
                            ),
                          ],
                        ),
                      ],
                    ),
                    15.verticalSpace,
                    const Divider(
                      thickness: 1,
                      color: Pallets.buttonGrey,
                    ),
                    15.verticalSpace,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const TextView(
                                  text: "Min time spent on post",
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: Pallets.textGrey,
                                ),
                                5.horizontalSpace,
                                ImageWidget(imageUrl: Assets.images.svgs.infoCircle, height: 13.33, width: 13.33, color: const Color(0xFF858585), )
                              ],
                            ),
                            8.verticalSpace,
                            const TextView(
                              text: "0.2 sec",
                              fontSize: 16,
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const TextView(
                                  text: "Min time spent on post",
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: Pallets.textGrey,
                                ),
                                5.horizontalSpace,
                                ImageWidget(imageUrl: Assets.images.svgs.infoCircle, height: 13.33, width: 13.33, color: const Color(0xFF858585), )
                              ],
                            ),
                            8.verticalSpace,
                            const TextView(
                              text: "0.2 sec",
                              fontSize: 16,
                            ),
                          ],
                        ),
                      ],
                    ),
                    15.verticalSpace,
                    const Divider(
                      thickness: 1,
                      color: Pallets.buttonGrey,
                    ),
                    12.verticalSpace,
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text("Country engagements", style: TextStyle(fontSize: 12),),
                      ],
                    ),
                    12.verticalSpace,
                    const Divider(
                      thickness: 1,
                      color: Pallets.buttonGrey,
                    ),
                    20.verticalSpace,
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                          Text("Nigeria: ", style: TextStyle(fontSize: 16,)),
                          Text("98%", style: TextStyle(fontSize: 16, color: Color(0xFF858585)),)
                        ],),
                        Row(
                          children: [
                          Text("Ghana: ", style: TextStyle(fontSize: 16,)),
                          Text("1%", style: TextStyle(fontSize: 16, color: Color(0xFF858585)),)
                        ],),
                        Row(
                          children: [
                          Text("Benin: ", style: TextStyle(fontSize: 16,)),
                          Text("1%", style: TextStyle(fontSize: 16, color: Color(0xFF858585)),)
                        ],),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        )
      );
  }
}
