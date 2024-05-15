import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:pink_ai/components/component.dart';
import 'package:pink_ai/controllers/history_controller.dart';
import 'package:pink_ai/main.dart';

class HistoryView extends StatefulWidget {
  const HistoryView({super.key});

  @override
  State<HistoryView> createState() => _HistoryViewState();
}

class _HistoryViewState extends State<HistoryView> {
  @override
  Widget build(BuildContext context) {
    final fullHeight = MediaQuery.of(context).size.height;
    // final fullWidth = MediaQuery.of(context).size.width;
    return Center(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 60.0),
              child: ListenableBuilder(
                  listenable: historyController,
                  builder: (context, snapshot) {
                    return FutureBuilder(
                        future: db.collection('history').get(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                                child: CircularProgressIndicator());
                          }
                          return BodyHistory(snapshot: snapshot).view();
                        });
                  }),
            ),
            Positioned(
              top: 0,
              left: 0,
              child: Container(
                alignment: Alignment.bottomCenter,
                padding: const EdgeInsets.only(bottom: 35, right: 10, left: 10),
                height: fullHeight,
                // width: 50,
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.1),
                  border: Border(
                    right: BorderSide(
                      color: Colors.blue.withOpacity(0.1),
                      width: 2,
                    ),
                  ),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(5),
                  ),
                ),
                child: ButtonIcon(
                    icon: Icons.arrow_back_rounded,
                    onPressed: () => Navigator.pop(context)).circle(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
