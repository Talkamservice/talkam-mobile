import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/navigation/route_url.dart';
import 'package:talkam/core/theme/pallets.dart';
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
    return TextButton(
        style: TextButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            backgroundColor: Pallets.blueBubbleColor,
            foregroundColor: Pallets.white,
            shape: const StadiumBorder()),
        onPressed: () {
          context.pushNamed(PageUrl.pendingRequestsScreen, extra: widget.group);
        },
        child: const TextView(
          text: "View Requests",

          fontWeight: FontWeight.w700,
          fontSize: 12,
        ));
  }
}
