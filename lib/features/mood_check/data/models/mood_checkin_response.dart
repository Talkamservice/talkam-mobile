// To parse this JSON data, do
//
//     final moodCheckinResponse = moodCheckinResponseFromJson(jsonString);

import 'dart:convert';

MoodCheckinResponse moodCheckinResponseFromJson(String str) =>
    MoodCheckinResponse.fromJson(json.decode(str));

String moodCheckinResponseToJson(MoodCheckinResponse data) =>
    json.encode(data.toJson());

class MoodCheckinResponse {
  String message;
  MoodCheckinData data;
  bool success;
  int code;

  MoodCheckinResponse({
    required this.message,
    required this.data,
    required this.success,
    required this.code,
  });

  factory MoodCheckinResponse.fromJson(Map<String, dynamic> json) =>
      MoodCheckinResponse(
        message: json["message"],
        data: MoodCheckinData.fromJson(json["data"]),
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

class MoodCheckinData {
  int mood;
  String checkedInOn;
  MoodCheckinRecord checkin;

  MoodCheckinData({
    required this.mood,
    required this.checkedInOn,
    required this.checkin,
  });

  factory MoodCheckinData.fromJson(Map<String, dynamic> json) =>
      MoodCheckinData(
        mood: json["mood"],
        checkedInOn: json["checked_in_on"],
        checkin: MoodCheckinRecord.fromJson(json["checkin"]),
      );

  Map<String, dynamic> toJson() => {
        "mood": mood,
        "checked_in_on": checkedInOn,
        "checkin": checkin.toJson(),
      };
}

class MoodCheckinRecord {
  int id;
  String date;
  int mood;
  String? moodLabel;
  List<dynamic> factors;
  List<dynamic> factorLabels;
  String? note;

  MoodCheckinRecord({
    required this.id,
    required this.date,
    required this.mood,
    this.moodLabel,
    required this.factors,
    required this.factorLabels,
    required this.note,
  });

  factory MoodCheckinRecord.fromJson(Map<String, dynamic> json) =>
      MoodCheckinRecord(
        id: json["id"],
        date: json["date"],
        mood: json["mood"],
        moodLabel: json["mood_label"],
        factors:
            json["factors"] == null ? [] : List<dynamic>.from(json["factors"]),
        factorLabels: json["factor_labels"] == null
            ? []
            : List<dynamic>.from(json["factor_labels"]),
        note: json["note"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "date": date,
        "mood": mood,
        "mood_label": moodLabel,
        "factors": factors,
        "factor_labels": factorLabels,
        "note": note,
      };
}

/// Response for `GET /user/mood-checkins/today` — tells the app whether
/// today's check-in is already done server-side, so the popup's "should I
/// show" decision doesn't rely on a local date cache anymore.
class MoodCheckinTodayResponse {
  bool checkedIn;
  int? mood;
  String? checkedInOn;

  /// Null when [checkedIn] is false.
  MoodCheckinRecord? checkin;

  MoodCheckinTodayResponse({
    required this.checkedIn,
    this.mood,
    this.checkedInOn,
    this.checkin,
  });

  factory MoodCheckinTodayResponse.fromJson(Map<String, dynamic> json) =>
      MoodCheckinTodayResponse(
        checkedIn: json["checked_in"] ?? false,
        mood: json["mood"],
        checkedInOn: json["checked_in_on"],
        checkin: json["checkin"] == null
            ? null
            : MoodCheckinRecord.fromJson(json["checkin"]),
      );
}
