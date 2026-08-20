import 'package:talkam/features/post/data/models/get_categories_response.dart';
import 'package:talkam/features/search/data/models/get_group_response.dart';

/// `GET /user/drawer` (v2) — one aggregate call backing the side drawer:
/// profile card, follow counts, followed topics, groups, and private groups.
/// `topics` is the same shape as `GET /user/interest-topics`, so it reuses
/// [PostCategory] rather than a parallel model.
class DrawerResponse {
  const DrawerResponse({
    required this.profile,
    required this.followingCount,
    required this.followersCount,
    required this.topics,
    required this.groups,
    required this.privateGroups,
  });

  final DrawerProfile profile;
  final int followingCount;
  final int followersCount;
  final List<PostCategory> topics;
  final List<TalkamGroup> groups;
  final List<TalkamGroup> privateGroups;

  factory DrawerResponse.fromJson(Map<String, dynamic> json) => DrawerResponse(
        profile: DrawerProfile.fromJson(json['profile'] ?? {}),
        followingCount: json['following_count'] ?? 0,
        followersCount: json['followers_count'] ?? 0,
        topics: (json['topics'] as List? ?? [])
            .map((e) => PostCategory.fromJson(Map<String, dynamic>.from(e)))
            .toList(),
        groups: (json['groups'] as List? ?? [])
            .map((e) => TalkamGroup.fromJson(Map<String, dynamic>.from(e)))
            .toList(),
        privateGroups: (json['private_groups'] as List? ?? [])
            .map((e) => TalkamGroup.fromJson(Map<String, dynamic>.from(e)))
            .toList(),
      );
}

class DrawerProfile {
  const DrawerProfile({
    required this.name,
    required this.username,
    this.avatar,
    required this.isVerified,
  });

  final String name;
  final String username;
  final String? avatar;
  final bool isVerified;

  factory DrawerProfile.fromJson(Map<String, dynamic> json) => DrawerProfile(
        name: json['name'] ?? '',
        username: json['username'] ?? '',
        avatar: json['avatar'],
        isVerified: json['is_verified'] ?? false,
      );
}
