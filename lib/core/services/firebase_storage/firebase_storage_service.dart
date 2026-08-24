import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:path/path.dart' as path;

class FirebaseStorageService {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<List<String>> uploadMultipleFiles(
      String basePath, List<File> files) async {
    try {
      final List<Future<String>> uploadFutures = files.map((file) async {
        // var extension = path.extension(file.path);
        final String fileName = file.path.split('/').last; // Get filename
        final String filePath = '$basePath/$fileName';

        return await uploadFile(filePath, file);
      }).toList();

      // final List<String> downloadUrls = await Future.wait(uploadFutures);
      return Future.wait(uploadFutures);
    } catch (e) {
      rethrow;
    }
  }

  Future<String> uploadFile(String path, File imageFile) async {
    final reference = _storage.ref().child(path);
    try {
      logger.i(
          'Uploading ${imageFile.path} -> ${reference.bucket}/${reference.fullPath}');
      final uploadTask = reference.putFile(imageFile);
      final snapshot = await uploadTask;
      final url = await snapshot.ref.getDownloadURL();
      return url;
    } on FirebaseException catch (e, stack) {
      // FirebaseException.message is often a generic platform-channel
      // string ("An unknown error occurred") even when the underlying
      // Firebase service returned a specific reason — the real detail
      // (e.g. a billing-plan block) only reaches native Android/iOS logs,
      // not Dart. code/plugin still narrow it down; log everything we do
      // have rather than just message.
      logger.e(
        'Firebase Storage upload failed for ${reference.fullPath} — '
        'code: ${e.code}, plugin: ${e.plugin}, message: ${e.message}',
        error: e,
        stackTrace: stack,
      );
      rethrow;
    } catch (e, stack) {
      logger.e('Unexpected error uploading ${reference.fullPath}: $e',
          error: e, stackTrace: stack);
      rethrow;
    }
  }
}

class FirebaseStoragePaths {
  static const String profilePictures = 'profile_pictures';
  static const String productImages = 'product_images';
  static const String chatFiles = 'chat_files';
  static const String posts = 'posts';
  static const String comments = 'posts';
  static const String groupImage = 'group_images';
}
