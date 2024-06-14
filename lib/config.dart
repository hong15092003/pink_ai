import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pink_ai/models/api_config_model.dart';

class Config {
  String _apiKey = "";
  String _model = "gemini-1.5-pro";
  String _version = "v1beta";
  String _model1 = "gemini-1.5-pro";
  String _model2 = "gemini-1.5-flash";
  String _headerUrl = "https://generativelanguage.googleapis.com";
  final Map<String, dynamic> body = {
    "contents": [],
    "generationConfig": {
      "temperature": 1,
      "topK": 64,
      "topP": 1,
      "maxOutputTokens": 8192,
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

  get baseUrl =>
      "$_headerUrl/$_version/models/$_model:generateContent?key=$_apiKey";

  String firstName = 'User';
  String lastName = 'Guest';
  String email = '';
  dynamic _firestoreSaveData;
  dynamic _firestoreUser;
  final _firestore = FirebaseFirestore.instance;

  get firestoreSaveData => _firestoreSaveData;
  get firestoreUser => _firestoreUser;
  get firestore => _firestore;

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

  void updateConfig(ApiConfigModel apiConfigModel) {
    _apiKey = apiConfigModel.apiKey;
    _model = apiConfigModel.model;
    _model1 = apiConfigModel.model1;
    _model2 = apiConfigModel.model2;
    _version = apiConfigModel.version;
    _headerUrl = apiConfigModel.headerUrl;
  }

  void switchModel(int index) {
    if (index == 1) {
      _model = _model1;
    } else if (index == 2){
      _model = _model2;
    }
    else{
      _model = _model;
    }
  }

  String getModelName(index){
    if(index == 1){
      return _model1;
    }
    else if(index == 2){
      return _model2;
    }
    else{
      return _model;
    }
  }

  String colorToHex(Color color) {
    return '#${color.value.toRadixString(16).padLeft(8, '0')}';
  }

  Color hexToColor(String hexColor) {
    final hexCode = hexColor.replaceAll('#', '');
    return Color(int.parse('FF$hexCode', radix: 16));
  }

  void updatePath(userId) {
    _firestoreSaveData = _firestore
        .collection('User')
        .doc(userId)
        .collection('saveChat');
    _firestoreUser = _firestore.collection('User').doc(userId);
  }
}

Config config = Config();
