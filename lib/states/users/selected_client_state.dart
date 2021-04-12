import 'package:adonis_web_test/domain/databases/databases.dart';
import 'package:adonis_web_test/domain/models/models.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meta/meta.dart';

final selectedClientStateProvider =
    StateNotifierProvider<SelectedClientState, UserModel>((ref) {
  final databaseRepo = ref.read(databaseProvider);
  final cloudStorageRepo = ref.read(storageCloudService);

  return SelectedClientState(
      read: ref.read,
      databaseRepo: databaseRepo,
      cloudStorageRepo: cloudStorageRepo);
});

class SelectedClientState extends StateNotifier<UserModel> {
  final Reader read;
  final NoSqlDatabaseRepository databaseRepo;
  final CloudStorageRepository cloudStorageRepo;

  SelectedClientState(
      {@required this.read,
      @required this.databaseRepo,
      @required this.cloudStorageRepo})
      : super(UserModel.initValue());

  void setUser({@required UserModel newUser}) {
    state = newUser;
  }
}
