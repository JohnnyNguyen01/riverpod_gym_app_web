import 'package:adonis_web_test/config/config.dart';
import 'package:adonis_web_test/domain/models/models.dart';
import 'package:adonis_web_test/states/workout_program/selected_week_session_state.dart';
import 'package:adonis_web_test/states/workout_program/workout_program_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WorkoutBuilderView extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final weekSessionState = watch(selectedWeekSessionStateProivder);
    return Expanded(
      flex: 4,
      child: weekSessionState == SelectedWeekSessionModel.init()
          ? Container()
          : WorkoutBuilder(),
    );
  }
}

class WorkoutBuilder extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final workoutProgramState = watch(workoutProgramStateProvider);
    final weekSessionState = watch(selectedWeekSessionStateProivder);
    return Column(
      children: [
        Text(
            '${workoutProgramState.programName}: Week ${weekSessionState.week} Day ${weekSessionState.sessionNumber}',
            style: kPageHeading)
      ],
    );
  }
}
