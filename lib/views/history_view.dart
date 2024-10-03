// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pink_ai/components/popup/my_popup.dart';

import 'package:pink_ai/config.dart';
import 'package:pink_ai/controllers/history_controller.dart';
import 'package:pink_ai/models/chat_detail_model.dart';

class HistoryView {
  final BuildContext context;
  HistoryView({
    required this.context,
  });

  Widget view() {
    return StreamBuilder<QuerySnapshot>(
      stream: config.firestoreSaveData.snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text('Có lỗi xảy ra. Vuil lòng thử lại');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Loading...");
        }
        if (snapshot.hasData == true) {
          if (snapshot.data!.docs.isEmpty) {
            return Center(
              child: Text(
                'Chưa có lịch sử chat',
                style: Theme.of(context).textTheme.labelMedium,
              ),
            );
          }
        }

        historyController.getListChat();

        return ValueListenableBuilder<List<ChatDetailModel>>(
          valueListenable: historyController.listItem,
          builder: (context, list, index) {
            // final item = data.values.elementAt(index);

            return Body(context: context, list: list).view();
          },
        );
      },
    );
  }
}

class Body {
  final BuildContext context;
  final List<ChatDetailModel> list;
  Body({required this.context, required this.list});
  Widget view() {
    return ListView.builder(
      itemCount: list.length,
      itemBuilder: (context, index) {
        final item = list[index];
        return Container(
          margin: const EdgeInsets.all(10),
          // padding: const EdgeInsets.all(0),
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).shadowColor,
                blurRadius: 3.0,
                spreadRadius: 0.0,
                offset: const Offset(1, 1),
              )
            ],
          ),
          child: Dismissible(
              key: Key(item.id),
              // Unique identifier for this item
              background: Container(
                padding: const EdgeInsets.only(right: 20),
                // color: Theme.of(context).primaryColor,
                alignment: Alignment.centerRight,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Theme.of(context).shadowColor,
                      blurRadius: 3.0,
                      spreadRadius: 0.0,
                      offset: const Offset(1, 1),
                    )
                  ],
                ),
                child: const Icon(
                  Icons.delete_outline_rounded,
                  color: Colors.white,
                ),
              ), // Red background when swiping
              // background: Text('More'),
              onDismissed: (direction) {
                list.removeAt(index);
                historyController.deleteHistory(item.id);

                // Then show a snackbar.
                MyPopup().dialog(context, 'Đã xóa lịch sử chat ${item.name}');
              },
              child: ItemChat(context: context, item: item).view()),
        );
      },
    );
  }
}

class ItemChat {
  final BuildContext context;
  final ChatDetailModel item;
  ItemChat({required this.context, required this.item});

  Widget view() {
    String endTimeFormat =
        DateFormat('dd-MM-yyyy - kk:mm').format(item.endTime);
    return GestureDetector(
      onTap: () {
        historyController.restoreHistory(item);
      },
      child: ListTile(
        title: Text(
          item.name,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        subtitle: Text(
          endTimeFormat,
          style: TextStyle(
              color: Theme.of(context).textTheme.labelMedium!.color,
              fontSize: 10),
        ),
      ),
    );
  }
}

class Section {
  BuildContext context;
  Section({
    required this.context,
  });
  List<List<ChatDetailModel>> list = historyController.sortChat();
  Widget view() {
    return ListView.builder(
      itemCount: list.length,
      itemBuilder: (context, index) {
        return Column(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              color: Theme.of(context).primaryColor,
              child: Text(
                list[index][0].endTime.toString(),
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            Body(context: context, list: list[index]).view(),
          ],
        );
      },
    );
  }
}
