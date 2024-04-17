import 'package:flutter/material.dart';

void showError(BuildContext context, String error) {
  final snackbar = SnackBar(
    backgroundColor: Colors.red,
    content: Text(error, style: const TextStyle(color: Colors.white)),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackbar);
}

final buttonStyle = ButtonStyle(
  foregroundColor: MaterialStateProperty.all(Colors.black),
  elevation: MaterialStateProperty.all(0),
  shape: MaterialStateProperty.all(
    const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.zero),
    ),
  ),
);
