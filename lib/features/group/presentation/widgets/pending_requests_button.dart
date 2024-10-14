import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/constants/package_exports.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/core/navigation/route_url.dart';
import 'package:talkam/core/theme/pallets.dart';
import 'package:talkam/features/notifications/presentation/bloc/notification_bloc.dart';
import 'package:talkam/features/notifications/presentation/bloc/notification_bloc.dart';
import 'package:talkam/features/search/data/models/get_group_response.dart';

class PendingRequestsButton extends StatefulWidget {
  const PendingRequestsButton({super.key, required this.group});

  final TalkamGroup group;

  @override
  State<PendingRequestsButton> createState() => _PendingRequestsButtonState();
}

class _PendingRequestsButtonState extends State<PendingRequestsButton> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NotificationsBloc, NotificationsState>(
      bloc: injector.get(),
      listener: (context, state) {

      },
      builder: (context, state) {
        var stats = injector.get<NotificationsBloc>().stats;
        return TextButton(
            style: TextButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                backgroundColor: Pallets.blueBubbleColor,
                foregroundColor: Pallets.white,
                shape: const StadiumBorder()),
            onPressed: () {
              context.pushNamed(PageUrl.pendingRequestsScreen, extra: widget.group.id.toString());
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const TextView(
                  text: "View Requests",

                  fontWeight: FontWeight.w700,
                  fontSize: 12,
                ),

                if (widget.group.pendingCount != 0)
                  3.horizontalSpace,
                if (widget.group.pendingCount != 0)

                  CircleAvatar(
                    radius: 8,
                    backgroundColor: Colors.white,
                    foregroundColor: Pallets.primary,
                    child: TextView(
                      text: widget.group.pendingCount.toString(),
                      fontSize: 8,
                    ),
                  ),
              ],
            ));
      },
    );
  }
}
