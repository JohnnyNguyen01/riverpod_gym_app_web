import 'package:adonis_web_test/domain/domain.dart';
import 'package:adonis_web_test/domain/models/models.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meta/meta.dart';

final userStateProvider = StateNotifierProvider<UserState, Coach>(
  (ref) => UserState(
      read: ref.read,
      authRepo: ref.read(firebaseAuthRepoProvider),
      storageRepo: ref.read(storageCloudService)),
);

class UserState extends StateNotifier<Coach> {
  final Reader read;
  final AuthRepository authRepo;
  final CloudStorageRepository storageRepo;

  UserState(
      {@required this.read,
      @required this.authRepo,
      @required this.storageRepo})
      : super(Coach.initState());

  /// Sets the state to the user gained from auth Repository and Cloud Storage
  /// Repository
  Future<void> setCurrentUser() async {
    // final userFromAuthRepo = Coach.fromAuthAndStorageProviders(authRepo);
    // final profileImageURL =
    //     await storageRepo.getUserProfilePhotoUrl(userFromAuthRepo.uid);
    final user = await read(databaseProvider).getCoach(coachUid: authRepo.uid);
    // final newState = userFromAuthRepo.copyWith(imageURL: profileImageURL);
    state = user;
  }
}
