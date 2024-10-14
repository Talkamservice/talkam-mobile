import 'dart:io';
import 'package:talkam/core/_core.dart';
import 'package:talkam/core/services/firebase_storage/firebase_storage_service.dart';
import 'package:talkam/core/services/network/network_service.dart';
import 'package:talkam/core/services/network/url_config.dart';
import 'package:talkam/features/group/data/models/create_group_payload.dart';
import 'package:talkam/features/group/data/models/groups_filter_model.dart';
import 'package:talkam/features/group/dormain/repository/group_repository.dart';
import 'package:talkam/features/search/data/models/get_group_response.dart';

class GroupsRepositoryImpl extends GroupsRepository {
  final NetworkService _networkService;

  GroupsRepositoryImpl(this._networkService);

  @override
  Future<GetGroupsResponse> getGroups({required int? page, GroupsFilterModel? filter, bool? isFollowing = false}) async {
    try {
      final response = await _networkService.call((isFollowing ?? false) ? UrlConfig.getMyGroups : UrlConfig.getGroups, RequestMethod.get,
          queryParams: {"page": (page ?? 1).toString(), ...(filter ?? GroupsFilterModel.all()).toJson()});
      return GetGroupsResponse.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<dynamic> getFollowingGroupMembers() async {
    try {
      final response = await _networkService.call(UrlConfig.getFollowingGroupMembers, RequestMethod.get);
      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<TalkamGroup> updateGroup(String groupId, CreateGroupPayload payload) async {
    try {
      var imageUrl = payload.image.isURL ? payload.image : await FirebaseStorageService().uploadFile(FirebaseStoragePaths.groupImage, File(payload.image));

      final response = await _networkService.call("${UrlConfig.updateGroup}/$groupId", RequestMethod.put, data: payload.copyWith(image: imageUrl).toJson());
      return TalkamGroup.fromJson(response.data['data']);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<TalkamGroup> getGroup(String groupId) async {
    try {
      final response = await _networkService.call('${UrlConfig.getGroup}$groupId', RequestMethod.get);
      return TalkamGroup.fromJson(response.data['data']);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<dynamic> deleteGroup(String groupId) async {
    try {
      final response = await _networkService.call('${UrlConfig.deleteGroup}$groupId', RequestMethod.delete);
      return TalkamGroup.fromJson(response.data['data']);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<TalkamGroup> createGroup(CreateGroupPayload payload) async {
    try {
      var imageUrl = await FirebaseStorageService().uploadFile(FirebaseStoragePaths.groupImage, File(payload.image));
      final response = await _networkService.call(UrlConfig.createGroup, RequestMethod.post, data: payload.copyWith(image: imageUrl).toJson());
      return TalkamGroup.fromJson(response.data['data']);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future join({required String groupId, required String userId}) async {
    try {
      final response = await _networkService.call(UrlConfig.groupMembers, RequestMethod.post, data: {"group_id": groupId, "user_id": userId});
      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<GroupGuideline> addGroupRule({required String groupId, required GuidelinePayload rule}) async {
    try {
      final response = await _networkService
          .call(UrlConfig.guideline, RequestMethod.post, data: {"group_id": groupId, "title": rule.title, "description": rule.description});
      return GroupGuideline.fromJson(response.data["data"]);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future getGroupRules({required String groupId}) async {
    try {
      final response = await _networkService.call(UrlConfig.guideline, RequestMethod.get, queryParams: {
        "group_id": groupId,
      });

      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future deleteGroupRule({required String guidelineId}) async {
    try {
      final response = await _networkService.call(
        "${UrlConfig.guideline}/$guidelineId",
        RequestMethod.delete,
      );
      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future reportGroup({required String groupId, required String reason}) async {
    try {
      final response = await _networkService.call(UrlConfig.reportGroup, RequestMethod.post, data: {"group_id": groupId, "reason": reason});
      return response.data;
    } catch (e) {
      rethrow;
    }
  }
}
