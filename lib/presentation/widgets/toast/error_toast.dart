import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ErrorToast {
  final String message;
  ErrorToast({@required this.message});

  void showToast() => Fluttertoast.showToast(
      msg: message,
      backgroundColor: Colors.red,
      toastLength: Toast.LENGTH_LONG,
      webBgColor: '#C23933',
      webPosition: "center");
}
