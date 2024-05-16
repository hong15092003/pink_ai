import 'package:flutter/material.dart';

class TextLogo {
  const TextLogo();

  Widget textLogo() {
    return const Align(
      alignment: Alignment.center,
      child: Text(
        'PIAI',
        style: TextStyle(
          fontSize: 80,
          fontWeight: FontWeight.bold,
          color: Color.fromRGBO(46, 46, 46, 1),
        ),
      ),
    );
  }
}


