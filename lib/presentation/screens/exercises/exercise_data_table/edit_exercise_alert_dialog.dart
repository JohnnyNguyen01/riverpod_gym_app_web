import 'package:adonis_web_test/config/config.dart';
import 'package:adonis_web_test/domain/domain.dart';
import 'package:adonis_web_test/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EditExerciseAlertDialog extends StatefulWidget {
  final ExerciseForDatatable exercise;

  EditExerciseAlertDialog({@required this.exercise});

  @override
  _EditExerciseAlertDialogState createState() =>
      _EditExerciseAlertDialogState();
}

class _EditExerciseAlertDialogState extends State<EditExerciseAlertDialog> {
  final _exerciseNameController = TextEditingController();
  final _exerciseURLController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    //set initial 'state' of textFromFields
    _exerciseNameController.text = widget.exercise.exerciseName;
    _exerciseURLController.text = widget.exercise.exerciseURL;

    return Consumer(builder: (context, watch, child) {
      return AlertDialog(
        title: Text(
          "Edit ${widget.exercise.exerciseName}",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        content: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _exerciseNameController,
                decoration: InputDecoration(labelText: "Name"),
                validator: StringValidators.isNotNullorEmpty,
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _exerciseURLController,
                decoration: InputDecoration(labelText: "Youtube Link"),
                validator: StringValidators.isValidYoutubeURL,
              ),
            ],
          ),
        ),
        actions: [
          ElevatedButton(
            child: Text('Update'),
            onPressed: () {
              if (_formKey.currentState.validate()) {
                final newExercise = widget.exercise.copyWith(
                    exerciseName: _exerciseNameController.text,
                    exerciseURL: _exerciseURLController.text);
                try {
                  watch(databaseProvider).editExercise(exercise: newExercise);
                  Navigator.of(context).pop();
                } on Failure catch (e) {
                  ErrorToast(message: e.message).showToast();
                }
              }
            },
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.resolveWith<Color>(
                    (states) => Colors.green)),
          ),
          ElevatedButton(
            child: Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          )
        ],
      );
    });
  }

  @override
  void dispose() {
    super.dispose();
    _exerciseNameController.dispose();
    _exerciseURLController.dispose();
  }
}
