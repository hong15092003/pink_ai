import 'package:flutter/material.dart';

import 'package:pink_ai/controllers/api_controller.dart';
import 'package:pink_ai/controllers/firebase_controller.dart';
import 'package:pink_ai/models/chat_model.dart';

class HomeController {
  //Biến hiển thị hoặc ẩn OtherFn
  final displayOtherFunction = ValueNotifier<bool>(false);
  final list = <ChatModel>[];

  // Biến kiểm soát textbox của người dùng
  // final TextEditingController textEditingController = TextEditingController();
  ValueNotifier<TextEditingController> textEditingController =
      ValueNotifier<TextEditingController>(TextEditingController());
  // danh sách chat
  ValueNotifier<List<ChatModel>> chatList = ValueNotifier(<ChatModel>[]);

  final ScrollController scrollController = ScrollController();

  void getContent() {
    String content = textEditingController.value.text;
    textEditingController.value.clear();
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
   
    chatList.value = [...chatList.value, chat];
    firebaseController.saveChat(chat);
    scrollToDown();
    // _chatListStreamController.add(chatList);
  }

  void scrollToDown() {
    scrollController.animateTo(
      scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  void newChat() {
    if (chatList.value.isNotEmpty) {
      geminiChat.body['contents'].clear();
      firebaseController.createNewChat();
      chatList.value = [];
      // _chatListStreamController.add(chatList);
    }
  }

  void swapList(List<ChatModel> list) {
    chatList.value = list;
    // _chatListStreamController.add(chatList);
  }
}

HomeController homeController = HomeController();
