import 'package:flutter/material.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/theme/pallets.dart';

class AdIndicator extends StatelessWidget {
  const AdIndicator({super.key, required this.promoter, this.padding});

  final String promoter;
  final double? padding;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Positioned(
        //     bottom: 0,
        //     child: Container(
        //       height: 18,
        //       color: Pallets.adIndicator,
        //       width: 50,
        //     )),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              padding: EdgeInsets.all(padding ??8),
              decoration: BoxDecoration(
                  color: Pallets.adIndicator,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(6),
                  )),
              child: TextView(
                text: "Ad",
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
            // Column(
            //   crossAxisAlignment: CrossAxisAlignment.start,
            //   children: [
            //     Stack(
            //       children: [
            //         Positioned(
            //           bottom: 0,
            //           left: 0,
            //           child: Container(
            //             decoration: BoxDecoration(color: Pallets.adIndicator),
            //             width: 8,
            //             height: 4,
            //           ),
            //         ),
            //         Container(
            //           width: 10,
            //           height: 5,
            //           decoration: BoxDecoration(
            //               color: Pallets.white,
            //               borderRadius: BorderRadius.only(
            //                 bottomLeft: Radius.circular(4),
            //               )),
            //         ),
            //       ],
            //     ),
            //     Container(
            //         padding: EdgeInsets.all(2.5),
            //         decoration: BoxDecoration(
            //             color: Pallets.adIndicator, borderRadius: BorderRadius.only(topRight: Radius.circular(6), bottomRight: Radius.circular(6))),
            //         child: TextView(
            //
            //           text: "By $promoter",
            //
            //           fontSize: 12,
            //           color: Color(0xff9F6E0F),
            //         ))
            //   ],
            // )
          ],
        ),
      ],
    );
  }
}
