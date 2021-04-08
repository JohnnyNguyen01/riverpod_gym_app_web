import 'package:adonis_web_test/domain/authentication/firebase_auth_repo.dart';
import 'package:adonis_web_test/domain/models/models.dart';
import 'package:adonis_web_test/presentation/screens/screens.dart';
import 'package:adonis_web_test/states/auth/user_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';

final signupLoginScreenController =
    Provider<SignUpLoginScreenController>((ref) {
  return SignUpLoginScreenController(read: ref.read);
});

class SignUpLoginScreenController {
  final Reader read;
  SignUpLoginScreenController({@required this.read});

  void handleLoginButton(
      {@required String email,
      @required String password,
      @required BuildContext context}) async {
    final authProvider = read(firebaseAuthRepoProvider);
    try {
      await authProvider.loginWithEmailAndPassword(
          email: email, password: password);
      await read(userStateProvider.notifier).setCurrentUser();
      Navigator.of(context).pushReplacementNamed(Dashboard.routeName);
    } on Failure catch (e) {
      print('failure form controller: ${e.message}');
      Fluttertoast.showToast(
          msg: e.message,
          backgroundColor: Colors.red,
          toastLength: Toast.LENGTH_LONG,
          webBgColor: '#C23933',
          webPosition: "center");
    }
  }
}

void handleSignUpBtn({@required BuildContext context}) {}
