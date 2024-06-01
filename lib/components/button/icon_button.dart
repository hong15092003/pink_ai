import 'package:flutter/material.dart';

class ButtonIcon {
  final BuildContext context;
  final IconData icon;
  final VoidCallback onPressed;

  const ButtonIcon({
    required this.context,
    required this.icon,
    required this.onPressed,
  });

  Widget circle() {
    return Container(
      height: 40,
      width: 40,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Theme.of(context).primaryColor,
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).primaryColor,
            blurRadius: 10.0,
            spreadRadius: 0.0,
            // offset: Offset(2.0, 2.0), // shadow direction: bottom right
          )
        ],
      ),
      child: IconButton(
        color: Theme.of(context).indicatorColor,
        icon: Icon(icon, size: 20),
        onPressed: onPressed,
      ),
    );
  }
}
