import 'package:adonis_web_test/presentation/screens/auth/signup_login_page.dart';
import 'package:adonis_web_test/presentation/screens/dashboard/dashboard.dart';
import 'package:adonis_web_test/states/auth/auth_streams.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthWrapper extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final authStateStream = watch(authStreamProvider);
    return authStateStream.when(
        data: (user) {
          return user == null ? SignUpLoginPage() : Dashboard();
        },
        loading: () => const Center(
              child: const CircularProgressIndicator(),
            ),
        error: (err, stc) {
          print(err);
          return const Center(
            child: const Text('Error'),
          );
        });
  }
}
