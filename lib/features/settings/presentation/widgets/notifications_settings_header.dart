import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/constants/package_exports.dart';

class NotificationSettingHeader extends StatelessWidget {
  const NotificationSettingHeader({
    super.key,
    required this.tittle,
    required this.subtittle,
  });

  final String tittle;
  final String subtittle;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextView(
                text: tittle,
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
              TextView(
                text: subtittle,
                fontSize: 14,
              ),
            ],
          ),
        ),

        24.horizontalSpace,
      ],
    );
  }
}
