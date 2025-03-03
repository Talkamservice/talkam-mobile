// To parse this JSON data, do
//
//     final getPricingResponse = getPricingResponseFromJson(jsonString);

import 'dart:convert';

GetPricingResponse getPricingResponseFromJson(String str) => GetPricingResponse.fromJson(json.decode(str));

String getPricingResponseToJson(GetPricingResponse data) => json.encode(data.toJson());

class GetPricingResponse {
  String message;
  AdPricing data;
  bool success;

  int code;

  GetPricingResponse({
    required this.message,
    required this.data,
    required this.success,
    required this.code,
  });

  GetPricingResponse copyWith({
    String? message,
    AdPricing? data,
    bool? success,
    int? code,
  }) =>
      GetPricingResponse(
        message: message ?? this.message,
        data: data ?? this.data,
        success: success ?? this.success,
        code: code ?? this.code,
      );

  factory GetPricingResponse.fromJson(Map<String, dynamic> json) => GetPricingResponse(
        message: json["message"],
        data: AdPricing.fromJson(json["data"]),
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

class AdPricing {
  int id;
  int amount;
  int impressions;
  int maxDailyAmount;
  AdCurrency? currency;
  AdCountry? country;
  String status;

  AdPricing({
    required this.id,
    required this.amount,
    required this.impressions,
    required this.maxDailyAmount,
    required this.currency,
    required this.country,
    required this.status,
  });

  AdPricing copyWith({
    int? id,
    int? amount,
    int? impressions,
    int? maxDailyAmount,
    AdCurrency? currency,
    AdCountry? country,
    String? status,
  }) =>
      AdPricing(
        id: id ?? this.id,
        amount: amount ?? this.amount,
        impressions: impressions ?? this.impressions,
        maxDailyAmount: maxDailyAmount ?? this.maxDailyAmount,
        currency: currency ?? this.currency,
        country: country ?? this.country,
        status: status ?? this.status,
      );

  factory AdPricing.fromJson(Map<String, dynamic> json) => AdPricing(
        id: json["id"],
        amount: json["amount"],
        impressions: json["impressions"],
        maxDailyAmount: json["max_daily_amount"],
        currency: json["currency"] == null ? null : AdCurrency.fromJson(json["currency"]),
        country: json["country"] == null ? null : AdCountry.fromJson(json["country"]),
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "amount": amount,
        "impressions": impressions,
        "max_daily_amount": maxDailyAmount,
        "currency": currency?.toJson(),
        "country": country?.toJson(),
        "status": status,
      };
}

class AdCountry {
  int id;
  String name;

  AdCountry({
    required this.id,
    required this.name,
  });

  AdCountry copyWith({
    int? id,
    String? name,
  }) =>
      AdCountry(
        id: id ?? this.id,
        name: name ?? this.name,
      );

  factory AdCountry.fromJson(Map<String, dynamic> json) => AdCountry(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}

class AdCurrency {
  String name;
  String shortName;

  AdCurrency({
    required this.name,
    required this.shortName,
  });

  AdCurrency copyWith({
    String? name,
    String? shortName,
  }) =>
      AdCurrency(
        name: name ?? this.name,
        shortName: shortName ?? this.shortName,
      );

  factory AdCurrency.fromJson(Map<String, dynamic> json) => AdCurrency(
        name: json["name"],
        shortName: json["short_name"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "short_name": shortName,
      };
}
