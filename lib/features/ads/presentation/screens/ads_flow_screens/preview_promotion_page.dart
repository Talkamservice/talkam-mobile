import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:talkam/core/theme/pallets.dart';


class PreviewPromotionPage extends StatefulWidget {
  const PreviewPromotionPage({super.key});

  @override
  State<PreviewPromotionPage> createState() => _PreviewPromotionPageState();
}

class _PreviewPromotionPageState extends State<PreviewPromotionPage> {

   int _paymentIndex = 0;

   void changePaymentIndex (){
     if (_paymentIndex == 0){
     setState(() {
       _paymentIndex = 1;
      });
     }
     else {
       setState(() {
         _paymentIndex = 0;
       });
     }
   }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
            24.verticalSpace,
           Padding(
            padding: const EdgeInsets.only(left: 16, right: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Preview promotion", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
                17.verticalSpace,
                const Text("Total", style: TextStyle(fontSize: 12, color: Colors.grey),),
                8.verticalSpace,
                const Text("\$250", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),)
              ],
            ),
          ),
          15.verticalSpace,
          const Divider(color: Colors.grey),
          16.verticalSpace,
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Your reach", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),),
                8.verticalSpace,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Location", style: TextStyle(color: Colors.grey, fontSize: 12),),
                    const Text("Age range", style: TextStyle(color: Colors.grey, fontSize: 12),),
                    const Text("Gender", style: TextStyle(color: Colors.grey, fontSize: 12),),
                    10.horizontalSpace
                  ],
                ),
                8.verticalSpace,
                const Padding(
                  padding: EdgeInsets.only(right: 18.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Nigeria", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                      Text("20-60yrs", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                      Text("All gender", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                    ],
                  ),
                ),
              ],
            ),
          ),
          16.verticalSpace,
          const Divider(color: Colors.grey),
          16.verticalSpace,
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 100),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Budget & Duration", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),),
                8.verticalSpace,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Daily budget", style: TextStyle(color: Colors.grey, fontSize: 12)),
                    100.horizontalSpace,
                    const Text("Duration", style: TextStyle(color: Colors.grey, fontSize: 12)),
                    1.horizontalSpace,
                  ],
                ),
                 8.verticalSpace,
                 const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("\$16", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                    Text("15 days", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                  ],
                ),
              ],
            ),
          ),
          16.verticalSpace,
          const Divider(color: Colors.grey),
          16.verticalSpace,
          Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16),
            child: Column(
              children: [
                GestureDetector(
                  onTap: changePaymentIndex,
                  child: _paymentIndex == 0 ? Container(
                    decoration: BoxDecoration(
                        color: Colors.blue.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 16, right: 16, top: 12, bottom: 12),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text("Set up a payment method", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
                                5.verticalSpace,
                                const Text("Enter your payment information and set up your payment process to enable you make transactions", style: TextStyle(fontSize: 10)),
                              ],
                            ),
                          ),
                          5.horizontalSpace,
                          const Icon(Icons.arrow_forward_ios_rounded, color: Colors.black,)
                        ],
                      ),
                    )
                  ) : Container(
                      decoration: BoxDecoration(
                          color: Colors.blue.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 16, right: 16, top: 12, bottom: 12),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text("Payment Method", style: TextStyle(fontSize: 12, color: Color(0xFF858585)),),
                                  5.verticalSpace,
                                  Row(
                                    children: [
                                      const Text("352648758356", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold,),),
                                      40.horizontalSpace,
                                      Image.asset('assets/images/jpegs/logos_mastercard.jpg', height: 17, width: 21.17,)
                                    ],
                                  ),
                                  10.verticalSpace
                                ],
                              ),
                            ),
                            5.horizontalSpace,
                            const Icon(Icons.delete, color: Colors.black,)
                          ],
                        ),
                      )
                  )
                ),
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
    );
  }
}
