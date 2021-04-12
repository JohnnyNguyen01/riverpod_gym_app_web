import 'package:adonis_web_test/config/config.dart';
import 'package:adonis_web_test/domain/databases/databases.dart';
import 'package:adonis_web_test/domain/domain.dart';
import 'package:adonis_web_test/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NewExerciseForm extends StatefulWidget {
  @override
  _NewExerciseFormState createState() => _NewExerciseFormState();
}

class _NewExerciseFormState extends State<NewExerciseForm> {
  final _exerciseNameController = TextEditingController();
  final _exerciseURLController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  // final _youtubeController = YoutubeController();
  @override
  Widget build(BuildContext context) {
    // final deviceWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, top: 8.0),
      child: Container(
        width: 400,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Card(
          elevation: 3,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Add New Exercise 🏋️‍♂️',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 28,
                    ),
                  ),
                  const SizedBox(height: 10),
                  _buildExerciseNameTF(),
                  const SizedBox(height: 10),
                  _buildExerciseURLTF(),
                  const SizedBox(height: 10),
                  _buildSubmitButton(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  TextFormField _buildExerciseNameTF() {
    return TextFormField(
      controller: _exerciseNameController,
      decoration: InputDecoration(
        labelText: 'Exercise Name',
        hintText: 'name',
      ),
      validator: StringValidators.isNotNullorEmpty,
    );
  }

  TextFormField _buildExerciseURLTF() {
    return TextFormField(
      controller: _exerciseURLController,
      validator: StringValidators.isValidYoutubeURL,
      decoration: InputDecoration(
        labelText: 'Exercise URL',
        hintText: 'youtube link',
      ),
    );
  }

  Widget _buildSubmitButton() {
    return Consumer(
      builder: (context, watch, child) {
        final databaseRepo = watch(databaseProvider);
        return Container(
          height: 35,
          child: ElevatedButton(
            child: const Text('Add Exercise'),
            onPressed: () {
              if (_formKey.currentState.validate()) {
                try {
                  final exercise = ExerciseForDatatable(
                      exerciseName: _exerciseNameController.text,
                      exerciseURL: _exerciseURLController.text,
                      documentID: '');
                  databaseRepo.addNewExercise(exercise: exercise);
                } on Failure catch (e) {
                  ErrorToast(message: e.message).showToast();
                }
              }
            },
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    _exerciseNameController.dispose();
    _exerciseURLController.dispose();
  }
}
