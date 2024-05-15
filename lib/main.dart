import 'package:flutter/material.dart';
import 'package:pink_ai/views/home_view.dart';
import 'package:localstore/localstore.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const HomeView());
}

final db = Localstore.instance;
// gets new id


