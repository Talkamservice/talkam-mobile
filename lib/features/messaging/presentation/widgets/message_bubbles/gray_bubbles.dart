import 'package:flutter/material.dart';
import 'package:talkam/common/widgets/text_view.dart';

class GrayBubbles extends StatelessWidget {
  final String message;
  final String time;

  const GrayBubbles({
    Key? key,
    required this.message,
    required this.time,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: LayoutBuilder(
        builder: (context, constraints) {
          // Determine if the message is short or long
          bool isShortMessage = message.length <= 20;

          return Container(
            margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
            padding: const EdgeInsets.all(10.0),
            decoration: const BoxDecoration(
              color: Color(0xFFEEEEEE),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(0),
                bottomLeft: Radius.circular(12),
                bottomRight: Radius.circular(12),
              ),
            ),
            constraints: isShortMessage
                ? const BoxConstraints(
                    minWidth: 200,
                    minHeight: 20,
                    maxWidth: 280,
                  )
                : const BoxConstraints(maxWidth: 280),
            child: isShortMessage
                ? Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 40.0),
                        child: TextView(
                          text: message,
                          color: const Color(0xFF444444),
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Positioned(
                        right: 0,
                        bottom: 2,
                        child: TextView(
                          text: time,
                          color: const Color(0xFF666666),
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextView(
                        text: message,
                        color: const Color(0xFF444444),
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                      const SizedBox(height: 5.0),
                      TextView(
                        text: time,
                        color: const Color(0xFF666666),
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ],
                  ),
          );
        },
      ),
    );
  }
}
