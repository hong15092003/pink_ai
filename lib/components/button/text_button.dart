import 'package:flutter/material.dart';

class ButtonText {
  final BuildContext context;
  final String text;
  final VoidCallback onPressed;

  const ButtonText({
    required this.context,
    required this.text,
    required this.onPressed,
  });

  Widget circle() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      height: 35,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        shape: BoxShape.rectangle,
        color: Theme.of(context).primaryColor,
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).primaryColor,
            blurRadius: 5.0,
            spreadRadius: 0.0,
            // offset: Offset(2.0, 2.0), // shadow direction: bottom right
          )
        ],
      ),
      child: TextButton(
        onPressed: onPressed,
        child: Text(
          text,
          style: Theme.of(context).textTheme.headlineLarge,
        ),
      ),
    );
  }
   Widget rectangle() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      height: 35,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        shape: BoxShape.rectangle,
        color: Theme.of(context).primaryColor,
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).primaryColor,
            blurRadius: 5.0,
            spreadRadius: 0.0,
            // offset: Offset(2.0, 2.0), // shadow direction: bottom right
          )
        ],
      ),
      child: TextButton(
        onPressed: onPressed,
        child: Text(
          text,
          style: Theme.of(context).textTheme.headlineLarge,
        ),
      ),
    );
  }

  Widget noBorder() {
    return TextButton(
      onPressed: onPressed,
      child: Text(
        text,
        style: Theme.of(context).textTheme.headlineLarge!.copyWith(
              color: Theme.of(context).primaryColor,
        )
      ),
    );
  }
}
