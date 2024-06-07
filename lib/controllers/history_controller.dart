import 'package:flutter/material.dart';
import 'package:pink_ai/controllers/firebase_controller.dart';
import 'package:pink_ai/controllers/home_controller.dart';
import 'package:pink_ai/models/chat_detail_model.dart';
import 'package:pink_ai/models/chat_model.dart';

class HistoryController extends ChangeNotifier {
  ValueNotifier<List<ChatDetailModel>> listItem = ValueNotifier([]);

  void deleteHistory(id) {
    firebaseController.deleteChat(id);
  }

  void restoreHistory(ChatDetailModel item) async {
    final chatId = item.id;
    firebaseController.chatId = chatId;
    final List<ChatModel> chatList = await firebaseController.getChat(chatId);
    homeController.swapList(chatList);
  }

  void getListChat() async {
    listItem.value = await firebaseController.getListChat();
  }

  void searchChat(String name) async {
    listItem.value = await firebaseController.searchChat(name);
  }

  List<List<ChatDetailModel>> sortChat() {
    final timeNow = DateTime.now();
    final List<List<ChatDetailModel>> list = List.generate(10, (index) => []);

    for (var chat in listItem.value) {
      final chatTime = chat.endTime;
      final difference = timeNow.difference(chatTime);

      if (difference.inDays == 0) {
        // Hôm nay
        list[0].add(chat);
      } else if (difference.inDays == 1) {
        // Hôm qua
        list[1].add(chat);
      } else if (difference.inDays == 2) {
        // 2 ngày trước
        list[2].add(chat);
      } else if (difference.inDays <= 7) {
        // 1 tuần trước
        list[3].add(chat);
      } else if (difference.inDays <= 14) {
        // 2 tuần trước
        list[4].add(chat);
      } else if (difference.inDays <= 30) {
        // 1 tháng trước
        list[5].add(chat);
      } else if (difference.inDays <= 60) {
        // 2 tháng trước
        list[6].add(chat);
      } else if (difference.inDays <= 90) {
        // 3 tháng trước
        list[7].add(chat);
      } else if (difference.inDays <= 300) {
        // 10 tháng trước
        list[8].add(chat);
      } else {
        // 1 năm trước
        list[9].add(chat);
      }
    }
    return list;
  }
}

HistoryController historyController = HistoryController();
