import 'package:adonis_web_test/presentation/widgets/navigation_bar/navigation_bar.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatelessWidget {
  static const routeName = "/dash";

  static Route route() => MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (_) => Dashboard());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Row(
      children: [
        NavigationBar(),
      ],
    ));
  }
}
