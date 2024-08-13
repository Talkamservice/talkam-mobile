abstract class GroupMembersRepository {
  Future<dynamic> getGroupMembers(String groupId);
  Future<dynamic> addGroupMember(Map<String, dynamic> memberData);
  Future<dynamic> updateMemberRole(String memberId, Map<String, dynamic> roleData);
  Future<dynamic> getMember(String memberId);
  Future<dynamic> deleteMember(String memberId);
}

