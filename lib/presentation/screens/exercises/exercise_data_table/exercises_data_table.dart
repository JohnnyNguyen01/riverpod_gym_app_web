import 'package:adonis_web_test/config/config.dart';
import 'package:adonis_web_test/domain/models/exercise_for_table.dart';
import 'package:adonis_web_test/presentation/screens/exercises/exercise_data_table/exercises_data_table_controller.dart';
import 'package:adonis_web_test/states/exercises/exercise_stream_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ExercisesDataTable extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final exerciseListStream = watch(exerciseListStreamProvider);
    final _pageController = watch(exerciseDataTableControllerProvider);
    return exerciseListStream.when(
      data: (exerciseList) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            elevation: 2,
            child: SingleChildScrollView(
              physics: ClampingScrollPhysics(),
              child: DataTable(
                columns: [
                  DataColumn(label: Text('Exercise', style: kTableHeading)),
                  DataColumn(label: Text('Youtube Link', style: kTableHeading)),
                  DataColumn(label: Text('')),
                  DataColumn(label: Text('')),
                ],
                rows: [
                  for (var exercise in exerciseList)
                    _buildRow(
                        exercise: exercise,
                        context: context,
                        controller: _pageController)
                ],
              ),
            ),
          ),
        );
      },
      loading: () => const Center(
        child: const CircularProgressIndicator(),
      ),
      error: (err, stck) => Center(
        child: Text(
          err.toString(),
        ),
      ),
    );
  }

  DataRow _buildRow(
      {@required ExerciseForDatatable exercise,
      @required BuildContext context,
      @required ExerciseDataTableController controller}) {
    return DataRow(cells: [
      DataCell(SelectableText(exercise.exerciseName)),
      DataCell(SelectableText(exercise.exerciseURL)),
      DataCell(
        IconButton(
          onPressed: () => controller.handleEditExerciseBtn(
              exercise: exercise, context: context),
          icon: Icon(Icons.edit),
        ),
      ),
      DataCell(IconButton(
        icon: Icon(Icons.delete),
        onPressed: () =>
            controller.handleDeleteBtn(exercise: exercise, context: context),
      ))
    ]);
  }
}
