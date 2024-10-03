import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pink_ai/views/login_view.dart';
import 'package:pink_ai/views/start_view.dart';

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
          return  const StartView();
        } else {
          return  const LoginView();
        }
      },
    );
  }
}
