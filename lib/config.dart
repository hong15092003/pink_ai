import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Config {
  String apiKey = "AIzaSyAxZBFmrxQGifumViAhMz-icNX2v2GvL0k";
  String baseUrl =
      "https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-pro:generateContent?key=";
  final Map<String, dynamic> body = {
    "contents": [],
    "generationConfig": {
      "temperature": 1,
      "topK": 10,
      "topP": 1,
      "maxOutputTokens": 2048,
      "stopSequences": []
    },
    "safetySettings": [
      {
        "category": "HARM_CATEGORY_HARASSMENT",
        "threshold": "BLOCK_MEDIUM_AND_ABOVE"
      },
      {
        "category": "HARM_CATEGORY_HATE_SPEECH",
        "threshold": "BLOCK_MEDIUM_AND_ABOVE"
      },
      {
        "category": "HARM_CATEGORY_SEXUALLY_EXPLICIT",
        "threshold": "BLOCK_MEDIUM_AND_ABOVE"
      },
      {
        "category": "HARM_CATEGORY_DANGEROUS_CONTENT",
        "threshold": "BLOCK_MEDIUM_AND_ABOVE"
      }
    ]
  };
  String firstName = 'User';
  String lastName = 'Guest';
  String email = '';
  dynamic _firestore;
  dynamic _firestoreUser;

  get firestore => _firestore;
  get firestoreUser => _firestoreUser;

  Color primaryColor = const Color(0xFF2196F3);

  void updateProfile(userId, firstName, lastName, email) {
    this.firstName = firstName;
    this.lastName = lastName;
    this.email = email;
  }

  void updateEmail(String mail) {
    email = mail;
  }

  void updateName(String last, String first) {
    firstName = first;
    lastName = last;
  }

  void updateConfig(api, url) {
    apiKey = api;
    baseUrl = url;
  }

  String colorToHex(Color color) {
    return '#${color.value.toRadixString(16).padLeft(8, '0')}';
  }

  Color hexToColor(String hexColor) {
    final hexCode = hexColor.replaceAll('#', '');
    return Color(int.parse('FF$hexCode', radix: 16));
  }

  void updatePath(userId) {
    _firestore = FirebaseFirestore.instance
        .collection('User')
        .doc(userId)
        .collection('saveChat');
    _firestoreUser = FirebaseFirestore.instance.collection('User').doc(userId);
  }
}

Config config = Config();
