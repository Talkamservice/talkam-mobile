import 'package:talkam/features/group/data/models/get_group_members_response.dart';

abstract class GroupMembersRepository {
  Future<GetGroupMembersResponse> getGroupMembers(String groupId);
  Future<dynamic> addGroupMember(Map<String, dynamic> memberData);
  Future<dynamic> updateMemberRole(String memberId, Map<String, dynamic> roleData);
  Future<GroupMemberDetails> getMember(String memberId);
  Future<dynamic> deleteMember(String memberId);
}

