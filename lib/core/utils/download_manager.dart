import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:dio/dio.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/core/theme/pallets.dart';
import 'package:uuid/uuid.dart';

class DownloadManager {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> downloadFile(String url, String savePath) async {
    final notificationId = Uuid().v4();
    await _initializeNotificationChannel();

    // Create download task
    Dio dio = Dio();
    try {
      await dio.download(
        url,
        savePath,
        onReceiveProgress: (received, total) {
          final progress = (received / total) * 100;
          logger.w(progress);

          _updateNotification(notificationId, progress, savePath: savePath);
        },
      );
      _updateNotification(notificationId, 100,
          completed: true, savePath: savePath);
    } catch (e) {
      _updateNotification(notificationId, 0,
          error: true, errorMessage: e.toString(), savePath: savePath);
    }
  }

  Future<void> _initializeNotificationChannel() async {
    const channel = AndroidNotificationChannel(
      'download_channel',
      'Download Notifications',
      importance: Importance.high,
      enableLights: true,
      showBadge: true,
      playSound: true,
    );

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
  }

  Future<void> _updateNotification(String notificationId, double progress,
      {bool completed = false,
      bool error = false,
      String errorMessage = '',
      required String savePath}) async {
    const notificationDetails = NotificationDetails(
      android: AndroidNotificationDetails(
          'download_channel', 'Download Notifications',
          icon: 'launcher',
          importance: Importance.defaultImportance,
          priority: Priority.high,
          enableLights: true,
          color: Pallets.primary,
          actions: [
            AndroidNotificationAction('view_file', 'View File',
                showsUserInterface: true),
            AndroidNotificationAction('open_folder', 'Open Folder',
                showsUserInterface: true),
          ]
          // ... add other notification details as needed
          ),
      iOS: DarwinNotificationDetails(
        presentAlert: true,
        presentBadge: true,
        presentSound: true,
      ),
    );

    final content = progress < 100

        ? 'Downloading... ${progress.toStringAsFixed(2)}%'
        : (completed ? 'Download Complete' : 'Download Error: $errorMessage');

    await flutterLocalNotificationsPlugin.show(
      notificationId.hashCode,
      'Download Progress',
      content.toString(),
      notificationDetails,

      payload: jsonEncode(
          {'type': 'file', 'filePath': savePath}), // Uncomment for tap action
    );
  }
}
