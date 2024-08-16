import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:talkam/core/di/injector.dart';

class FirebaseStorageService {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<List<String>> uploadMultipleFiles(
      String basePath, List<File> files) async {
    try {

      final List<Future<String>> uploadFutures = files.map((file) async {
        final String fileName = file.path.split('/').last; // Get filename
        final String filePath = '$basePath/$fileName';

        return await uploadImage(filePath, file);
      }).toList();

      // final List<String> downloadUrls = await Future.wait(uploadFutures);
      return Future.wait(uploadFutures);
    } catch (e) {
      rethrow;
    }
  }

  Future<String> uploadImage(String path, File imageFile) async {
    try {
      final reference = _storage.ref().child(path);
      final uploadTask = reference.putFile(imageFile);

      final snapshot = await uploadTask.whenComplete(() => null);
      final url = await snapshot.ref.getDownloadURL();
      return url;
    } on FirebaseException catch (e) {
      // Handle errors (e.g., network issues, permission denied)
      logger.e('Error uploading image: ${e.message}');
      rethrow;
    }
  }



}

class FirebaseStoragePaths {
  static const String profilePictures = 'profile_pictures';
  static const String productImages = 'product_images';
  static const String chatImages = 'chat_images';
  static const String posts = 'posts';
  static const String groupImage = 'group_images';
}
