import 'package:adonis_web_test/config/config.dart';
import 'package:adonis_web_test/config/custom_router.dart';
import 'package:adonis_web_test/presentation/screens/screens.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: Themes.primaryTheme,
      onGenerateRoute: CustomRouter.onGenerateRoute,
      initialRoute: SignUpLoginPage.routeName,
    );
  }
}
