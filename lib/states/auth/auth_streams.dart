import 'package:adonis_web_test/domain/authentication/firebase_auth_repo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authStreamProvider = StreamProvider.autoDispose<User>((ref) async* {
  final authStateStream =
      ref.watch(firebaseAuthRepoProvider).authStateChanges();

  await for (final user in authStateStream) {
    yield user;
  }
});
