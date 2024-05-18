import 'package:flutter/material.dart';
import 'package:localstore/localstore.dart';
import 'package:pink_ai/views/home_view.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:pink_ai/views/start_view.dart';
// import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(
//   options: DefaultFirebaseOptions.currentPlatform,
// );
  runApp(const HomeView());
}

final db = Localstore.instance;
// gets new id


