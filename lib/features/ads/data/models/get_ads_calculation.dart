// To parse this JSON data, do
//
//     final getCalculationResponse = getCalculationResponseFromJson(jsonString);

import 'dart:convert';

GetCalculationResponse getCalculationResponseFromJson(String str) => GetCalculationResponse.fromJson(json.decode(str));

String getCalculationResponseToJson(GetCalculationResponse data) => json.encode(data.toJson());

class GetCalculationResponse {
  String message;
  Calculation data;
  bool success;
  int code;

  GetCalculationResponse({
    required this.message,
    required this.data,
    required this.success,
    required this.code,
  });

  GetCalculationResponse copyWith({
    String? message,
    Calculation? data,
    bool? success,
    int? code,
  }) =>
      GetCalculationResponse(
        message: message ?? this.message,
        data: data ?? this.data,
        success: success ?? this.success,
        code: code ?? this.code,
      );

  factory GetCalculationResponse.fromJson(Map<String, dynamic> json) => GetCalculationResponse(
    message: json["message"],
    data: Calculation.fromJson(json["data"]),
    success: json["success"],
    code: json["code"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "data": data.toJson(),
    "success": success,
    "code": code,
  };
}

class Calculation {
  String duration;
  int totalAmount;
  String dailyPayment;
  int totalImpressions;

  Calculation({
    required this.duration,
    required this.totalAmount,
    required this.dailyPayment,
    required this.totalImpressions,
  });

  Calculation copyWith({
    String? duration,
    int? totalAmount,
    String? dailyPayment,
    int? totalImpressions,
  }) =>
      Calculation(
        duration: duration ?? this.duration,
        totalAmount: totalAmount ?? this.totalAmount,
        dailyPayment: dailyPayment ?? this.dailyPayment,
        totalImpressions: totalImpressions ?? this.totalImpressions,
      );

  factory Calculation.fromJson(Map<String, dynamic> json) => Calculation(
    duration: json["duration"],
    totalAmount: json["total_amount"],
    dailyPayment: json["daily_payment"],
    totalImpressions: json["total_impressions"],
  );

  Map<String, dynamic> toJson() => {
    "duration": duration,
    "total_amount": totalAmount,
    "daily_payment": dailyPayment,
    "total_impressions": totalImpressions,
  };
}
