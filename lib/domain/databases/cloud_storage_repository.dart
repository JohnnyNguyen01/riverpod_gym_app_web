import 'dart:io';

abstract class CloudStorageRepository {
  Future<String> getUserProfilePhotoUrl(String uid);
  Future<void> addNewUserProfilephoto(File imageFile, String uid);
}
