import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:readmore/readmore.dart';
import 'package:talkam/common/widgets/image_widget.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/constants/package_exports.dart';
import 'package:talkam/core/theme/pallets.dart';
import 'package:talkam/gen/assets.gen.dart';

class ProfilePostItemTile extends StatelessWidget {
  final Widget leading;
  final String groupName;
  final String formattedPostTime;
  final String postTitle;
  final String postContent;

  const ProfilePostItemTile({
    super.key,
    required this.leading,
    required this.groupName,
    required this.formattedPostTime,
    required this.postContent,
    required this.postTitle,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: ImageWidget(
                  imageUrl: Assets.images.png.woman.path,
                  height: 32.h,
                  width: 32.w,
                ),
              ),
              12.horizontalSpace,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextView(
                    text: "Dating & Relationship",
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: Pallets.boldBlackV2,
                  ),
                  TextView(
                    text: "Posted by Dan282",
                    fontSize: 12.sp,
                    color: Pallets.grey500,
                  ),
                ],
              ),
              16.horizontalSpace,
              TextView(
                text: "13hrs",
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
                color: Pallets.primary400,
              ),
              const Spacer(),
              PopupMenuButton<String>(
                padding: EdgeInsets.zero,
                icon: const Icon(Icons.more_vert_rounded),
                iconColor: Colors.black,
                elevation: 1.5,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                onSelected: (String result) {},
                itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[],
              )
            ],
          ),
          Padding(
            padding: EdgeInsets.only(top: 12.h, right: 12.w),
            child: TextView(
              text:
                  "Before I got married, my aunt suggested transferring my assets to my mom in case the marriage didn't work out. 2 years later, She was right.",
              fontWeight: FontWeight.w500,
              color: Pallets.boldBlackV2,
              fontSize: 16.sp,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 12.h, right: 12.w),
            child: ReadMoreText(
              "Reflecting on my aunt's advice now, I realize the significance of her foresight. It wasn't just about safeguarding my assets; it was about being prepared for the unexpected turns life might take. While I had hoped for the best, her suggestion turned out to be a lifeline",
              trimLines: 5,
              trimCollapsedText: "Read more",
              trimExpandedText: "Show less",
              style: GoogleFonts.nunito(
                color: Pallets.boldBlackV2,
                fontWeight: FontWeight.w400,
                fontSize: 14.sp,
              ).copyWith(inherit: true),
              moreStyle: GoogleFonts.nunito(
                color: Pallets.primary400,
                fontWeight: FontWeight.w500,
                fontSize: 14.sp,
              ).copyWith(inherit: true),
            ),
          ),
          20.verticalSpace,
          Wrap(
            spacing: 10,
            children: [
              _ChipItem(title: "Relationships"),
              _ChipItem(title: "Dating"),
            ],
          ),
          10.verticalSpace,
          Container(
            height: 1,
            color: Pallets.borderGrey,
          ),
          16.verticalSpace,
          Padding(
            padding: EdgeInsets.only(right: 12.w),
            child: Container(
              width: double.infinity,
              height: 40.h,
              decoration: BoxDecoration(
                color: Pallets.tabBarBlue,
                borderRadius: BorderRadius.circular(40),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextView(
                    text: "Scheduled post",
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 13.sp,
                  ),
                  TextView(
                    text: "13th July, 2029 - 10:49 AM",
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 13.sp,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class _ChipItem extends StatelessWidget {
  final String title;

  const _ChipItem({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return UnconstrainedBox(
      child: Container(
        height: 23.h,
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(36),
          border: Border.all(
            color: const Color(0xFFD2D2D2),
          ),
        ),
        child: Center(
          child: TextView(
            text: title,
            fontSize: 13.sp,
            fontWeight: FontWeight.w500,
            color: Pallets.boldBlackV2,
          ),
        ),
      ),
    );
  }
}
