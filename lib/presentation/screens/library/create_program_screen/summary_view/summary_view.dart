import 'package:adonis_web_test/config/config.dart';
import 'package:adonis_web_test/presentation/screens/library/create_program_screen/summary_view/week_row.dart';
import 'package:adonis_web_test/states/workout_program/workout_program_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SummaryView extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    return Expanded(
      flex: 1,
      child: Material(
        elevation: 2,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          // mainAxisSize: MainAxisSize.min,
          children: [
            _buildWeekColumn(context, watch),
          ],
        ),
      ),
    );
  }

  Widget _buildWeekColumn(BuildContext context, ScopedReader watch) {
    return LayoutBuilder(builder: (context, dimensions) {
      return dimensions.maxWidth > 252
          ? Container(
              width: dimensions.maxWidth,
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildWeekCard(watch),
                ],
              ),
            )
          : Container();
    });
  }

  Card _buildWeekCard(ScopedReader watch) {
    final state = watch(workoutProgramStateProvider);
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(state.programName, style: kPageHeading),
            for (int i = 1; i <= state.numberOfWeeks; i++)
              WeekRow(
                sessions: state.sessionsPerWeek,
                weekNumber: i,
              ),
          ],
        ),
      ),
    );
  }
}
