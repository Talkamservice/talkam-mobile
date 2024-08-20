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
  Future<GetGroupsResponse> getGroups(
      {required int? page, GroupsFilterModel? filter}) async {
    try {
      final response = await _networkService.call(
          UrlConfig.getGroups, RequestMethod.get, queryParams: {
        "page": (page ?? 1).toString(),
        ...(filter ?? GroupsFilterModel.all()).toJson()
      });
      return GetGroupsResponse.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<dynamic> getFollowingGroupMembers() async {
    try {
      final response = await _networkService.call(
          UrlConfig.getFollowingGroupMembers, RequestMethod.get);
      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<TalkamGroup> updateGroup(
      String groupId, CreateGroupPayload payload) async {
    try {
      var imageUrl = payload.image.isURL
          ? payload.image
          : await FirebaseStorageService().uploadImage(
              FirebaseStoragePaths.groupImage, File(payload.image));

      final response = await _networkService.call(
          UrlConfig.createGroup, RequestMethod.post,
          data: payload.copyWith(image: imageUrl).toJson());
      return TalkamGroup.fromJson(response.data['data']);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<TalkamGroup> getGroup(String groupId) async {
    try {
      final response = await _networkService.call(
          '${UrlConfig.getGroup}$groupId', RequestMethod.get);
      return TalkamGroup.fromJson(response.data['data']);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<dynamic> deleteGroup(String groupId) async {
    try {
      final response = await _networkService.call(
          '${UrlConfig.deleteGroup}$groupId', RequestMethod.delete);
      return TalkamGroup.fromJson(response.data['data']);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<TalkamGroup> createGroup(CreateGroupPayload payload) async {
    try {
      var imageUrl = await FirebaseStorageService()
          .uploadImage(FirebaseStoragePaths.groupImage, File(payload.image));
      final response = await _networkService.call(
          UrlConfig.createGroup, RequestMethod.post,
          data: payload.copyWith(image: imageUrl).toJson());
      return TalkamGroup.fromJson(response.data['data']);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future join({required String groupId, required String userId}) async {
    try {
      final response = await _networkService.call(
        UrlConfig.groupMembers,
        RequestMethod.post,
      );
      return response.data;
    } catch (e) {
      rethrow;
    }
  }
}
