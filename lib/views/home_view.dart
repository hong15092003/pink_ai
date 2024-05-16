import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:pink_ai/components/color_component.dart';
import 'package:pink_ai/components/component.dart';
import 'package:pink_ai/controllers/home_controller.dart';
import 'package:pink_ai/models/ai_content_model.dart';
import 'package:pink_ai/views/history_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  bool isKeyboardShown(BuildContext context) {
    if (MediaQuery.of(context).viewInsets.bottom > 300) return true;
    bool isKeyboard = MediaQuery.of(context).viewInsets.bottom > oldPadding;
    oldPadding = MediaQuery.of(context).viewInsets.bottom;
    return isKeyboard;
  }

  // @override
  // void initState() async {
  //   super.initState();
  //   await homeController.getAPI();
  // }

  StreamController<bool> focus = StreamController<bool>();
  bool loading = false;
  double oldPadding = 0;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: ColorStyle.backgroundColor,
        drawer: const HistoryView(),
        body: Center(
          child: Stack(children: [
            const TextLogo().textLogo(),
            Align(
              alignment: Alignment.center,
              child: ListenableBuilder(
                  listenable: homeController,
                  builder: (context, snapshot) {
                    return BodyHome(list: chatList).view();
                  }),
            ),
            Align(
                alignment: Alignment.bottomCenter,
                child: ClipRRect(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                    child: Container(
                      color: Colors.grey[900]!.withOpacity(0.5),
                      padding: EdgeInsets.only(
                          bottom: isKeyboardShown(context) ? 5 : 30,
                          left: 10,
                          right: 10,
                          top: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Row(
                            children: [
                              Builder(
                                builder: (context) => ButtonIcon(
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
                                  icon: Icons.add_rounded,
                                  onPressed: () => homeController.saveData())
                              .circle(),
                          const SizedBox(width: 10),
                          Expanded(
                              child: TextBox(
                            textEditingController:
                                homeController.textEditingController,
                            focus: focus,
                          ).textBox()),
                          const SizedBox(width: 10),
                          ButtonIcon(
                                  icon: Icons.arrow_upward_rounded,
                                  onPressed: () => homeController.getContent())
                              .circle(),
                        ],
                      ),
                    ),
                  ),
                )),
          ]),
        ),
      ),
    );
  }
}
