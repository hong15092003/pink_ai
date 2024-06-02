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
        Container(
          margin: const EdgeInsets.only(top: 20, left: 10, right: 10),
          padding:
              const EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 20),
          // foregroundDecoration: ,
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).shadowColor,
                blurRadius: 5.0,
                spreadRadius: 1.0,
                offset: const Offset(1, 1),
              )
            ],
          ),

          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Chủ đề tối',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              Switch(
                activeColor: Theme.of(context).primaryColor,
                inactiveTrackColor: Theme.of(context).primaryColor,
                inactiveThumbColor: Theme.of(context).scaffoldBackgroundColor,
                trackOutlineColor:
                    WidgetStatePropertyAll(Theme.of(context).primaryColor),
                value: themeModeNotifier.value == ThemeMode.dark,
                onChanged: (value) {
                  setState(() {});
                  themeModeNotifier.value =
                      value ? ThemeMode.dark : ThemeMode.light;
                },
              ),
            ],
          ),
        )
      ],
    );
  }
}
