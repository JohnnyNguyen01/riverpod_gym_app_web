import 'package:adonis_web_test/config/config.dart';
import 'package:adonis_web_test/config/style_constants.dart';
import 'package:adonis_web_test/presentation/screens/library/create_program_dialog/create_program_dialog_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CreateProgramDialog extends StatefulWidget {
  @override
  _CreateProgramDialogState createState() => _CreateProgramDialogState();
}

class _CreateProgramDialogState extends State<CreateProgramDialog> {
  final _programNameController = TextEditingController();
  final _numberOfWeeksController = TextEditingController();
  final _numberOfSessionsPerWeekController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _accessCode = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final double _textFieldWidth = 420;
    return Consumer(builder: (context, watch, child) {
      final _pageController = watch(createProgramDialogControllerProvider);

      return AlertDialog(
        title: Text('Create Program', style: kPageHeading),
        content: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: _textFieldWidth,
                child: TextFormField(
                  controller: _programNameController,
                  decoration: InputDecoration(
                      labelText: "Program Name",
                      hintText: "Ex: Advanced Olympic Lifting"),
                  validator: StringValidators.isNotNullorEmpty,
                ),
              ),
              const SizedBox(height: 15),
              Container(
                width: _textFieldWidth,
                child: TextFormField(
                  controller: _numberOfWeeksController,
                  decoration: InputDecoration(
                      labelText: "Number of Weeks in Program",
                      hintText: "Ex: 4"),
                  validator: StringValidators.isNotNullorEmpty,
                ),
              ),
              const SizedBox(height: 15),
              Container(
                width: _textFieldWidth,
                child: TextFormField(
                  controller: _numberOfSessionsPerWeekController,
                  decoration: InputDecoration(
                      labelText: "Number of Sessions per week",
                      hintText: "Ex: 4"),
                  validator: StringValidators.isNotNullorEmpty,
                ),
              ),
              const SizedBox(height: 15),
              Container(
                width: _textFieldWidth,
                child: TextFormField(
                  controller: _accessCode,
                  decoration: InputDecoration(
                      labelText: "Access Code",
                      hintText: "Ex: LiftHeavyThings"),
                  validator: StringValidators.isNotNullorEmpty,
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text('• Access codes allow atheletes to join a program'),
                  Text('• Choose something that\'s easy to remember'),
                  Text('• Make it related to your program'),
                ],
              ),
              const SizedBox(height: 15),
            ],
          ),
        ),
        actions: [
          TextButton(
            child: Text('Cancel'),
            onPressed: () {},
          ),
          const SizedBox(width: 10),
          Container(
            height: 35,
            child: ElevatedButton(
              child: Text('Create Program'),
              onPressed: () => _pageController.handleSubmit(
                  formKey: _formKey,
                  programNameController: _programNameController,
                  numOfWeeksController: _numberOfWeeksController,
                  numOfSessionsController: _numberOfSessionsPerWeekController,
                  context: context),
            ),
          )
        ],
      );
    });
  }

  @override
  void dispose() {
    super.dispose();
    _programNameController.dispose();
    _numberOfSessionsPerWeekController.dispose();
    _numberOfWeeksController.dispose();
    _accessCode.dispose();
  }
}
