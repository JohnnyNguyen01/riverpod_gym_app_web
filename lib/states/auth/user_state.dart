import 'package:adonis_web_test/domain/authentication/auth_repository.dart';
import 'package:adonis_web_test/domain/authentication/firebase_auth_repo.dart';
import 'package:adonis_web_test/domain/models/models.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meta/meta.dart';

final userStateProvider = Provider<UserState>((ref) {
  return UserState(
      read: ref.read, authRepo: ref.read(firebaseAuthRepoProvider));
});

class UserState extends StateNotifier<AsyncValue<UserModel>> {
  final Reader read;
  final AuthRepository authRepo;

  UserState({@required this.read, @required this.authRepo})
      : super(AsyncData(UserModel.initValue()));

  /// Sets the state to the user gained from auth Repository and database
  /// Repository
  void setCurrentUser() {
    final userFromAuthRepo = UserModel.fromAuthAndStorageProviders(authRepo);
    //todo: set user profile image from database repo
  }
}
