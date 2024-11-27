// To parse this JSON data, do
//
//     final updateStatPayLoad = updateStatPayLoadFromJson(jsonString);

import 'dart:convert';

UpdateStatPayLoad updateStatPayLoadFromJson(String str) => UpdateStatPayLoad.fromJson(json.decode(str));

String updateStatPayLoadToJson(UpdateStatPayLoad data) => json.encode(data.toJson());

class UpdateStatPayLoad {
  int? postId;
  int? groupId;
  bool? comments;
  bool? likes;
  bool? dislikes;
  bool? shares;
  bool? engagements;
  bool? followers;
  bool? profileVisits;
  bool? clicks;
  int? timeSpent;

  UpdateStatPayLoad({
    this.postId,
    this.groupId,
    this.comments,
    this.likes,
    this.dislikes,
    this.shares,
    this.engagements,
    this.followers,
    this.profileVisits,
    this.clicks,
    this.timeSpent,
  });

  UpdateStatPayLoad copyWith({
    int? postId,
    int? groupId,
    bool? comments,
    bool? likes,
    bool? dislikes,
    bool? shares,
    bool? engagements,
    bool? followers,
    bool? profileVisits,
    bool? clicks,
    int? timeSpent,
  }) =>
      UpdateStatPayLoad(
        postId: postId ?? this.postId,
        groupId: groupId ?? this.groupId,
        comments: comments ?? this.comments,
        likes: likes ?? this.likes,
        dislikes: dislikes ?? this.dislikes,
        shares: shares ?? this.shares,
        engagements: engagements ?? this.engagements,
        followers: followers ?? this.followers,
        profileVisits: profileVisits ?? this.profileVisits,
        clicks: clicks ?? this.clicks,
        timeSpent: timeSpent ?? this.timeSpent,
      );

  factory UpdateStatPayLoad.fromJson(Map<String, dynamic> json) => UpdateStatPayLoad(
    postId: json["post_id"],
    groupId: json["group_id"],
    comments: json["comments"],
    likes: json["likes"],
    dislikes: json["dislikes"],
    shares: json["shares"],
    engagements: json["engagements"],
    followers: json["followers"],
    profileVisits: json["profile_visits"],
    clicks: json["clicks"],
    timeSpent: json["time_spent"],
  );

  Map<String, dynamic> toJson() => {
    "post_id": postId,
    "group_id": groupId,
    "comments": comments,
    "likes": likes,
    "dislikes": dislikes,
    "shares": shares,
    "engagements": engagements,
    "followers": followers,
    "profile_visits": profileVisits,
    "clicks": clicks,
    "time_spent": timeSpent,
  };
}
