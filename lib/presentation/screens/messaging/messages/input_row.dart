import 'package:adonis_web_test/presentation/screens/messaging/messaging_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BuildInputRow extends StatefulWidget {
  const BuildInputRow({
    @required this.watch,
  });

  final ScopedReader watch;

  @override
  _BuildInputRowState createState() => _BuildInputRowState();
}

class _BuildInputRowState extends State<BuildInputRow> {
  bool _buttonIsEnabled = false;
  final _inputController = TextEditingController();

  void setButtonIsEnabled() {
    _inputController.text.isNotEmpty
        ? _buttonIsEnabled = true
        : _buttonIsEnabled = false;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 1,
          width: double.infinity,
          color: Colors.white,
          child: Material(
            elevation: 1,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _inputController,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Enter your message here"),
                  onChanged: (_) {
                    setState(() {
                      setButtonIsEnabled();
                    });
                  },
                ),
              ),
              const SizedBox(width: 8),
              IconButton(
                onPressed: _buttonIsEnabled
                    ? () async {
                        widget
                            .watch(messagingScreenControllerProvider)
                            .handleSendNewMsgBtn(
                                inputController: _inputController);
                      }
                    : () {},
                icon: Icon(
                  Icons.send,
                  color: _buttonIsEnabled ? Colors.red : Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();
    _inputController.dispose();
  }
}
