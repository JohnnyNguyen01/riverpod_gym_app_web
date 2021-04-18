import 'package:adonis_web_test/presentation/screens/library/screens.dart';
import 'package:adonis_web_test/states/workout_program/workout_program_state.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final createProgramDialogControllerProvider =
    Provider<CreateProgramDialogController>((ref) {
  return CreateProgramDialogController(read: ref.read);
});

class CreateProgramDialogController {
  final Reader read;

  CreateProgramDialogController({@required this.read});

  void handleSubmit(
      {@required GlobalKey<FormState> formKey,
      @required TextEditingController programNameController,
      @required TextEditingController numOfWeeksController,
      @required TextEditingController numOfSessionsController,
      @required BuildContext context}) {
    final workoutProgramStateNotifier =
        read(workoutProgramStateProvider.notifier);
    if (formKey.currentState.validate()) {
      workoutProgramStateNotifier.addInitialCreationDetails(
          programName: programNameController.text,
          numOfWeeks: int.parse(numOfWeeksController.text),
          numOfSessions: int.parse(numOfSessionsController.text));
      //navigate to next screen
      Navigator.of(context).pushNamed(CreateProgramScreen.routeName);
    }
  }
}
