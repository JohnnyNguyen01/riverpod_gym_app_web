import 'package:adonis_web_test/presentation/widgets/widgets.dart';
import 'package:adonis_web_test/states/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:table_calendar/table_calendar.dart';

import 'summary_view/summary_view.dart';

class CreateProgramScreen extends ConsumerWidget {
  static const routeName = '/create-program';
  static Route route() => PageRouteBuilder(
      settings: RouteSettings(name: routeName),
      pageBuilder: (_, __, ___) => CreateProgramScreen(),
      transitionDuration: const Duration(seconds: 0));

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    // final _workoutState = watch(workoutProgramStateProvider);
    return Scaffold(
        body: Row(
      children: [NavigationBar(), SummaryView(), _BuildWorkoutBuilderView()],
    ));
  }
}

class _BuildWorkoutBuilderView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 4,
      child: Placeholder(),
    );
  }
}
