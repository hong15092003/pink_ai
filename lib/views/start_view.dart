import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pink_ai/controllers/home_controller.dart';

import 'home_view.dart';

class StartView extends StatefulWidget {
  const StartView({super.key});

  @override
  StartViewState createState() => StartViewState();
}

class StartViewState extends State<StartView> {
  final docRef = FirebaseFirestore.instance.collection('api').doc('google');
  Future<void> getAPI() async {
    final snapshot = await docRef.get();
    final data = snapshot.data();
    if (data == null) {
      return;
    }
   apiHandle.apiKeyandBody(data['key'], data['baseUrl']);
  }

 

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getAPI(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return const HomeView();
        }
      },
    );
  }
}
