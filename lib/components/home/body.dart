import 'package:flutter/material.dart';
import 'package:pink_ai/Extensions/markdown.dart';
import 'package:pink_ai/models/ai_content_model.dart';

class BodyHome {
  List<ChatModel> list;
  BodyHome({required this.list});

  bool checkRoleUser(int index) {
    return list[index].role == 'user';
  }

  Widget view() {
    return ListView.builder(
      padding: const EdgeInsets.only(top: 80, bottom: 80),
      itemCount: list.length,
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
              color: checkRoleUser(index) ? Colors.blue.withOpacity(0.8) : Colors.grey.withOpacity(0.8),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: checkRoleUser(index) ? Colors.blue : Colors.grey,
                  blurRadius: 5.0,
                  spreadRadius: 0.0,
                  // offset: Offset(2.0, 2.0), // shadow direction: bottom right
                )
              ],
            ),
            child: MarkDown(
              list[index].text,
            ),
            // child: Text(
            //   list.getlist(index),
            //   style: const TextStyle(
            //     color: Colors.white,
            //   ),
            // ),
          ),
        );
      },
    );
  }
}