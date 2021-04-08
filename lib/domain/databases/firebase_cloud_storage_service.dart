import 'dart:io';
import 'package:adonis_web_test/domain/databases/databases.dart';
import 'package:adonis_web_test/domain/models/models.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final storageCloudService = Provider<FirebaseStorageService>((ref) {
  return FirebaseStorageService(read: ref.read);
});

class FirebaseStorageService implements CloudStorageRepository {
  FirebaseStorage _storage;
  final Reader read;

  FirebaseStorageService({Reader read})
      : _storage = FirebaseStorage.instance,
        this.read = read;

  ///Upload a new user profile photo to firebase storage in the [user_images]
  ///storage folder in the main bucket, labelled by their uid via the userStateController.
  @override
  Future<void> addNewUserProfilephoto(File imageFile, String uid) async {
    try {
      //reference to location of user profile image id
      final ref = _storage.ref().child('profile_pictures').child(uid);
      await ref.putFile(imageFile);
    } on FirebaseException catch (e) {
      throw Failure(error: e.code, message: e.message);
    } catch (e) {
      throw Failure(error: 'error', message: e.toString());
    }
  }

  ///Retrieve the link to a user's profile photo using their 'uid'
  @override
  Future<String> getUserProfilePhotoUrl(String uid) async {
    try {
      return await _storage
          .ref()
          .child('profile_pictures')
          .child(uid)
          .getDownloadURL();
    } on FirebaseException catch (e) {
      throw Failure(error: e.code, message: e.message);
    } catch (e) {
      throw Failure(error: "error", message: e.toString());
    }
  }
}
