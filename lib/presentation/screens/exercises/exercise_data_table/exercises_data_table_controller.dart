import 'package:adonis_web_test/domain/databases/databases.dart';
import 'package:adonis_web_test/domain/domain.dart';
import 'package:adonis_web_test/presentation/widgets/dialogs/confirm_dialog.dart';
import 'package:adonis_web_test/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meta/meta.dart';

final exerciseDataTableControllerProvider =
    Provider<ExerciseDataTableController>((ref) {
  final databaseRepo = ref.read(databaseProvider);

  return ExerciseDataTableController(
      read: ref.read, databaseRepository: databaseRepo);
});

class ExerciseDataTableController {
  final Reader read;
  final NoSqlDatabaseRepository databaseRepository;

  ExerciseDataTableController(
      {@required this.read, @required this.databaseRepository});

  void handleDeleteBtn(
      {@required ExerciseForDatatable exercise,
      @required BuildContext context}) {
    try {
      //show dialog box asking if they really want to delete
      showDialog(
          context: context,
          builder: (_) => ConfirmDialog(
              title: "Delete ${exercise.exerciseName}",
              subtitle: "Are you sure you want to delete this exercise?",
              onConfirm: () {
                //todo: Add delete method, not implementing yet due to testing
                try {
                  databaseRepository.deleteExercise(exercise: exercise);
                  Navigator.of(context).pop();
                } on Failure catch (e) {
                  ErrorToast(message: e.message).showToast();
                }
              },
              onCancel: () {}));
      //Delete exercise or return
    } on Failure catch (e) {
      ErrorToast(message: e.message).showToast();
    }
  }
}
