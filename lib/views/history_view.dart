// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
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
      stream: config.firestore.snapshots(),
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
          margin: const EdgeInsets.only(top: 20, left: 10, right: 10),
          padding: const EdgeInsets.all(5),
          // foregroundDecoration: ,
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).shadowColor,
                blurRadius: 5.0,
                spreadRadius: 1.0,
                offset: const Offset(1, 1),
              )
            ],
          ),
          child: ItemChat(context: context, item: item).view(),
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
    return TextField(
      style: TextStyle(
        overflow: TextOverflow.ellipsis,
        color: Theme.of(context).textTheme.titleMedium!.color,
        fontSize: 15,
      ),
      controller: TextEditingController(text: item.name),
      readOnly: true,
      maxLines: 1,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(10),
        border: InputBorder.none,
        suffixIcon: IconButton(
          icon: const Icon(
            Icons.delete_rounded,
            color: Colors.red,
          ),
          onPressed: () {
            historyController.deleteHistory(item.id);
          },
        ),
      ),
      onTap: () {
        historyController.restoreHistory(item);
      },
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
