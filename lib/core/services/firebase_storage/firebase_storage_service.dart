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
    try {
      logger.i(imageFile.path);
      final reference = _storage.ref().child(path);
      final uploadTask = reference.putFile(imageFile);

      final snapshot = await uploadTask.whenComplete(() => null);
      final url = await snapshot.ref.getDownloadURL();
      return url;
    }  catch (e,stack) {
      // Handle errors (e.g., network issues, permission denied)
      logger.e('Error uploading image: ${e.toString()}');
      logger.e(stack);
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
