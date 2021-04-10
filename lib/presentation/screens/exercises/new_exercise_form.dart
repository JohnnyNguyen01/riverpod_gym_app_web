import 'package:adonis_web_test/config/config.dart';
import 'package:flutter/material.dart';

class NewExerciseForm extends StatefulWidget {
  @override
  _NewExerciseFormState createState() => _NewExerciseFormState();
}

class _NewExerciseFormState extends State<NewExerciseForm> {
  final _exerciseNameController = TextEditingController();
  final _exerciseURLController = TextEditingController();
  // final _youtubeController = YoutubeController();
  @override
  Widget build(BuildContext context) {
    // final deviceWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, top: 8.0),
      child: Container(
        width: 400,
        child: Form(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Add New Exercise,',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 28,
                ),
              ),
              const SizedBox(height: 10),
              _buildExerciseNameTF(),
              const SizedBox(height: 10),
              _buildExerciseURLTF(),
            ],
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

  @override
  void dispose() {
    super.dispose();
    _exerciseNameController.dispose();
    _exerciseURLController.dispose();
  }
}
