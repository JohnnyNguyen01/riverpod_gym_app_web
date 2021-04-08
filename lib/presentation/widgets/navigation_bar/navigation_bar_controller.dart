import 'package:adonis_web_test/presentation/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final navigatioBarControllerProvider = Provider<NavigationBarController>((ref) {
  return NavigationBarController(ref.read);
});

class NavigationBarController {
  final Reader read;

  NavigationBarController(this.read);

  void handleChange({@required int index, @required BuildContext context}) {
    switch (index) {
      case 0:
        Navigator.of(context).pushNamed(Dashboard.routeName);
        break;
      case 1:
        print('exercises screen selected');
        break;
      case 2:
        Navigator.of(context).pushNamed(MessagingScreen.routeName);
    }
  }
}
