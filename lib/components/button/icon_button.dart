import 'package:flutter/material.dart';
import 'package:pink_ai/controllers/firebase_controller.dart';
import 'package:pink_ai/main.dart';

class ButtonIcon {
  final Key? key;
  final BuildContext context;
  final IconData icon;
  final VoidCallback onPressed;

  const ButtonIcon({
    this.key,
    required this.context,
    required this.icon,
    required this.onPressed,
  });

  Widget circleBorder() {
    return Container(
      key: key,
      clipBehavior: Clip.hardEdge,
      height: 30,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
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
      child: IconButton(
        style: ButtonStyle(
          shadowColor: WidgetStatePropertyAll(
            Theme.of(context).indicatorColor,
          ),
          backgroundColor: WidgetStatePropertyAll(
            Theme.of(context).primaryColor,
          ),
        ),
        color: Theme.of(context).indicatorColor,
        icon: Icon(icon, size: 15),
        onPressed: onPressed,
      ),
    );
  }

  Widget noBorder() {
    return IconButton(
      iconSize: 20,
      color: Theme.of(context).primaryColor,
      icon: Icon(icon),
      onPressed: onPressed,
    );
  }
}

class ThemeChange {
  final BuildContext context;

  ThemeChange({required this.context});
  Widget button() {
    return ButtonIcon(
      context: context,
      icon: themeModeNotifier.value == ThemeMode.dark
          ? Icons.brightness_2
          : Icons.wb_sunny_outlined,
      onPressed: () {
        if (themeModeNotifier.value == ThemeMode.dark) {
          themeModeNotifier.value = ThemeMode.light;
        } else {
          themeModeNotifier.value = ThemeMode.dark;
        }
        // if (authFirebase.checkAuth()) {
        firebaseController.saveTheme(
          themeModeNotifier.value.toString(),
        );
        // }
      },
    ).noBorder();
  }
}
