import 'package:flutter/material.dart';
import 'package:pink_ai/main.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Theme'),
            Switch(
              value: themeModeNotifier.value == ThemeMode.dark,
              onChanged: (value) {
                setState(() {});
                themeModeNotifier.value =
                    value ? ThemeMode.dark : ThemeMode.light;
              },
            ),
          ],
        )
      ],
    );
  }
}
