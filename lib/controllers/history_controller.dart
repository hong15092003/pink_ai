import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pink_ai/controllers/home_controller.dart';
import 'package:pink_ai/models/chat_model.dart';

class HistoryController extends ChangeNotifier {
  void deleteHistory(id) {
    FirebaseFirestore.instance.collection('history').doc(id).delete();
    notifyListeners();
  }

  void restoreHistory(item) {
    if (chatList.isNotEmpty) {
      homeController.saveData();
    }
    List listChat = item['chat'].map((e) => ChatModel.fromJson(e)).toList();
    List<ChatModel> listChatModel = listChat.cast<ChatModel>();
    homeController.swapList(listChatModel);
    FirebaseFirestore.instance.collection('history').doc(item['id']).delete();
    notifyListeners();
  }
}

HistoryController historyController = HistoryController();
