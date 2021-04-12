import 'package:flutter/material.dart';

class ConfirmDialog extends StatelessWidget {
  final String title;
  final String subtitle;
  final Function onConfirm;
  final Function onCancel;

  const ConfirmDialog(
      {this.title,
      this.subtitle,
      @required this.onConfirm,
      @required this.onCancel});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        title,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
      content: Text(subtitle),
      actions: [
        _buildConfirmButton(),
        _buildCancelButton(context: context),
      ],
    );
    // Dialog(
    //   elevation: 3,
    //   child: Padding(
    //     padding: const EdgeInsets.all(12.0),
    //     child: Column(
    //       children: [
    //         Text(
    //           title,
    //           style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    //         ),
    //         const SizedBox(height: 10),
    //         Text(subtitle, style: const TextStyle(fontSize: 14)),
    //         const SizedBox(height: 10),
    //         Row(
    //           mainAxisAlignment: MainAxisAlignment.center,
    //           children: [
    //             _buildConfirmButton(),
    //             const SizedBox(width: 10),
    //             _buildCancelButton()
    //           ],
    //         )
    //       ],
    //     ),
    //   ),
    // );
  }

  Widget _buildConfirmButton() {
    return ElevatedButton(
        onPressed: onConfirm,
        child: Text(
          'Confirm',
          textAlign: TextAlign.end,
        ),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith<Color>(
              (states) => Colors.green),
        ));
  }

  Widget _buildCancelButton({@required BuildContext context}) {
    return ElevatedButton(
        onPressed: () {
          onCancel();
          Navigator.of(context).pop();
        },
        child: Text(
          "Cancel",
          textAlign: TextAlign.end,
        ));
  }
}
