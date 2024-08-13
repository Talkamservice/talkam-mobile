abstract class GroupMembersAccessRepository {
  Future<dynamic> getPendingGroupMembers(String groupId);
  Future<dynamic> requestAccess(String groupId);
  Future<dynamic> updateAccessRequest(String groupId, Map<String, dynamic> accessData);
  Future<dynamic> deleteGroupMember(String memberId);
}

