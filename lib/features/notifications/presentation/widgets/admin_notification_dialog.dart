import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:talkam/common/widgets/image_widget.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/_core.dart';
import 'package:talkam/core/constants/dialog_texts.dart';
import 'package:talkam/core/constants/package_exports.dart';
import 'package:talkam/core/theme/pallets.dart';
import 'package:talkam/features/notifications/data/models/get_notifications_response.dart';
import 'package:talkam/gen/assets.gen.dart';

class AdminNotificationDialog extends StatelessWidget {
  const AdminNotificationDialog({super.key, required this.notification});

  final TalkamNotification notification;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      insetPadding: const EdgeInsets.all(10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      content: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          constraints: const BoxConstraints(minHeight: 200),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
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
                      imageUrl: Assets.images.png.appIcon.path,
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
                              const Icon(
                                Icons.info_outline,
                                size: 16,
                                color: Pallets.grey,
                              ),
                              4.horizontalSpace,

                               TextView(
                                text: "Important update - ${TimeUtil.formatDateDDMMYYY(notification.createdAt.toIso8601String())}",
                                fontWeight: FontWeight.w700,
                                fontSize: 13,
                              ),
                            ],
                          ),
                           TextView(
                            text: "${notification.title}",
                            color: Pallets.grey,
                            fontSize: 13,
                          ),
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        context.pop();
                      },
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(color: Pallets.black, borderRadius: BorderRadius.circular(12)),
                        child: const Icon(
                          Icons.close,
                          color: Pallets.white,
                          size: 18,
                        ),
                      ),
                    )
                  ],
                ),
              ),
               Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 14),
                child: TextView(text:notification.message ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
