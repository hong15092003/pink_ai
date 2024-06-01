import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:pink_ai/components/button/icon_button.dart';
import 'package:pink_ai/views/history_view.dart';
import 'package:pink_ai/views/settings_view.dart';

class DrawerView extends StatefulWidget {
  const DrawerView({super.key});

  @override
  State<DrawerView> createState() => _DrawerViewState();
}

class _DrawerViewState extends State<DrawerView> {
  Widget view = const HistoryView();
  @override
  Widget build(BuildContext context) {
    final fullHeight = MediaQuery.of(context).size.height;
    // final fullWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Center(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 60.0),
                child: view,
              ),
              Positioned(
                top: 0,
                left: 0,
                child: Container(
                  padding:
                      const EdgeInsets.only(bottom: 35, right: 10, left: 10),
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
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ButtonIcon(
                        context: context,
                        icon: Icons.history_rounded,
                        onPressed: () => setState(
                          () {
                            view = const HistoryView();
                          },
                        ),
                      ).circle(),
                      const SizedBox(height: 10),
                      ButtonIcon(
                        context: context,
                        icon: Icons.settings_rounded,
                        onPressed: () => setState(
                          () {
                            view = const SettingsView();
                          },
                        ),
                      ).circle(),
                      const SizedBox(height: 10),
                      ButtonIcon(
                              context: context,
                              icon: Icons.arrow_back_rounded,
                              onPressed: () => Navigator.pop(context, '/home'))
                          .circle(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
