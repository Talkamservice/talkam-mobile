import 'package:flutter/material.dart';
import 'package:flutterwave_standard/flutterwave.dart';
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

  FlutterRequirements(
      {required this.amount,
      required this.referenceNumber,
      this.email,
      this.currency,
      this.fullName,
      this.meta,
      this.phoneNumber,
      this.description});
}

class PaymentHelper {
  Future<ChargeResponse?> makePayment(
      BuildContext context, FlutterRequirements requirements,
      {Function(ChargeResponse)? response}) async {
    try {
      final Customer _customer = Customer(
          name: requirements.fullName!,
          phoneNumber: requirements.phoneNumber,
          email: requirements.email!);

      final _flutterwave = Flutterwave(
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
        customization: Customization(
            title: requirements.description, logo: Assets.images.svgs.logo2),
        isTestMode: true,
        redirectUrl: 'https://web.talkam.prodevs.io/home/new',
      );

      final _response = await _flutterwave.charge(context);

      // Log everything, regardless of success/failure
      logger.i('Payment Response: ${_response.toJson()}');
      logger.i('TX Ref: ${_response.txRef}');
      logger.i('Transaction ID: ${_response.transactionId}');
      logger.i('Status: ${_response.status}');
      logger.i('Success: ${_response.success}');

      if (_response.success ?? false) {
        logger.i('Payment successful for ref: ${_response.txRef}');
        // Send this to your backend to verify before giving value
        return _response;
      } else {
        logger.w('Payment failed for ref: ${requirements.referenceNumber}');
        logger.w('Response: ${_response.toJson()}');
        return null;
      }
    } catch (error, stack) {
      logger.e('Payment error: $error');
      logger.e('Stack: $stack');
      return null;
    }
  }
}
