import 'package:adonis_web_test/presentation/widgets/navigation_bar/navigation_bar.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatelessWidget {
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
