import 'package:talkam/features/group/data/models/create_group_payload.dart';
import 'package:talkam/features/group/data/models/groups_filter_model.dart';
import 'package:talkam/features/search/data/models/get_group_response.dart';

abstract class GroupsRepository {
  /// v2 browse/discovery — filters by [categoryId]/[search] only, no `tab`.
  /// Use [getFollowedGroups]/[getSuggestedGroups] for those specific lists.
  Future<GetGroupsResponse> getGroups(
      {int? page, String? categoryId, String? search});

  Future<GetGroupsResponse> getFollowedGroups({int? page});

  Future<GetGroupsResponse> getSuggestedGroups({int? page});

  Future<GetGroupsResponse> getPromotedGroups();

  Future<dynamic> getFollowingGroupMembers();

  Future<TalkamGroup> updateGroup(String groupId, CreateGroupPayload payload);

  Future<TalkamGroup> getGroup(String groupId);

  Future<TalkamGroup> createGroup(CreateGroupPayload payload);

  Future<dynamic> deleteGroup(String groupId);

  Future<dynamic> join({required String groupId, required String userId});

  /// Lighter follow relationship — updates without membership (Follow !=
  /// Join). Returns the new `following` state.
  Future<bool> toggleFollowGroup(String groupId);

  Future<dynamic> inviteToGroup(
      {required String groupId, required String email});

  Future<dynamic> acceptGroupInvite(String uuid);

  Future<dynamic> reportGroup(
      {required String groupId, required String reason});

  Future<dynamic> getGroupRules({
    required String groupId,
  });

  Future<GroupGuideline> addGroupRule(
      {required String groupId, required GuidelinePayload rule});

  Future<dynamic> deleteGroupRule({
    required String guidelineId,
  });
}
