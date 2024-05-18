import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pink_ai/config.dart';

import 'package:pink_ai/controllers/home_controller.dart';
import 'package:pink_ai/models/ai_content_model.dart';

class APIHandle {
  final String _apiKey = Config().apiKey;
  final String _baseUrl = Config().baseUrl;
  Map<String, dynamic> body = Config().body;


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
