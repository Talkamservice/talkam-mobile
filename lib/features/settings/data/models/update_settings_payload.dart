// To parse this JSON data, do
//
//     final updateSettingsPayload = updateSettingsPayloadFromJson(jsonString);

import 'dart:convert';

UpdateSettingsPayload updateSettingsPayloadFromJson(String str) => UpdateSettingsPayload.fromJson(json.decode(str));

String updateSettingsPayloadToJson(UpdateSettingsPayload data) => json.encode(data.toJson());

class UpdateSettingsPayload {
  int? talkamNews;
  int? talkamResearch;
  int? moderationActivities;
  int? userActivities;
  String? comments;

  UpdateSettingsPayload({
     this.talkamNews,
     this.talkamResearch,
     this.moderationActivities,
     this.userActivities,
     this.comments,
  });

  UpdateSettingsPayload copyWith({
    int? talkamNews,
    int? talkamResearch,
    int? moderationActivities,
    int? userActivities,
    String? comments,
  }) =>
      UpdateSettingsPayload(
        talkamNews: talkamNews ?? this.talkamNews,
        talkamResearch: talkamResearch ?? this.talkamResearch,
        moderationActivities: moderationActivities ?? this.moderationActivities,
        userActivities: userActivities ?? this.userActivities,
        comments: comments ?? this.comments,
      );

  factory UpdateSettingsPayload.fromJson(Map<String, dynamic> json) => UpdateSettingsPayload(
    talkamNews: json["talkam_news"],
    talkamResearch: json["talkam_research"],
    moderationActivities: json["moderation_activities"],
    userActivities: json["user_activities"],
    comments: json["comments"],
  );

  Map<String, dynamic> toJson() => {
    "talkam_news": talkamNews,
    "talkam_research": talkamResearch,
    "moderation_activities": moderationActivities,
    "user_activities": userActivities,
    "comments": comments,
  };
}
