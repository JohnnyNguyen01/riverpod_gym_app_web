import 'package:flutter/material.dart';
import '../presentation/screens/screens.dart';

class CustomRouter {
  static Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case SignUpLoginPage.routeName:
        return SignUpLoginPage.route();
    }
  }
}
