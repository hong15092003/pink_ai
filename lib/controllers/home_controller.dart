import 'dart:async';

import 'package:flutter/material.dart';

import 'package:pink_ai/controllers/api_controller.dart';
import 'package:pink_ai/controllers/firebase_controller.dart';
import 'package:pink_ai/models/chat_model.dart';

class HomeController {
  //Biến hiển thị hoặc ẩn OtherFn
  final displayOtherFunction = ValueNotifier<bool>(true);

  // Biến kiểm soát textbox của người dùng
  final TextEditingController textEditingController = TextEditingController();
  // danh sách chat
  List<ChatModel> chatList = [];
  final _chatListStreamController = StreamController<List<ChatModel>>();
  Stream<List<ChatModel>> get chatListStream =>
      _chatListStreamController.stream;
  final ScrollController scrollController = ScrollController();

  void getContent() {
    String content = textEditingController.text;
    textEditingController.clear();
    content = content.trimLeft();
    if (content.isEmpty) return;
    pushContent(content, 'user');
    geminiChat.generateContent(content);
  }

  void pushContent(String content, String role) {
    final time = DateTime.now();
    final chat = ChatModel(
      text: content,
      role: role,
      time: time,
    );
    chatList.add(chat);
    firebaseController.saveChat(chat);
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

  void clearContent() {
    geminiChat.body['contents'].clear();
  }

  void newChat() {
    if (chatList.isNotEmpty) {
      clearContent();
      firebaseController.createNewChat();
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
