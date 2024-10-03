import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pink_ai/config.dart';
import 'package:pink_ai/firebase_options.dart';
import 'package:pink_ai/themes/dark_mode.dart';
import 'package:pink_ai/themes/light_mode.dart';
import 'package:pink_ai/views/auth_view.dart';



Future<void> main() async {
  // if (kIsWeb) {
  //     String operatingSystem = kIsWeb ? 'web' : Platform.operatingSystem;
  //   print('Running on the web!');
  // } else {
  //   print('Running on a mobile platform!');
  // }
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    ValueListenableBuilder<Color>(
        valueListenable: primaryColorNotifier,
        builder: (context, snapshot, child) {
          return ValueListenableBuilder<ThemeMode>(
            valueListenable: themeModeNotifier,
            builder: (context, mode, child) {
              mode = mode == ThemeMode.system
                  ? MediaQuery.platformBrightnessOf(context) == Brightness.light
                      ? ThemeMode.dark
                      : ThemeMode.light
                  : mode;
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                theme: lightMode(),
                darkTheme: darkMode(),
                themeMode: mode,
                // initialRoute: '/auth',
                home: AnnotatedRegion<SystemUiOverlayStyle>(
                  value: SystemUiOverlayStyle(
                    statusBarColor:
                        Theme.of(context).brightness == Brightness.dark
                            ? Colors.white
                            : Colors.black, // Change this to the color you want
                  ),
                  child: const AuthGateWay(),
                ),
              );
            },
          );
        }),
  );
}

final ValueNotifier<ThemeMode> themeModeNotifier =
    ValueNotifier(ThemeMode.system);
final ValueNotifier<Color> primaryColorNotifier =
    ValueNotifier(config.primaryColor);
