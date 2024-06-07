import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pink_ai/components/logo/text_logo.dart';
import 'package:pink_ai/config.dart';

import 'home_view.dart';

class StartView extends StatefulWidget {
  const StartView({super.key});

  @override
  StartViewState createState() => StartViewState();
}

class StartViewState extends State<StartView> {
  final docRef = FirebaseFirestore.instance.collection('gemini').doc('api');
  Future<void> getAPI() async {
    try {
      final snapshot = await docRef.get();
      final data = snapshot.data();
      if (data == null) {
        throw Exception('Data is null');
      }
      config.updateConfig(data['key'], data['baseUrl']);
      if (mounted) {
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
                child: TextLogo(context: context, text: 'Loading').textLogo());
          } else {
            return const SizedBox(); // Empty container as we are navigating to HomeView after API call
          }
        },
      ),
    );
  }
}
