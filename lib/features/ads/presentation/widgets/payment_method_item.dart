import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PaymentMethodItem extends StatefulWidget {
  const PaymentMethodItem({super.key});

  @override
  State<PaymentMethodItem> createState() => _PaymentMethodItemState();
}

class _PaymentMethodItemState extends State<PaymentMethodItem> {
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
    return GestureDetector(
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
    );
  }
}
