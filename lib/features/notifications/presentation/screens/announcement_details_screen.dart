import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:talkam/common/widgets/custom_appbar.dart';
import 'package:talkam/common/widgets/image_widget.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/constants/package_exports.dart';
import 'package:talkam/core/theme/pallets.dart';
import 'package:talkam/core/utils/extensions/context_extension.dart';
import 'package:talkam/core/utils/time_util.dart';
import 'package:talkam/features/notifications/data/models/get_announcements_response.dart';
import 'package:talkam/gen/assets.gen.dart';

class AnnouncementDetailsScreen extends StatefulWidget {
  const AnnouncementDetailsScreen({super.key, required this.announcement});

  final TalkamAnnouncement announcement;

  @override
  State<AnnouncementDetailsScreen> createState() => _AnnouncementDetailsScreenState();
}

class _AnnouncementDetailsScreenState extends State<AnnouncementDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
           _AnnouncementBanner(announcement: widget.announcement,),
          20.verticalSpace,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                TextView(text: widget.announcement.description),
                20.verticalSpace,
                if(widget.announcement.bannerImage!= null)
                ImageWidget(
                  imageUrl: widget.announcement.bannerImage,
                  height: 276,
                  width: 1.sw,
                  borderRadius: BorderRadius.circular(13),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _AnnouncementBanner extends StatelessWidget {
  const _AnnouncementBanner({super.key, required this.announcement});

  final TalkamAnnouncement announcement;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 1.sw,
      child: Stack(
        children: [
          Container(
            width: 1.sw,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: const BoxDecoration(
                gradient: LinearGradient(colors: [
              Color(0xffFDFFFF),
              Color(0xffD1F2F7),
            ])),
            child: Column(
              children: [
                50.verticalSpace,
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ImageWidget(
                      imageUrl: Assets.images.png.appIcon.path,
                      size: 40,
                      fit: BoxFit.cover,
                    ),
                    16.horizontalSpace,
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const TextView(
                            text: "Announcement",
                            // fontSize: 12,
                          ),
                          5.verticalSpace,
                           TextView(
                            text: announcement.title,
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                          ),
                          5.verticalSpace,
                           TextView(
                            text: TimeUtil.formDateTimeForJournal(announcement.createdAt),
                            color: Pallets.grey,
                            fontSize: 13,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            top: 30,
            right: 10,
            child: TextButton(
                onPressed: () {
                  context.pop();
                },
                child: const TextView(
                  text: "Close",
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                )),
          ),
        ],
      ),
    );
  }
}
