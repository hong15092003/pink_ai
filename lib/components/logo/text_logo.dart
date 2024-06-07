import 'package:flutter/material.dart';

class TextLogo {
  final BuildContext context;
  final String text;
  const TextLogo({required this.text, required this.context});

  Widget textLogo() {
    return Align(
      alignment: Alignment.center,
      child: Text(
        text,
        style: TextStyle(
          fontSize: 80,
          fontWeight: FontWeight.bold,
          color: Theme.of(context).shadowColor,
        ),
      ),
    );
  }
}
