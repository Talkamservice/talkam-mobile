import 'package:flutter/material.dart';
import 'package:flutterwave_standard_smart/core/flutterwave.dart';
import 'package:flutterwave_standard_smart/models/requests/customer.dart';
import 'package:flutterwave_standard_smart/models/requests/customizations.dart';
import 'package:flutterwave_standard_smart/models/responses/charge_response.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/core/services/network/url_config.dart';
import 'package:talkam/gen/assets.gen.dart';

class FlutterRequirements {
  final num? amount;
  final String? currency;
  final String? email;
  final String? fullName;
  final String? phoneNumber;
  final String? referenceNumber;
  final String? description;
  final Map<String, dynamic>? meta;

  FlutterRequirements({required this.amount, required this.referenceNumber, this.email, this.currency, this.fullName, this.meta, this.phoneNumber,this.description});
}

class PaymentHelper {
  Future<ChargeResponse?> makePayment(BuildContext context, FlutterRequirements requirements, {Function(ChargeResponse)? response}) async {
    try {
      // logger.i("PAYMENT ID${requirements.planId}");
      // logger.i("Key ${AppConfig.flutterWavePublicKey}");
      // final style = FlutterwaveStyle(
      //   appBarText: "Medbury",
      //   buttonColor: Pallets.red,
      //   buttonTextStyle: TextStyle(
      //     color: Pallets.white,
      //     fontSize: 16,
      //   ),
      //   appBarColor: Pallets.red,
      //   dialogCancelTextStyle: const TextStyle(
      //     color: Pallets.grey,
      //     fontSize: 18,
      //   ),
      //   dialogContinueTextStyle: TextStyle(
      //     color: Pallets.red,
      //     fontSize: 16,
      //   ),
      //   mainBackgroundColor: Theme.of(context).scaffoldBackgroundColor,
      //   mainTextStyle: const TextStyle(fontSize: 19, letterSpacing: 2),
      //   dialogBackgroundColor: Theme.of(context).cardColor,
      //   appBarIcon: const Icon(Icons.clear, color: Pallets.white),
      //   buttonText:
      //   "Pay ${Helpers.currencySymbol(context, requirements.amount ?? 0)}",
      //   appBarTitleTextStyle: TextStyle(
      //     color: Pallets.white,
      //     fontSize: 16,
      //   ),
      // );

      final Customer _customer = Customer(name: requirements.fullName!, phoneNumber: requirements.phoneNumber, email: requirements.email!);

      final _flutterwave = Flutterwave(
        // style: style,

        context: context,
        publicKey: UrlConfig.flutterWavePublicKey,
        currency: requirements.currency!,
        txRef: requirements.referenceNumber!,
        amount: requirements.amount!.toString(),
        customer: _customer,
        paymentOptions: 'card',

        meta: requirements.meta ??
            {
              "payment_details": {"mode": "card", "type": "funding"}
            },
        // paymentPlanId: requirements.planId,

        customization: Customization(title: requirements.description, logo: Assets.images.svgs.logo2),
        isTestMode: true,
        redirectUrl: 'https://web.talkam.prodevs.io/home/new',
      );

      final _response = await _flutterwave.charge();
      // response!(_response);
      if (_response.success ?? false) {
        logger.i(_response.toJson());

        return _response;
      } else {
        return null;
      }
        } catch (error,stack) {
      logger.e(error);
      logger.e(stack);
      return null;
    }
  }
}
