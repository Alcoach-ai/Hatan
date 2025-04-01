
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

Future<bool?> showToast({
  required String text,
  required Color color
}) {
  return Fluttertoast.showToast(
    msg: text,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,

    timeInSecForIosWeb: 1,
    backgroundColor: color,
    textColor: Colors.white,

    fontSize: 15.0,
  );
}
