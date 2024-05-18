import 'package:flutter/material.dart';
import 'package:pink_ai/components/color/color_component.dart';

class ButtonIcon {
  final IconData icon;
  final VoidCallback onPressed;

  const ButtonIcon({
    required this.icon,
    required this.onPressed,
  });

  Widget circle() {
    return Container(
      height: 40,
      width: 40,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: ColorStyle.primary,
        boxShadow: [
          BoxShadow(
            color: ColorStyle.primary,
            blurRadius: 10.0,
            spreadRadius: 0.0,
            // offset: Offset(2.0, 2.0), // shadow direction: bottom right
          )
        ],
      ),
      child: IconButton(
        color: ColorStyle.text,
        icon: Icon(icon, size: 20),
        onPressed: onPressed,
      ),
    );
  }
}