// To parse this JSON data, do
//
//     final adAnalyticsResponse = adAnalyticsResponseFromJson(jsonString);

import 'dart:convert';

AdAnalyticsResponse adAnalyticsResponseFromJson(String str) => AdAnalyticsResponse.fromJson(json.decode(str));

String adAnalyticsResponseToJson(AdAnalyticsResponse data) => json.encode(data.toJson());

class AdAnalyticsResponse {
  String message;
  AnalyticsInfo data;
  bool success;
  int code;

  AdAnalyticsResponse({
    required this.message,
    required this.data,
    required this.success,
    required this.code,
  });

  AdAnalyticsResponse copyWith({
    String? message,
    AnalyticsInfo? data,
    bool? success,
    int? code,
  }) =>
      AdAnalyticsResponse(
        message: message ?? this.message,
        data: data ?? this.data,
        success: success ?? this.success,
        code: code ?? this.code,
      );

  factory AdAnalyticsResponse.fromJson(Map<String, dynamic> json) => AdAnalyticsResponse(
        message: json["message"],
        data: AnalyticsInfo.fromJson(json["data"]),
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

AnalyticsInfo analyticsInfoFromJson(String str) => AnalyticsInfo.fromJson(json.decode(str));

String analyticsInfoToJson(AnalyticsInfo data) => json.encode(data.toJson());

class AnalyticsInfo {
  dynamic id;
  dynamic comments;
  dynamic likes;
  dynamic dislikes;
  dynamic shares;
  dynamic impressions;
  dynamic engagements;
  dynamic followers;
  dynamic profileVisits;
  dynamic clicks;
  dynamic minTimeSpent;
  dynamic maxTimeSpent;
  List<CountryStat>? countries;
  dynamic createdAt;

  AnalyticsInfo({
    required this.id,
    required this.comments,
    required this.likes,
    required this.dislikes,
    required this.shares,
    required this.impressions,
    required this.engagements,
    required this.followers,
    required this.profileVisits,
    required this.clicks,
    required this.minTimeSpent,
    required this.maxTimeSpent,
    required this.countries,
    required this.createdAt,
  });

  AnalyticsInfo copyWith({
    int? id,
    int? comments,
    int? likes,
    int? dislikes,
    int? shares,
    int? impressions,
    int? engagements,
    int? followers,
    int? profileVisits,
    int? clicks,
    int? minTimeSpent,
    int? maxTimeSpent,
    List<CountryStat>? countries,
    DateTime? createdAt,
  }) =>
      AnalyticsInfo(
        id: id ?? this.id,
        comments: comments ?? this.comments,
        likes: likes ?? this.likes,
        dislikes: dislikes ?? this.dislikes,
        shares: shares ?? this.shares,
        impressions: impressions ?? this.impressions,
        engagements: engagements ?? this.engagements,
        followers: followers ?? this.followers,
        profileVisits: profileVisits ?? this.profileVisits,
        clicks: clicks ?? this.clicks,
        minTimeSpent: minTimeSpent ?? this.minTimeSpent,
        maxTimeSpent: maxTimeSpent ?? this.maxTimeSpent,
        countries: countries ?? this.countries,
        createdAt: createdAt ?? this.createdAt,
      );

  factory AnalyticsInfo.fromJson(Map<String, dynamic> json) => AnalyticsInfo(
        id: json["id"],
        comments: json["comments"],
        likes: json["likes"],
        dislikes: json["dislikes"],
        shares: json["shares"],
        impressions: json["impressions"],
        engagements: json["engagements"],
        followers: json["followers"],
        profileVisits: json["profile_visits"],
        clicks: json["clicks"],
        minTimeSpent: json["min_time_spent"],
        maxTimeSpent: json["max_time_spent"],
        countries: List<CountryStat>.from((json["countries"]??[]).map((x) => CountryStat.fromJson(x))),
        createdAt: DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "comments": comments,
        "likes": likes,
        "dislikes": dislikes,
        "shares": shares,
        "impressions": impressions,
        "engagements": engagements,
        "followers": followers,
        "profile_visits": profileVisits,
        "clicks": clicks,
        "min_time_spent": minTimeSpent,
        "max_time_spent": maxTimeSpent,
        "countries": countries != null ? List<dynamic>.from(countries!.map((x) => x.toJson())) : [],
        "created_at": createdAt.toIso8601String(),
      };
}

class CountryStat {
  int id;
  String name;
  int percentage;

  CountryStat({
    required this.id,
    required this.name,
    required this.percentage,
  });

  CountryStat copyWith({
    int? id,
    String? name,
    int? percentage,
  }) =>
      CountryStat(
        id: id ?? this.id,
        name: name ?? this.name,
        percentage: percentage ?? this.percentage,
      );

  factory CountryStat.fromJson(Map<String, dynamic> json) => CountryStat(
        id: json["id"],
        name: json["name"],
        percentage: json["percentage"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "percentage": percentage,
      };
}
