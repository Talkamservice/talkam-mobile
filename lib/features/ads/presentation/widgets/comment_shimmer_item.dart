import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/pallets.dart';

class CommentShimmerItem extends StatelessWidget {
  const CommentShimmerItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Container(
              decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle),
              height: 50,
              width: 50,
            ),
            10.horizontalSpace,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        height: 13.0,
                        width: 120,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                      3.horizontalSpace,
                      Container(
                        height: 10.0,
                        width: 20,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                    ],
                  ),
                  5.verticalSpace,
                  Container(
                    height: 10.0,
                    width: 100,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                ],
              ),
            ),
            5.horizontalSpace,
            const Icon(Icons.more_vert)
          ],
        ),
        10.verticalSpace,
        Container(
          height: 60,
          width: 1.sw,
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
        ),
        10.verticalSpace,
        Divider(
          thickness: 1,
          color: Pallets.buttonGrey,
        ),
      ],
    );
  }
}
