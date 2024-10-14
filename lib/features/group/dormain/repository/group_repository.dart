import 'package:talkam/features/group/data/models/create_group_payload.dart';
import 'package:talkam/features/group/data/models/groups_filter_model.dart';
import 'package:talkam/features/search/data/models/get_group_response.dart';

abstract class GroupsRepository {
  Future<GetGroupsResponse> getGroups({required int? page, GroupsFilterModel? filter, bool? isFollowing = false});

  Future<dynamic> getFollowingGroupMembers();

  Future<TalkamGroup> updateGroup(String groupId, CreateGroupPayload payload);

  Future<TalkamGroup> getGroup(String groupId);

  Future<TalkamGroup> createGroup(CreateGroupPayload payload);

  Future<dynamic> deleteGroup(String groupId);

  Future<dynamic> join({required String groupId, required String userId});

  Future<dynamic> reportGroup({required String groupId, required String reason});

  Future<dynamic> getGroupRules({
    required String groupId,
  });

  Future<GroupGuideline> addGroupRule({required String groupId, required GuidelinePayload rule});

  Future<dynamic> deleteGroupRule({
    required String guidelineId,
  });
}
