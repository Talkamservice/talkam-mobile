import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:talkam/features/ads/presentation/widgets/payment_method_item.dart';
import 'package:talkam/features/ads/presentation/widgets/preview_promotion_item.dart';

import '../../widgets/preview_promotion_widget.dart';


class PreviewPromotionPage extends StatefulWidget {
  const PreviewPromotionPage({super.key});

  @override
  State<PreviewPromotionPage> createState() => _PreviewPromotionPageState();
}

class _PreviewPromotionPageState extends State<PreviewPromotionPage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
            24.verticalSpace,
            const Padding(
              padding: EdgeInsets.only(left: 16, right: 10),
              child: Text("Preview promotion", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
            ),
           Column(
             crossAxisAlignment: CrossAxisAlignment.start,
             children: [
               17.verticalSpace,
               const PreviewPromotionWidget(),
               16.verticalSpace,
               Padding(
                 padding: const EdgeInsets.only(left: 16.0, right: 16),
                 child: Column(
                   children: [
                     const PaymentMethodItem(),
                     16.verticalSpace,
                     Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         const Text("By clicking on create promotion, you agree to the"),
                         5.verticalSpace,
                         const Text("Advertising terms and conditions of TalkAM", style: TextStyle(color: Color(0xFF017FC8)),)
                       ],
                     )
                   ],
                 ),
               ),
             ],
           ),
        ],
      ),
    );
  }
}
