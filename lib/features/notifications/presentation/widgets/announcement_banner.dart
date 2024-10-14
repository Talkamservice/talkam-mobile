import 'package:flutter/material.dart';
import 'package:talkam/common/widgets/image_widget.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/constants/package_exports.dart';
import 'package:talkam/core/theme/pallets.dart';
import 'package:talkam/features/notifications/data/models/get_announcements_response.dart';
import 'package:talkam/features/notifications/presentation/screens/announcement_details_screen.dart';
import 'package:talkam/gen/assets.gen.dart';

class AnnouncementBanner extends StatelessWidget {
  const AnnouncementBanner({super.key, required this.announcement});
  final TalkamAnnouncement announcement;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showGeneralDialog(
          context: context,
          transitionBuilder: (context, animation, secondaryAnimation, child) {
            var begin = const Offset(0.0, 1.0); // Start below the screen
            var end = Offset.zero; // Endat the center
            var curve = Curves.ease; // Choose your animation curve

            var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

            return SlideTransition(
              position: animation.drive(tween),
              child: child,
            );
          },
          transitionDuration: const Duration(milliseconds: 500),
          pageBuilder: (context, animation, secondaryAnimation) {
            return  AnnouncementDetailsScreen(announcement: announcement);
          },
        );
      },
      child: Container(
        width: 1.sw,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [
          Color(0xffFDFFFF),
          Color(0xffD1F2F7),
        ])),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ImageWidget(
              imageUrl: Assets.images.svgs.announcement,
              size: 30,
              fit: BoxFit.cover,
            ),
            12.horizontalSpace,
             Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: TextView(
                          text: announcement.title,
                          fontWeight: FontWeight.w700,

                        ),
                      ),
                      // TextView(
                      //   text: "Expires in ${announcement.status}",
                      //   color: Pallets.grey,
                      //   fontSize: 12,
                      // ),
                    ],
                  ),
                  TextView(
                    text: announcement.description,
                    color: Pallets.grey,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
