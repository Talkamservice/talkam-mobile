import 'dart:io';
import 'package:dio/dio.dart';
import 'package:talkam/core/_core.dart';
import 'package:talkam/core/services/firebase_storage/firebase_storage_service.dart';
import 'package:talkam/core/services/network/network_service.dart';
import 'package:talkam/core/services/network/url_config.dart';
import 'package:talkam/core/services/network/url_config_v2.dart';
import 'package:talkam/features/group/data/models/create_group_payload.dart';
import 'package:talkam/features/group/dormain/repository/group_repository.dart';
import 'package:talkam/features/search/data/models/get_group_response.dart';

class GroupsRepositoryImpl extends GroupsRepository {
  final NetworkService _networkService;

  /// Browse/discovery, detail, join, leave, follow-toggle, followed/
  /// suggested lists, invites, request-access, and report have migrated to
  /// /api/v2 — update/create/delete group and guideline CRUD stay on v1
  /// until they migrate too.
  final NetworkService _v2 = NetworkService(baseUrl: UrlConfigV2.coreBaseUrl);

  /// Form-data requests must build their own [Options] so Dio can infer the
  /// multipart content type (the default options force `application/json`).
  /// The Authorization header is automatically injected by [_AuthInterceptor].
  Options get _formOptions => Options(headers: {
        "Accept": "application/json",
      });

  GroupsRepositoryImpl(this._networkService);

  @override
  Future<GetGroupsResponse> getGroups(
      {int? page, String? categoryId, String? search}) async {
    try {
      final response = await _v2.call(
        UrlConfigV2.groups,
        RequestMethod.get,
        queryParams: {
          "page": (page ?? 1).toString(),
          if (categoryId != null && categoryId.isNotEmpty)
            "category_id": categoryId,
          if (search != null && search.isNotEmpty) "search": search,
        },
      );
      return GetGroupsResponse.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<GetGroupsResponse> getFollowedGroups({int? page}) async {
    try {
      final response = await _v2.call(
        UrlConfigV2.followedGroups,
        RequestMethod.get,
        queryParams: {"page": (page ?? 1).toString()},
      );
      return GetGroupsResponse.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<GetGroupsResponse> getSuggestedGroups({int? page}) async {
    try {
      final response = await _v2.call(
        UrlConfigV2.suggestedGroups,
        RequestMethod.get,
        queryParams: {"page": (page ?? 1).toString()},
      );
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
          : await FirebaseStorageService()
              .uploadFile(FirebaseStoragePaths.groupImage, File(payload.image));

      final response = await _networkService.call(
          "${UrlConfig.updateGroup}/$groupId", RequestMethod.put,
          data: payload.copyWith(image: imageUrl).toJson());
      return TalkamGroup.fromJson(response.data['data']);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<TalkamGroup> getGroup(String groupId) async {
    try {
      final response =
          await _v2.call(UrlConfigV2.groupDetail(groupId), RequestMethod.get);
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
          .uploadFile(FirebaseStoragePaths.groupImage, File(payload.image));
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
      final response = await _v2.call(
        UrlConfigV2.groupMembers,
        RequestMethod.post,
        formData: FormData.fromMap({"group_id": groupId, "user_id": userId}),
        options: _formOptions,
      );
      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<bool> toggleFollowGroup(String groupId) async {
    try {
      final response = await _v2.call(
        UrlConfigV2.groupFollowToggle,
        RequestMethod.post,
        formData: FormData.fromMap({"group_id": groupId}),
        options: _formOptions,
      );
      return response.data["data"]["following"] as bool;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<dynamic> inviteToGroup(
      {required String groupId, required String email}) async {
    try {
      final response = await _v2.call(
        UrlConfigV2.inviteToGroup(groupId),
        RequestMethod.post,
        formData: FormData.fromMap({"email": email}),
        options: _formOptions,
      );
      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<dynamic> acceptGroupInvite(String uuid) async {
    try {
      final response = await _v2.call(
        UrlConfigV2.acceptGroupInvite,
        RequestMethod.post,
        formData: FormData.fromMap({"uuid": uuid}),
        options: _formOptions,
      );
      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<GroupGuideline> addGroupRule(
      {required String groupId, required GuidelinePayload rule}) async {
    try {
      final response = await _networkService.call(
          UrlConfig.guideline, RequestMethod.post, data: {
        "group_id": groupId,
        "title": rule.title,
        "description": rule.description
      });
      return GroupGuideline.fromJson(response.data["data"]);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future getGroupRules({required String groupId}) async {
    try {
      final response = await _networkService
          .call(UrlConfig.guideline, RequestMethod.get, queryParams: {
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
      final response = await _v2.call(
        UrlConfigV2.reportGroup,
        RequestMethod.post,
        formData: FormData.fromMap({"group_id": groupId, "reason": reason}),
        options: _formOptions,
      );
      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<GetGroupsResponse> getPromotedGroups() async {
    try {
      final response = await _networkService.call(
        UrlConfig.getPromotedGroups,
        RequestMethod.get,
      );
      return GetGroupsResponse.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<TalkamGroup>> getRecentGroups() async {
    try {
      final response = await _v2.call(
        UrlConfigV2.recentsFetch,
        RequestMethod.get,
        queryParams: {"sort": "group"},
      );
      final data = response.data['data'] as List? ?? [];
      return data
          .map((e) => TalkamGroup.fromJson(Map<String, dynamic>.from(e)))
          .toList();
    } catch (e) {
      rethrow;
    }
  }
}
