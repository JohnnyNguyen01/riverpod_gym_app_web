import 'package:flutter/material.dart';
import '../presentation/screens/screens.dart';

class CustomRouter {
  static Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case SignUpLoginPage.routeName:
        return SignUpLoginPage.route();
      default:
        return _buildErrorRoute(settings: settings);
    }
  }

  static MaterialPageRoute _buildErrorRoute(
      {@required RouteSettings settings}) {
    return MaterialPageRoute(
        settings: settings,
        builder: (_) => Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.white,
                title: Text('Error'),
              ),
              body: Center(
                child: Text('404 Error'),
              ),
            ));
  }
}