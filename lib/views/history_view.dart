import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pink_ai/components/button/icon_button.dart';
import 'package:pink_ai/controllers/history_controller.dart';

class HistoryView extends StatefulWidget {
  const HistoryView({super.key});

  @override
  State<HistoryView> createState() => _HistoryViewState();
}

class _HistoryViewState extends State<HistoryView> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('history').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text('Có lỗi xảy ra. Vuil lòng thử lại');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Loading...");
        }
        if (snapshot.data!.docs.isEmpty) {
          return Center(
            child: Text(
              'Chưa có lịch sử chat',
              style: Theme.of(context).textTheme.labelMedium,
            ),
          );
        }
        final data = snapshot.data!.docs.asMap();

        return ListView.builder(
          itemCount: data.length,
          itemBuilder: (context, index) {
            final item = data.values.elementAt(index);

            return Container(
              margin: const EdgeInsets.only(top: 20, left: 10, right: 10),
              padding: const EdgeInsets.all(10),
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
              child: TextButton(
                onPressed: () {
                  historyController.restoreHistory(item);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Text(
                        item['name'],
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                    Flexible(
                      child: ButtonIcon(
                        context: context,
                        onPressed: () {
                          historyController.deleteHistory(item['id']);
                        },
                        icon: Icons.delete_rounded,
                      ).circle(),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
