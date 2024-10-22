import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PreviewPromotionPage extends StatelessWidget {
  const PreviewPromotionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
            8.verticalSpace,
           Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Preview promotion", style: TextStyle(fontWeight: FontWeight.bold),),
                20.verticalSpace,
                const Text("Total", style: TextStyle(fontSize: 12),),
                5.verticalSpace,
                const Text("\$250", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),)
              ],
            ),
          ),
          10.verticalSpace,
          const Divider(color: Colors.grey),
          13.verticalSpace,
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Your reach", style: TextStyle(fontWeight: FontWeight.bold),),
                15.verticalSpace,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Location", style: TextStyle(color: Colors.grey),),
                    const Text("Age range", style: TextStyle(color: Colors.grey),),
                    const Text("Gender", style: TextStyle(color: Colors.grey),),
                    10.horizontalSpace
                  ],
                ),
                10.verticalSpace,
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
          13.verticalSpace,
          const Divider(color: Colors.grey),
          13.verticalSpace,
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 100),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Budget & Duration", style: TextStyle(fontWeight: FontWeight.bold),),
                15.verticalSpace,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Daily budget", style: TextStyle(color: Colors.grey)),
                    100.horizontalSpace,
                    const Text("Duration", style: TextStyle(color: Colors.grey)),
                    1.horizontalSpace,
                  ],
                ),
                 10.verticalSpace,
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
          13.verticalSpace,
          const Divider(color: Colors.grey),
          13.verticalSpace,
          Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: Colors.blue.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("Set up a payment method", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),),
                            5.verticalSpace,
                            const Text("Enter your payment information and set up your payment process", style: TextStyle(fontSize: 10)),
                            const Text("to enable you make transactions", style: TextStyle(fontSize: 10))
                          ],
                        ),
                        const Icon(Icons.arrow_forward_ios_rounded, color: Colors.black,)
                      ],
                    ),
                  )
                ),
                20.verticalSpace,
                 Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("By clicking on create promotion, you agree to the"),
                    5.verticalSpace,
                    const Row(
                      children: [
                        Text("Advertising terms and conditions  ", style: TextStyle(color: Colors.blue),),
                        Text("of TalkAM"),
                      ],
                    )
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
