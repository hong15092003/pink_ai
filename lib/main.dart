import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';


import 'package:pink_ai/firebase_options.dart';
import 'package:pink_ai/views/start_view.dart';



Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const StartView());
}

// gets new id

