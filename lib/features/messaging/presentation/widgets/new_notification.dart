import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:talkam/common/widgets/image_widget.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/_core.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/core/navigation/route_url.dart';
import 'package:talkam/core/services/data/session_manager.dart';
import 'package:talkam/core/theme/pallets.dart';
import 'package:talkam/features/ads/presentation/screens/ads_review_screens/view_analytics_page.dart';
import 'package:talkam/features/messaging/data/models/get_conversations_response.dart';
import 'package:talkam/features/messaging/presentation/screens/chat_screen.dart';
import 'package:talkam/features/notifications/data/models/get_notifications_response.dart';
import 'package:talkam/features/notifications/presentation/bloc/notification_bloc.dart';
import 'package:talkam/features/notifications/presentation/widgets/admin_notification_dialog.dart';
import 'package:talkam/features/post/data/models/comment_notification_extra.dart';

class TalkamNotificationItem extends StatelessWidget {
  TalkamNotificationItem({
    super.key,
    required this.notification,
  });

  TalkamNotification notification;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        _handleNotificationClick(context);
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          NotificationImage(notification: notification),
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  TextView(
                    text: notification.title,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                  const Spacer(),
                  CircleAvatar(
                    radius: 4,
                    backgroundColor: notification.readAt == null ? Pallets.blueBubbleColor : Pallets.grey400,
                  )
                ],
              ),
              5.verticalSpace,
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextView(
                          text: notification.message,
                          color: const Color(0xff000000),
                          maxLines: 2,
                          textOverflow: TextOverflow.ellipsis,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                        5.verticalSpace,
                        TextView(
                          text: TimeUtil.formDateTimeForJournal(notification.createdAt),
                          style: const TextStyle(
                            fontSize: 13,
                            color: Color(0xff444444),
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (notification.type == "comment" || notification.type == "mention")
                    Builder(builder: (context) {
                      var extra = CommentNotificationExtra.fromJson(notification.extra);
                      if (extra.comment.attachment != null || extra.postAttachements.isNotEmpty) {
                        return ImageWidget(
                            height: 60,
                            width: 60,
                            borderRadius: BorderRadius.circular(10),
                            imageUrl: CommentNotificationExtra.fromJson(notification.extra).postAttachements.firstOrNull?.url ?? "");
                      }
                      return 0.verticalSpace;
                    })
                ],
              ),
            ],
          )),
        ],
      ),
    );
  }

  bool get shouldDisplayUserImage => notification.type == "post" || notification.type == "conversation";

  void _handleNotificationClick(BuildContext context) {
    logger.w(notification.type);
    notification.readAt = DateTime.now();

    injector.get<NotificationsBloc>().add(ReadNotificationEvent(id: notification.id.toString()));
    switch (notification.type) {
      case "post" || "comment":
        context.pushNamed(PageUrl.postDetailsScreen, extra: notification.dataId.toString());
        break;

      case "conversation":
        // logger.w(notification.userId);
        // var user = ExtraClass.fromJson(notification.extra);
        if (ExtraClass.fromJson(notification.extra).sender != null) {
          var user = ExtraClass.fromJson(notification.extra).sender!;
          context.pushNamed(
            PageUrl.chatScreen,
            extra: ChatScreenParam(
              user: ConversationUser(id: user.id, name: user.name, username: user.username, email: user.email, avatar: user.avatar),
            ),
          );
        }

      case "group":
        context.pushNamed(PageUrl.groupsInfoScreen, extra: notification.dataId.toString());
      case "promotion":
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ViewAnalyticsPage(
                      promotionId: notification.dataId.toString(),
                    )));
      case "group_request":
        context.pushNamed(PageUrl.pendingRequestsScreen, extra: notification.dataId.toString());
      case "request":
        context.pushNamed(PageUrl.pendingRequestsScreen, extra: notification.dataId.toString());
      case "mention":
        context.pushNamed(PageUrl.postDetailsScreen, extra: notification.dataId.toString());
      case "notification" || "user":
        showDialog(
          context: context,
          builder: (context) {
            return AdminNotificationDialog(
              notification: notification,
            );
          },
        );
        // context.pushNamed(PageUrl.postDetailsScreen, extra: notification.dataId.toString());
        break;
    }
  }
}

class NotificationImage extends StatelessWidget {
  const NotificationImage({super.key, required this.notification});

  final TalkamNotification notification;

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        if ((notification.type == "post") && notification.extra is! List && notification.extra["user"] != null) {
          return Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: InkWell(
              onTap: () {
                viewProfile(context, NotificationUser.fromJson(notification.extra["user"]).id.toString());
              },
              child: IgnorePointer(
                child: ImageWidget(
                  fit: BoxFit.scaleDown,
                  shape: BoxShape.circle,
                  imageUrl: NotificationUser.fromJson(notification.extra["user"]).avatar.toString(),
                  size: 40,
                ),
              ),
            ),
          );
        }

        // if ((notification.type == "comment" ) && notification.extra is! List) {
        //   return InkWell(
        //     onTap: () {
        //       viewProfile(context, NotificationUser.fromJson(notification.extra["user"]).id.toString());
        //     },
        //     child: IgnorePointer(
        //       child: ImageWidget(
        //         fit: BoxFit.scaleDown,
        //         imageUrl: NotificationUser.fromJson(notification.extra["user"]).avatar.toString(),
        //         size: 40,
        //       ),
        //     ),
        //   );
        // }

        if (notification.type == "conversation") {
          return Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: InkWell(
              onTap: () {
                viewProfile(context, ExtraClass.fromJson(notification.extra).sender!.id.toString());
              },
              child: ImageWidget(
                fit: BoxFit.scaleDown,
                shape: BoxShape.circle,
                imageUrl: ExtraClass.fromJson(notification.extra).sender?.avatar ?? "",
                size: 40,
              ),
            ),
          );
        }

        return 0.verticalSpace;
      },
    );
  }

  void viewProfile(BuildContext context, String userId) {
    if (SessionManager().isMe(userId)) {
      context.pushNamed(PageUrl.profileScreen, extra: userId);
    } else {
      context.pushNamed(PageUrl.userProfileScreen, extra: userId);
    }
  }
}
