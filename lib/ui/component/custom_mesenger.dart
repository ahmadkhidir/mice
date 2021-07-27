import 'package:flutter/material.dart';

void snackBarMessage(BuildContext context, {required String message}) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
}
