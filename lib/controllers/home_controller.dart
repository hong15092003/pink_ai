import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pink_ai/controllers/api_controller.dart';
import 'package:pink_ai/models/chat_model.dart';

class HomeController {
  final TextEditingController textEditingController = TextEditingController();
  List<ChatModel> chatList = [];
  final _chatListStreamController = StreamController<List<ChatModel>>();
  Stream<List<ChatModel>> get chatListStream =>
      _chatListStreamController.stream;
  final ScrollController scrollController = ScrollController();

  void getContent() {
    String content = textEditingController.text;
    content = content.trimLeft();
    if (content.isEmpty) return;
    pushContent(content, 'user');
    apiHandle.generateContent(textEditingController.text);
    clearText();
  }

  void pushContent(String content, String role) {
    chatList.add(ChatModel(text: content, role: role));
    scrollToDown();
    _chatListStreamController.add(chatList);
  }

  void scrollToDown() {
    scrollController.animateTo(
      scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  void clearText() {
    textEditingController.clear();
  }

  void clearContent() {
    apiHandle.body['contents'].clear();
  }

  void saveData() {
    final id = FirebaseFirestore.instance.collection('history').doc().id;
    DateTime time = DateTime.now();
    String formatTime = time.toString();
    final chat = {
      'id': id,
      'time': formatTime,
      'name': chatList[0].text,
      'chat': chatList.map((e) => e.toJson()).toList(),
    };
    FirebaseFirestore.instance.collection('history').doc(id).set(chat);
  }

  void newChat() {
    if (chatList.isNotEmpty) {
      clearContent();
      saveData();
      chatList.clear();
      _chatListStreamController.add(chatList);
    }
  }

  void swapList(List<ChatModel> list) {
    chatList = list;
    _chatListStreamController.add(chatList);
  }
}

HomeController homeController = HomeController();
