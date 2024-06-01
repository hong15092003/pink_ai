import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:pink_ai/components/button/icon_button.dart';
import 'package:pink_ai/controllers/home_controller.dart';
import 'package:pink_ai/components/text_filed/text_box.dart';

class Bottom {
  final BuildContext context;
  Bottom({required this.context});
  bool isKeyboardShown(BuildContext context) {
    if (MediaQuery.of(context).viewInsets.bottom > 300) return true;
    bool isKeyboard = MediaQuery.of(context).viewInsets.bottom > oldPadding;
    oldPadding = MediaQuery.of(context).viewInsets.bottom;
    return isKeyboard;
  }

  bool loading = false;
  double oldPadding = 0;
  Widget bar() {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(
        top: Radius.circular(25),
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: Container(
          color: Theme.of(context).canvasColor.withOpacity(0.7),
          padding: EdgeInsets.only(
              bottom: isKeyboardShown(context) ? 5 : 30,
              left: 10,
              right: 10,
              top: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  Builder(
                    builder: (context) => ButtonIcon(
                      context: context,
                      icon: Icons.menu_rounded,
                      onPressed: () {
                        Scaffold.of(context).openDrawer();
                      },
                    ).circle(),
                  ),
                  const SizedBox(width: 10),
                ],
              ),
              ButtonIcon(
                  context: context,
                  icon: Icons.add_rounded,
                  onPressed: () => homeController.newChat()).circle(),
              const SizedBox(width: 10),
              Expanded(
                  child: TextBox(
                context: context,
                textEditingController: homeController.textEditingController,
              ).textBox()),
              const SizedBox(width: 10),
              ButtonIcon(
                  context: context,
                  icon: Icons.arrow_upward_rounded,
                  onPressed: () => homeController.getContent()).circle(),
            ],
          ),
        ),
      ),
    );
  }
}
