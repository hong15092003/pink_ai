import 'package:flutter/material.dart';
import 'package:pink_ai/controllers/api_controller.dart';
import 'package:pink_ai/main.dart';
import 'package:pink_ai/models/ai_content_model.dart';


class HomeController extends ChangeNotifier {
  final TextEditingController textEditingController = TextEditingController();

  void getContent() {
    String content = textEditingController.text;
    if (content.isEmpty) return;
    pushContent(content, 'user');
    apiHandle.generateContent(textEditingController.text);
    clearText();
  }

  void pushContent(String content, String role) {
    chatList.add(ChatModel(text: content, role: role));
    notifyListeners();
  }

  void clearText() {
    textEditingController.clear();
  }

  void clearContent() {
    apiHandle.body['contents'].clear();
    chatList.clear();
  }

  void saveData() {
    final id = db.collection('history').doc().id;
    DateTime time = DateTime.now();
    String formatTime = time.toString();
    final chat = {
      'id': id,
      'time': formatTime,
      'name': chatList[0].text,
      'chat': chatList.map((e) => e.toJson()).toList(),
    };
    db.collection('history').doc(id).set(chat);
    clearContent();
    notifyListeners();
  }

  void newChat() {
    // clearContent();
    saveData();
    notifyListeners();
  }

  void swapList(List<ChatModel> list) {
    chatList = list;
    notifyListeners();
  }
  
}

HomeController homeController = HomeController();
