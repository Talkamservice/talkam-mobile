import 'package:talkam/common/models/get_countries_response.dart';
import 'package:talkam/common/models/get_states_response.dart';

class CreatePromotionPayload {
  final int? postId;
  final int? groupId;
  final TalkamCountry? country;
  final TalkamState? state;
  final int? minAge;
  final int? maxAge;
  final String? gender;
  final double? dailyBudget;
  final int? duration;
  final Map<String, dynamic>? data;

  CreatePromotionPayload({
     this.postId,
     this.groupId,
    required this.country,
    this.state,
     this.minAge,
     this.maxAge,
    this.gender,
    required this.dailyBudget,
    required this.duration,
    required this.data,
  });

  // Method to convert the model to a map (for serialization)
  Map<String, dynamic> toMap() {
    return {
      'post_id': postId,
      'group_id': groupId,
      'country_id': country?.id,
      'state_id': state?.id,
      'min_age': minAge,
      'max_age': maxAge,
      'gender': gender == "All gender" ? "" : gender,
      'daily_budget': dailyBudget,
      'duration': duration,
      'payload': data,
    };
  }

  // Factory method to create a model instance from a map (for deserialization)
  factory CreatePromotionPayload.fromMap(Map<String, dynamic> map) {
    return CreatePromotionPayload(
      postId: map['post_id'],
      groupId: map['group_id'],
      country: map['country_id'],
      state: map['state_id'],
      minAge: map['min_age'],
      maxAge: map['max_age'],
      gender: map['gender'],
      dailyBudget: map['daily_budget'],
      duration: map['duration'],
      data: Map<String, dynamic>.from(map['payload'] ?? {}),
    );
  }

  // CopyWith method to create a new instance with updated fields
  CreatePromotionPayload copyWith({
    int? postId,
    int? groupId,
    TalkamCountry? country,
    TalkamState? state,
    int? minAge,
    int? maxAge,
    String? gender,
    double? dailyBudget,
    int? duration,
    Map<String, dynamic>? data,
  }) {
    return CreatePromotionPayload(
      postId: postId ?? this.postId,
      groupId: groupId ?? this.groupId,
      country: country ?? this.country,
      state: state ?? this.state,
      minAge: minAge ?? this.minAge,
      maxAge: maxAge ?? this.maxAge,
      gender: gender ?? this.gender,
      dailyBudget: dailyBudget ?? this.dailyBudget,
      duration: duration ?? this.duration,
      data: data ?? this.data,
    );
  }
}
