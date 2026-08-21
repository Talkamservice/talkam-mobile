import 'package:talkam/features/notifications/data/models/create_notifications_payload.dart';
import 'package:talkam/features/notifications/data/models/get_announcements_response.dart';
import 'package:talkam/features/notifications/data/models/get_notifications_response.dart';
import 'package:talkam/features/notifications/data/models/get_notifications_stats_response.dart';

abstract class NotificationsRepository {
  Future<GetNotificationsResponse> getNotifications(int page, {String? tab});

  Future<GetNotificationsStatsResponse> getNotificationsStats();

  /// `GET /user/notifications/{id}/show` — marking-as-read is a side effect
  /// of viewing it; the response echoes the notification back with `read_at`
  /// now stamped.
  Future<TalkamNotification> readNotification(String id);

  Future<dynamic> getNotificationDetails(String id);

  Future<dynamic> clearAllNotifications();

  Future<dynamic> readAllNotifications();

  Future<dynamic> createNotification(CreateNotificationPayload payload);

  Future<GetAnnounscementsResponse> getAllAnnouncements();

  Future<TalkamAnnouncement> getAnnouncementById(String id);
}
