import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  const Button({
    super.key,
    required this.label,
    this.onPressed,
    this.isBusy = false,
  });

  final String label;
  final VoidCallback? onPressed;
  final bool isBusy;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isBusy ? null : onPressed,
      child: isBusy ? CircularProgressIndicator.adaptive() : Text(label),
    );
  }
}
