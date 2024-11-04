import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../common/widgets/image_widget.dart';
import '../../../../common/widgets/text_view.dart';
import '../../../../core/theme/pallets.dart';
import '../../../../gen/assets.gen.dart';

class ImpressionsInfoItem extends StatelessWidget {
  const ImpressionsInfoItem({super.key, required this.header, required this.number});

  final String header;
  final String number;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            TextView(
              text: header,
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: Pallets.textGrey,
            ),
            5.horizontalSpace,
            ImageWidget(imageUrl: Assets.images.svgs.curvedInfoCircle, height: 13.33, width: 13.33, color: const Color(0xFF858585), )
          ],
        ),
        8.verticalSpace,
        TextView(
          text: number,
          fontSize: 16,
        ),
      ],
    );
  }
}
