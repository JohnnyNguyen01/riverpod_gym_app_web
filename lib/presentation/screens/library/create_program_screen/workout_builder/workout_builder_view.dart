import 'package:adonis_web_test/states/workout_program/selected_week_session_state.dart';
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
            : Text(weekSessionState.toString()));
  }
}
