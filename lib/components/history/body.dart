
import 'package:flutter/material.dart';
import 'package:pink_ai/components/button/icon_button.dart';

import 'package:pink_ai/components/color/color_component.dart';
import 'package:pink_ai/controllers/history_controller.dart';

class BodyHistory {
  AsyncSnapshot<Map<String, dynamic>?> snapshot;
  BodyHistory({required this.snapshot});
  Widget view() {
    final data = snapshot.data;
    return ListView.builder(
      itemCount: data!.length,
      itemBuilder: (context, index) {
        final item = data.values.elementAt(index);

        return Container(
          margin: const EdgeInsets.only(top: 20, left: 10, right: 10),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: ColorStyle.backgroundColor,
            borderRadius: BorderRadius.circular(10),
            boxShadow: const [
              BoxShadow(
                color: Colors.grey,
                blurRadius: 5.0,
                spreadRadius: 1.0,
                offset: Offset(1, 1),
              )
            ],
          ),
          child: TextButton(
            onPressed: () {
              historyController.restoreHistory(item);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  item['name'],
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: ColorStyle.text,
                    fontSize: 15,
                  ),
                ),
                ButtonIcon(
                  onPressed: () {
                    historyController.deleteHistory(item['id']);
                  },
                  icon: Icons.delete_rounded,
                ).circle(),
              ],
            ),
          ),
        );
      },
    );
  }
}
