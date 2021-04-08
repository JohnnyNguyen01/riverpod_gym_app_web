import 'package:adonis_web_test/domain/domain.dart';
import 'package:adonis_web_test/domain/models/models.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meta/meta.dart';

final userStateProvider = Provider<UserState>((ref) {
  final cloudStorageProvider = ref.read(storageCloudService);
  final authRepoProvider = ref.read(firebaseAuthRepoProvider);
  return UserState(
      read: ref.read,
      authRepo: authRepoProvider,
      storageRepo: cloudStorageProvider);
});

class UserState extends StateNotifier<AsyncValue<UserModel>> {
  final Reader read;
  final AuthRepository authRepo;
  final CloudStorageRepository storageRepo;

  UserState(
      {@required this.read,
      @required this.authRepo,
      @required this.storageRepo})
      : super(AsyncData(UserModel.initValue()));

  /// Sets the state to the user gained from auth Repository and Cloud Storage
  /// Repository
  void setCurrentUser() async {
    final userFromAuthRepo = UserModel.fromAuthAndStorageProviders(authRepo);
    final profileImageURL =
        await storageRepo.getUserProfilePhotoUrl(userFromAuthRepo.uid);
    final newState =
        userFromAuthRepo.copyWith(profileImageURL: profileImageURL);
    state = AsyncData(newState);
  }
}
