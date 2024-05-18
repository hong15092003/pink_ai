import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pink_ai/controllers/home_controller.dart';
import 'package:pink_ai/models/ai_content_model.dart';
import 'package:http/http.dart' as http;


class APIHandle {
  String _apiKey = "AIzaSyCGujlLQjjpEfid13hvw3wYX3gjbN482M4";
  String _baseUrl =
      "https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash-latest:generateContent?key=";
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

  void apiKeyandBody(String apiKey, String body) {
    _apiKey = apiKey;
    _baseUrl = body;
  }

  void generateContent(text) async {
    handleAfterCallAPI(text);
    final response = await http.post(Uri.parse(_baseUrl + _apiKey),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(body));
    handleBeforeCallAPI(response);
  }



  void addContentBody(String text, String role) {
    body['contents'].add({
      "role": role,
      "parts": [
        {"text": text}
      ]
    });
  }

  void handleAfterCallAPI(text) {
    debugPrint('click');
    addContentBody(text, 'user');
  }

  void handleBeforeCallAPI(response) {
    if (response.statusCode == 200) {
      final responseDecode = jsonDecode(response.body);
      ModelResponse modelResponse = ModelResponse.fromJson(responseDecode);
      final content = modelResponse.candidates[0].content.parts[0].text;
      homeController.pushContent(content, 'model');
      addContentBody(content, 'model');
    } else {
      homeController.pushContent('Đã xảy ra lỗi, vui lòng thử lại !', 'model');
    }
  }
}

APIHandle apiHandle = APIHandle();
//{content: {parts: [{text: Trời hôm nay nóng như lửa, nhưng may mà có nụ cười của cậu tỏa sáng như ông mặt trời, giúp tớ xua tan đi cái nóng bức này!}], role: model}
