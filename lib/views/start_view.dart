import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pink_ai/components/logo/text_logo.dart';
import 'package:pink_ai/config.dart';
import 'package:pink_ai/main.dart';
import 'package:pink_ai/models/api_config_model.dart';

import 'home_view.dart';

class StartView extends StatefulWidget {
  const StartView({super.key});

  @override
  StartViewState createState() => StartViewState();
}

class StartViewState extends State<StartView> {
  final docRef = FirebaseFirestore.instance.collection('gemini').doc('api');
  final _firebaseUser = FirebaseFirestore.instance
      .collection('User')
      .doc(FirebaseAuth.instance.currentUser!.uid);

  ThemeMode checkTheme(String theme) {
    if (theme == 'ThemeMode.dark') {
      return ThemeMode.dark;
    } else if (theme == 'ThemeMode.light') {
      return ThemeMode.light;
    } else {
      return ThemeMode.system;
    }
  }

  Future<void> getProfile() async {
    try {
      final snapshot = await _firebaseUser.get();
      final data = snapshot.data();
      if (data == null) {
        throw Exception('Data is null');
      }
      config.updateProfile(
          data['userId'], data['fistName'], data['lastName'], data['email']);
      primaryColorNotifier.value = config.hexToColor(data['primaryColor']);
      themeModeNotifier.value = checkTheme(data['theme']);
      config.updatePath(data['userId']);
    } catch (e) {
      return;
    }
  }

  Future<void> getAPI() async {
    try {
      final snapshot = await docRef.get();
      await getProfile();
      final data = snapshot.data();
      if (data == null) {
        // throw Exception('Data is null');
      }

      if (mounted) {
        ApiConfigModel apiConfigModel = ApiConfigModel.fromMap(data!);
        config.updateConfig(apiConfigModel);
        Navigator.of(context).pushReplacement(_createRoute());
      }
    } catch (e) {
      return;
    }
  }

  Route _createRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => const HomeView(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = const Offset(1.0, 0.0);
        var end = Offset.zero;
        var curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: FutureBuilder(
        future: getAPI(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
                child: TextLogo(context: context, text: 'Hello').textLogo());
          } else {
            return const SizedBox(); // Empty container as we are navigating to HomeView after API call
          }
        },
      ),
    );
  }
}
