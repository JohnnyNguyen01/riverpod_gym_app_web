import 'package:adonis_web_test/domain/databases/databases.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

///The stream of all the clients within the database under the `users`
///collection.
final usersStreamProvider = StreamProvider.autoDispose((ref) async* {
  final usersStream = ref.read(databaseProvider).getUsersAsStream();
  await for (var userList in usersStream) {
    yield userList;
  }
});
