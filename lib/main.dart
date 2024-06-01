import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:pink_ai/firebase_options.dart';
import 'package:pink_ai/themes/dark_mode.dart';
import 'package:pink_ai/themes/light_mode.dart';

import 'package:pink_ai/views/start_view.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    ValueListenableBuilder<ThemeMode>(
      valueListenable: themeModeNotifier,
      builder: (context, mode, child) {
        mode = mode == ThemeMode.system
            ? MediaQuery.platformBrightnessOf(context) == Brightness.dark
                ? ThemeMode.dark
                : ThemeMode.light
            : mode;
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: lightMode(),
          darkTheme: darkMode(),
          themeMode: mode,
          home: const StartView(),
        );
      },
    ),
  );
}

final ValueNotifier<ThemeMode> themeModeNotifier =
    ValueNotifier(ThemeMode.light);
