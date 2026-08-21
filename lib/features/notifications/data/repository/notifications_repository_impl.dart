import 'package:talkam/core/services/network/network_service.dart';
import 'package:talkam/core/services/network/url_config.dart';
import 'package:talkam/core/services/network/url_config_v2.dart';
import 'package:talkam/features/notifications/data/models/create_notifications_payload.dart';
import 'package:talkam/features/notifications/data/models/get_announcements_response.dart';
import 'package:talkam/features/notifications/data/models/get_notifications_response.dart';
import 'package:talkam/features/notifications/data/models/get_notifications_stats_response.dart';
import 'package:talkam/features/notifications/dormain/repository/notifications_repository.dart';

class NotificationRepositoryImpl extends NotificationsRepository {
  final NetworkService _networkService;
  final NetworkService _v2 = NetworkService(baseUrl: UrlConfigV2.coreBaseUrl);

  NotificationRepositoryImpl(this._networkService);

  @override
  Future<GetNotificationsResponse> getNotifications(int page,
      {String? tab}) async {
    final response = await _v2.call(
        UrlConfigV2.notificationsList(page), RequestMethod.get,
        queryParams: {"tab": tab});
    return GetNotificationsResponse.fromJson(response.data);
  }

  @override
  Future<dynamic> readNotification(String id) async {
    final response = await _v2.call(
        UrlConfigV2.notificationShow(id), RequestMethod.get,
        data: {"id": id});

    return response.data;
  }

  @override
  Future<dynamic> getNotificationDetails(String id) async {
    final response = await _networkService.call(
        UrlConfig.getNotificationDetailsEndpoint, RequestMethod.get,
        data: {"id": id});

    return response.data;
  }

  @override
  Future clearAllNotifications() async {
    final response = await _v2.call(
      UrlConfigV2.notificationsClearAll,
      RequestMethod.post,
    );

    return response.data;
  }

  @override
  Future createNotification(CreateNotificationPayload payload) async {
    final response = await _networkService.call(
        "UrlConfig.createNotifications", RequestMethod.post,
        data: payload.toJson());

    return response.data;
  }

  @override
  Future readAllNotifications() async {
    final response = await _v2.call(
      UrlConfigV2.notificationsMarkAll,
      RequestMethod.post,
    );

    return response.data;
  }

  @override
  Future<GetNotificationsStatsResponse> getNotificationsStats() async {
    final response = await _v2.call(
      UrlConfigV2.notificationsStatus,
      RequestMethod.get,
    );

    return GetNotificationsStatsResponse.fromJson(response.data);
  }

  @override
  Future<GetAnnounscementsResponse> getAllAnnouncements() async {
    final response = await _networkService.call(
      UrlConfig.getAnnouncements,
      RequestMethod.get,
    );
    return GetAnnounscementsResponse.fromJson(response.data);
  }

  @override
  Future<TalkamAnnouncement> getAnnouncementById(String id) async {
    final response = await _networkService.call(
        UrlConfig.getAnnouncementById(id), RequestMethod.post,
        data: {"id": id});

    return TalkamAnnouncement.fromJson(response.data);
  }
}
