import 'package:flutter/material.dart';

class TextLogo {
  final BuildContext context;
  const TextLogo({Key? key, required this.context});

  Widget textLogo() {
    return Align(
      alignment: Alignment.center,
      child: Text(
        'PIAI',
        style: TextStyle(
          fontSize: 80,
          fontWeight: FontWeight.bold,
          color: Theme.of(context).shadowColor,
        ),
      ),
    );
  }
}
