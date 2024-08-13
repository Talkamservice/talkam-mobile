import 'package:talkam/features/group/data/models/groups_filter_model.dart';
import 'package:talkam/features/search/data/models/get_group_response.dart';

abstract class GroupsRepository {
  Future<GetGroupsResponse> getGroups(
      {required int? page, GroupsFilterModel? filter});

  Future<dynamic> getFollowingGroupMembers();

  Future<dynamic> updateGroup(String groupId, Map<String, dynamic> groupData);

  Future<dynamic> getGroup(String groupId);

  Future<dynamic> deleteGroup(String groupId);
}
