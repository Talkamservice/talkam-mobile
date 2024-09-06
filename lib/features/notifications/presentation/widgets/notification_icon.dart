import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:talkam/common/widgets/image_widget.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/core/navigation/route_url.dart';
import 'package:talkam/core/utils/guest_user_helper.dart';
import 'package:talkam/features/notifications/presentation/bloc/notification_bloc.dart';
import 'package:talkam/gen/assets.gen.dart';

class NotificationIcon extends StatelessWidget {
  const NotificationIcon({Key? key, }) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return GuestUserHelper.guestUserWidget(
      widget: InkWell(
        onTap: () => context.pushNamed(PageUrl.notificationScreen),
        child: BlocBuilder<NotificationsBloc, NotificationsState>(
          bloc: injector.get<NotificationsBloc>(),
          builder: (context, state) {
            final stat = injector.get<NotificationsBloc>().stats;
            return Stack(
              clipBehavior: Clip.none,
              children: [
                ImageWidget(
                  imageUrl: Assets.images.svgs.notification,
                  onTap: () => context.pushNamed(PageUrl.notificationScreen),
                ),
                if (stat.unreadNotifications != 0)
                  Positioned(
                    top: -1,
                    right: -1,
                    child: CircleAvatar(
                      radius: 8,
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                      child: TextView(
                        text: stat.unreadNotifications.toString(),
                        fontSize: 8,
                      ),
                    ),
                  ),
              ],
            );
          },
        ),
      ),
      guestWidget: const SizedBox.shrink(), // Or your desired guest widget
    );
  }
}
