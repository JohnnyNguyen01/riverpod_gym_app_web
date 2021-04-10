import 'package:adonis_web_test/presentation/screens/exercises/new_exercise_form.dart';
import 'package:adonis_web_test/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';

class ExercisesScreen extends StatelessWidget {
  static const routeName = '/exercises-screen';

  // static Route route() => MaterialPageRoute(
  //     settings: const RouteSettings(name: routeName),
  //     builder: (_) => ExercisesScreen());

  static Route route() => PageRouteBuilder(
        settings: const RouteSettings(name: routeName),
        pageBuilder: (context, animation1, animation2) => ExercisesScreen(),
        transitionDuration: const Duration(seconds: 0),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        // mainAxisSize: MainAxisSize.max,
        children: [
          NavigationBar(),
          NewExerciseForm(),
        ],
      ),
    );
  }
}
