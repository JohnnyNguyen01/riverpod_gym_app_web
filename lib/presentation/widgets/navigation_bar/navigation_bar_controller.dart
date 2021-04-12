import 'package:adonis_web_test/presentation/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final navigatioBarControllerProvider =
    StateNotifierProvider<NavigationBarController, int>((ref) {
  return NavigationBarController(ref.read);
});

class NavigationBarController extends StateNotifier<int> {
  final Reader read;
  NavigationBarController(this.read) : super(0);

  void handleChange({@required int index, @required BuildContext context}) {
    switch (index) {
      case 0:
        state = index;
        Navigator.of(context).pushNamed(Dashboard.routeName);
        break;
      case 1:
        state = index;
        Navigator.of(context).pushNamed(ExercisesScreen.routeName);
        break;
      case 2:
        state = index;
        Navigator.of(context).pushNamed(MessagingScreen.routeName);
    }
  }
}
