import 'dart:io';
import 'dart:ui';
import 'dart:math';
import 'package:dart_ipify/dart_ipify.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:talkam/common/widgets/custom_dialogs.dart';

import 'package:share_plus/share_plus.dart';
import 'package:talkam/common/widgets/image_previewer.dart';
import 'package:talkam/common/widgets/image_widget.dart';
import 'package:talkam/core/constants/package_exports.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/core/navigation/route_url.dart';
import 'package:talkam/core/theme/pallets.dart';
import 'package:talkam/features/profile/presentation/bloc/profile_bloc/profile_bloc.dart';
import 'package:url_launcher/url_launcher.dart' as launch;
import 'package:url_launcher/url_launcher.dart';
import 'package:uuid/uuid.dart';

import '../_core.dart';
import '_utils.dart';
import 'guest_user_helper.dart';

class Helpers {
  // Helper method to handle mentions in text
  static void viewMentionedUserProfile(BuildContext context, String userName) {
    GuestUserHelper.handleGuestUserAction(
      action: () {
        var me = injector.get<ProfileBloc>().appUser;
        if (me?.username == userName) {
          context.pushNamed(
            PageUrl.profileScreen,
          );
        } else {
          context.pushNamed(PageUrl.userProfileScreen, extra: userName.toString());
        }
      },
    );
  }

  static Widget buildTextWithMentions(String text, BuildContext context, {double? fontSize, FontWeight? fontWeight, Function(String)? mentionCallback}) {
    List<TextSpan> spans = mentionSpans(text, fontSize: fontSize, fontWeight: fontWeight, mentionCallback: mentionCallback);

    return RichText(
      text: TextSpan(
        style: Theme.of(context).textTheme.bodyMedium,
        children: spans,
      ),
    );
  }

  static List<TextSpan> mentionSpans(String text, {double? fontSize, FontWeight? fontWeight, Function(String)? mentionCallback, TextStyle? textStyle}) {
    final List<TextSpan> spans = [];

    // Regex to find mentions in the format $@mention$
    final mentionRegExp = RegExp(r'\$@([\w_]+)\$');
    int start = 0;

    // Iterate over all matches and build the text with clickable mentions
    for (final match in mentionRegExp.allMatches(text)) {
      final mention = match.group(1) ?? '';

      // Add the text before the mention
      if (match.start > start) {
        spans.add(TextSpan(
          text: text.substring(start, match.start),
          style: textStyle ??
              TextStyle(
                fontSize: fontSize?.sp,
                fontWeight: fontWeight,
              ),
        ));
      }

      // Add the clickable mention
      spans.add(TextSpan(
        text: '@$mention',
        style: textStyle?.copyWith(
              // fontSize: ((fontSize ?? 14) - 1.5).sp,
              fontWeight: FontWeight.bold,
              color: Pallets.primary,
            ) ??
            TextStyle(
              fontSize: ((fontSize ?? 14) - 1.5).sp,
              fontWeight: FontWeight.bold,
              color: Colors.blue, // Mention color
            ),
        recognizer: TapGestureRecognizer()
          ..onTap = () {
            if (mentionCallback != null) {
              mentionCallback(mention);
            }
          },
      ));

      // Move the start index to the end of the mention
      start = match.end;
    }

    // Add remaining text after the last mention
    if (start < text.length) {
      spans.add(TextSpan(
        text: text.substring(start),
        style: textStyle?.copyWith(
              fontSize: fontSize,
              fontWeight: fontWeight,
            ) ??
            TextStyle(
              fontSize: fontSize,
              fontWeight: fontWeight,
            ),
      ));
    }
    return spans;
  }

  static String getFileName(File file, {String? prefix}) {
    var name = file.path.split('/').last;
    if (prefix != null) {
      name = "$prefix.${name.split(".").last}";
    }
    return name;
  }

  static num? calculateDistance(num? lat1, num? lon1, num? lat2, num? lon2) {
    if (lat1 == null || lon1 == null || lat2 == null || lon2 == null) {
      return null;
    }

    const double earthRadius = 6371;

    double degreesToRadians(num degrees) {
      return degrees * pi / 180;
    }

    num dLat = degreesToRadians(lat2 - lat1);
    num dLon = degreesToRadians(lon2 - lon1);

    num a = sin(dLat / 2) * sin(dLat / 2) + cos(degreesToRadians(lat1)) * cos(degreesToRadians(lat2)) * sin(dLon / 2) * sin(dLon / 2);
    num c = 2 * atan2(sqrt(a), sqrt(1 - a));

    return (earthRadius * c).floor();
  }

  static launchRawUrl(String data) async {
    final launcher = UrlLauncher();

    await launcher.launchRawUrl(data);
  }

  static launchUrl(String? data) async {
    final launcher = UrlLauncher();

    if (data == null) {
      await launcher.launchURL(
        'https://app.google.io/',
      );
      return;
    }

    if (data.isEmail) {
      await launcher.sendEmail(data);

      return;
    }

    if (data.isPhoneNumber) {
      await launcher.dialPhoneNumber(data);
      return;
    }

    await launcher.launchURL(data);
  }

  static launchInappWebView(String url) {
    launch.launchUrl(Uri.parse(url), mode: LaunchMode.inAppWebView, webViewConfiguration: const WebViewConfiguration());
  }

  static void share(String text) {
    Share.share(text);
  }

  static String generateUniqueId() {
    // Create uuid object
    var uuid = const Uuid();

    return uuid.v1();
  }

  static bool hasTextOverflow(String text, TextStyle style, {double minWidth = 0, int maxLines = 3}) {
    final TextPainter textPainter = TextPainter(
      text: TextSpan(text: text, style: style),
      maxLines: maxLines,
      textDirection: TextDirection.ltr,
    )..layout(
        minWidth: minWidth,
        maxWidth: window.physicalSize.width,
      );
    return textPainter.didExceedMaxLines;
  }

  static Future copy(String text) async {
    await Clipboard.setData(
      ClipboardData(
        text: text,
      ),
    ).then(
      (value) => CustomDialogs.showToast('Copied to clipboard'),
    );
  }

  static Future<String> deviceName() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

    if (!Platform.isIOS && !Platform.isAndroid) {
      return 'N/A';
    }
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;

      return androidInfo.model;
    }

    IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
    return iosInfo.utsname.machine ?? 'N/A';
  }

  static Future<String> get selfIP async {
    final ipv4 = await Ipify.ipv4();

    return ipv4;
  }

  static String? calculateAge(String dateOfBirth) {
    if (dateOfBirth.isEmpty) {
      return null;
    }
    DateTime dob = DateTime.parse(dateOfBirth);

    DateTime now = DateTime.now();

    Duration difference = now.difference(dob);

    int age = (difference.inDays / 365).floor();

    return age.toString();
  }

  static void launchTelegram(String groupName) async {
    String url = "https://t.me/$groupName";

    if (await launch.canLaunchUrl(Uri.parse(url))) {
      await launch.launchUrl(
        Uri.parse(url),
        mode: launch.LaunchMode.externalApplication,
      );
    }
  }

  static launchWhatsappLink(String data) async {
    final launcher = UrlLauncher();

    await launcher.launchRawUrl(data);
  }

  static launchEmailWithMessage({
    required String email,
    String? message,
    String? subject,
  }) async {
    final launcher = UrlLauncher();
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: email,
      query: encodeQueryParameters(<String, String>{
        'subject': subject.toString(),
        'body': message.toString(),
      }),
    );

    await launcher.launchRawUrl(emailLaunchUri.toString());
  }

  static String? encodeQueryParameters(Map<String, String> params) {
    return params.entries.map((MapEntry<String, String> e) => '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}').join('&');
  }

// Function toget the file extension from a URL or path
  static String getFileExtension(String urlOrPath) {
    final fileName = urlOrPath.split('/').last;
    final parts = fileName.split('.');
    if (parts.length > 1) {
      return parts.last.toLowerCase();
    } else {
      return ''; // No extension found
    }
  }

// Function to open the document using the appropriate method
  static Future<void> openDocument(String urlOrPath, BuildContext context) async {
    final extension = getFileExtension(urlOrPath);

    // Check if it's an image or GIF
    if (['jpg', 'jpeg', 'png', 'gif'].contains(extension)) {
      _showImageDialog(urlOrPath, context);
    } else {
      final _launchUrl = urlOrPath;
      if (await canLaunchUrl(Uri.parse(_launchUrl))) {
        await launch.launchUrl(
          Uri.parse(_launchUrl),
          mode: launch.LaunchMode.externalApplication,
        );
      } else {
        CustomDialogs.error("Cannot open file");
      }
    }
  }

// Helper function to show an image dialog
  static void _showImageDialog(String urlOrPath, BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => ImagePreviewer(
        imageUrl: urlOrPath,
        imageType: urlOrPath.isURL ? ImageType.network : ImageType.file,
      ),
    );
  }

  static String getFileNameFromUrl(String url) {
    if (url.isEmpty) {
      return ''; // Return empty string for emptyURLs
    }

    // Remove any query parameters or fragments
    final uri = Uri.parse(url);
    final path = uri.path;

    // Split the path by '/' and get the last part
    final parts = path.split('/');
    if (parts.isNotEmpty) {
      return parts.last;
    } else {
      return ''; // Return empty string if no file name is found
    }
  }

  static bool pathIsImage(String filePath) {
    final extension = filePath.split('.').last.toLowerCase();
    final imageExtensions = ['jpg', 'jpeg', 'png', 'gif', 'bmp', 'webp'];
    return imageExtensions.contains(extension);
  }

  static bool pathIsDocument(String filePath) {
    final extension = filePath.split('.').last.toLowerCase();
    final documentExtensions = ['pdf', 'doc', 'docx', 'xls', 'xlsx', 'ppt', 'pptx', 'txt'];
    return documentExtensions.contains(extension);
  }
}
