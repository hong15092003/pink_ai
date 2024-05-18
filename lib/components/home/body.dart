import 'package:flutter/material.dart';
import 'package:pink_ai/Extensions/markdown.dart';
import 'package:pink_ai/models/ai_content_model.dart';

class BodyHome {
  List<ChatModel> list;
  BodyHome({required this.list});

  bool checkRoleUser(int index) {
    try {
      return list[index].role == 'user';
    } catch (e) {
      return false; // Return a default value
    }
  }

  int chating(length) {
    try {
      if (list[length - 1].role == 'user') return 1;
    } catch (e) {
      return 0; // Return a default value
    }
    return 0;
  }

  String content(index) {
    try {
      return list[index].text;
    } catch (e) {
      return '....'; // Return a default value
    }
  }

  Widget view() {
    final length = list.length;
    return ListView.builder(
      padding: const EdgeInsets.only(top: 80, bottom: 80),
      itemCount: length + chating(length),
      itemBuilder: (context, index) {
        return Align(
          alignment: checkRoleUser(index)
              ? Alignment.centerRight
              : Alignment.centerLeft,
          child: Container(
            margin: checkRoleUser(index)
                ? const EdgeInsets.only(
                    top: 10, left: 60, right: 10, bottom: 10)
                : const EdgeInsets.only(
                    top: 10, left: 10, right: 60, bottom: 10),
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: checkRoleUser(index)
                  ? Colors.blue.withOpacity(0.8)
                  : Colors.grey[900]!.withOpacity(0.8),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: checkRoleUser(index) ? Colors.blue : Colors.grey[900]!,
                  blurRadius: 5.0,
                  spreadRadius: 0.0,
                  // offset: Offset(2.0, 2.0), // shadow direction: bottom right
                )
              ],
            ),
            child: MarkDown(
              content(index),
            ),
          ),
        );
      },
    );
  }
}
