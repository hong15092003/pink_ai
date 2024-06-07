import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:pink_ai/firebase_options.dart';
import 'package:pink_ai/themes/dark_mode.dart';
import 'package:pink_ai/themes/light_mode.dart';

import 'package:pink_ai/views/home_view.dart';
import 'package:pink_ai/views/login_view.dart';

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
            ? MediaQuery.platformBrightnessOf(context) == Brightness.light
                ? ThemeMode.dark
                : ThemeMode.light
            : mode;
        return MaterialApp(
          routes: {
            '/start': (context) => const StartView(),
            '/home': (context) => const HomeView(),
            '/login': (context) => const LoginView(),
          },
          debugShowCheckedModeBanner: false,
          theme: lightMode(),
          darkTheme: darkMode(),
          themeMode: mode,
          // initialRoute: '/auth',
          home: AnnotatedRegion<SystemUiOverlayStyle>(
            value: SystemUiOverlayStyle(
              statusBarColor: Theme.of(context).brightness == Brightness.dark
                  ? Colors.white
                  : Colors.black, // Change this to the color you want
            ),
            child: const AuthGateWay(),
          ),
        );
      },
    ),
  );
}

class AuthGateWay extends StatefulWidget {
  const AuthGateWay({super.key});

  @override
  State<AuthGateWay> createState() => _AuthGateWayState();
}

class _AuthGateWayState extends State<AuthGateWay> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return const HomeView();
        } else {
          return const LoginView();
        }
      },
    );
  }
}

final ValueNotifier<ThemeMode> themeModeNotifier =
    ValueNotifier(ThemeMode.system);
