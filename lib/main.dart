import 'package:adonis_web_test/config/custom_router.dart';
import 'package:adonis_web_test/presentation/screens/auth/signup_login_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      onGenerateRoute: CustomRouter.onGenerateRoute,
      initialRoute: SignUpLoginPage.routeName,
    );
  }
}
