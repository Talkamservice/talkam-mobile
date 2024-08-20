import 'package:flutter/material.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/theme/pallets.dart';

class BlueBubbles extends StatelessWidget {
  final String message;
  final String time;

  const BlueBubbles({
    Key? key,
    required this.message,
    required this.time,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: LayoutBuilder(
        builder: (context, constraints) {
          bool isShortMessage = message.length <= 20;

          return Container(
            margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
            padding: const EdgeInsets.all(10.0),
            decoration: const BoxDecoration(
              color: Pallets.blueBubbleColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(0),
                topRight: Radius.circular(12),
                bottomLeft: Radius.circular(12),
                bottomRight: Radius.circular(12),
              ),
            ),
            constraints: isShortMessage
                ? const BoxConstraints(


                    minHeight: 20,
                    maxWidth: 280,
                  )
                : const BoxConstraints(maxWidth: 280),
            child: isShortMessage
                ? Column(
              crossAxisAlignment: CrossAxisAlignment.start ,
                    children: [

                      TextView(
                        text: message,
                        color: const Color(0xffFFFFFF),
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                      ),
                      Container(
                        constraints: BoxConstraints(minWidth: 150),
                        child: TextView(
                          text: time,
                          align: TextAlign.end,
                          color: const Color(0xffFFFFFF),
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                        ),
                      )
                    ],
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      TextView(
                        text: message,
                        color: const Color(0xffFFFFFF),
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                      ),
                      const SizedBox(height: 5.0),
                      TextView(
                        text: time,
                        color: const Color(0xffFFFFFF),
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                      ),
                    ],
                  ),
          );
        },
      ),
    );
  }
}
