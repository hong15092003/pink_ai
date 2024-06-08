import 'package:flutter/material.dart';

import 'package:pink_ai/Extensions/markdown.dart';
import 'package:pink_ai/components/button/icon_button.dart';
import 'package:pink_ai/components/button/text_button.dart';
import 'package:pink_ai/components/logo/text_logo.dart';
import 'package:pink_ai/components/text_filed/text_box.dart';
import 'package:pink_ai/config.dart';
import 'package:pink_ai/controllers/api_controller.dart';
import 'package:pink_ai/controllers/home_controller.dart';
import 'package:pink_ai/models/chat_model.dart';
import 'package:pink_ai/views/drawer_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Top(context: context).view(),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      drawer: const SizedBox(width: 300, child: DrawerView()),
      bottomNavigationBar: const SizedBox(height: 20),
      body: Center(
        child: Stack(
          children: [
            TextLogo(context: context, text: 'PIAI').textLogo(),
            Align(
              alignment: Alignment.center,
              child: StreamBuilder<List<ChatModel>>(
                  stream: homeController.chatListStream,
                  builder: (context, snapshot) {
                    return BodyHome(list: homeController.chatList).view();
                  }),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Bottom(context: context).view(),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Container(
                  margin: const EdgeInsets.only(bottom: 70),
                  height: 50,
                  child: Ideas().view()),
            ),
          ],
        ),
      ),
    );
  }
}

class Top {
  final BuildContext context;
  Top({required this.context});

  AppBar view() {
    return AppBar(
        surfaceTintColor: Theme.of(context).scaffoldBackgroundColor,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        leading: Builder(
          builder: (context) => ButtonIcon(
            context: context,
            icon: Icons.arrow_back_ios_new_outlined,
            onPressed: () => Scaffold.of(context).openDrawer(),
          ).noBorder(),
        ),
        title: ButtonText(
          context: context,
          text: 'home',
          onPressed: () => Popup(context: context).menu(),
        ).circle(),
        actions: [
          ButtonIcon(
            context: context,
            icon: Icons.archive_outlined,
            onPressed: () => homeController.newChat(),
          ).noBorder(),
        ]);
  }
}

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
      controller: homeController.scrollController,
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
                    ? Theme.of(context).primaryColor
                    : Theme.of(context).scaffoldBackgroundColor,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: checkRoleUser(index)
                        ? Theme.of(context).primaryColor
                        : Theme.of(context).shadowColor,
                    blurRadius: 5.0,
                    spreadRadius: 0.0,
                    // offset: Offset(2.0, 2.0), // shadow direction: bottom right
                  )
                ],
              ),
              child: Column(
                crossAxisAlignment: checkRoleUser(index)
                    ? CrossAxisAlignment.end
                    : CrossAxisAlignment.start,
                children: [
                  content(index) == '....'
                      ?  CircularProgressIndicator(
                        color: Theme.of(context).primaryColor,
                      )
                      : MarkDown(
                          content(index),
                        ),
                ],
              )),
        );
      },
    );
  }
}

class Bottom {
  final BuildContext context;
  Bottom({required this.context});
  // bool isKeyboardShown(BuildContext context) {
  //   if (MediaQuery.of(context).viewInsets.bottom > 300) return true;
  //   bool isKeyboard = MediaQuery.of(context).viewInsets.bottom > oldPadding;
  //   oldPadding = MediaQuery.of(context).viewInsets.bottom;
  //   return isKeyboard;
  // }

  // bool loading = false;
  // double oldPadding = 0;

  Widget view() {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      padding: const EdgeInsets.only(bottom: 10, left: 10, right: 10, top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const OtherFunction(),
          const SizedBox(width: 10),
          Expanded(
              child: TextBox(
            context: context,
            textEditingController: homeController.textEditingController.value,
            onTap: homeController.displayOtherFunction,
            suffix: ButtonIcon(
                context: context,
                icon: Icons.arrow_upward_rounded,
                onPressed: () => homeController.getContent()).circleBorder(),
          ).chat()),
        ],
      ),
    );
  }
}

class OtherFunction extends StatefulWidget {
  const OtherFunction({super.key});

  @override
  State<OtherFunction> createState() => _OtherFunctionState();
}

class _OtherFunctionState extends State<OtherFunction> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: homeController.displayOtherFunction,
      builder: (context, value, child) {
        return AnimatedCrossFade(
          firstChild: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ButtonIcon(
              key: const ValueKey('addButton'),
              context: context,
              icon: Icons.add_rounded,
              onPressed: () {},
            ).circleBorder(),
          ),
          secondChild: Wrap(
            children: [
              ButtonIcon(
                context: context,
                icon: Icons.camera_alt_outlined,
                onPressed: () {},
              ).noBorder(),
              ButtonIcon(
                context: context,
                icon: Icons.image_outlined,
                onPressed: () {
                  vision.pickImage();
                },
              ).noBorder(),
              ButtonIcon(
                context: context,
                icon: Icons.folder_outlined,
                onPressed: () {},
              ).noBorder(),
            ],
          ),
          crossFadeState:
              value ? CrossFadeState.showFirst : CrossFadeState.showSecond,
          duration: const Duration(milliseconds: 100),
        );
      },
    );
  }
}

class Popup {
  final BuildContext context;

  Popup({required this.context});

  void menu() {
    final fullWidth = MediaQuery.of(context).size.width;
    final centerWidth = fullWidth / 2;

    showMenu(
      shadowColor: Colors.transparent,
      context: context,
      color: Theme.of(context).scaffoldBackgroundColor,
      popUpAnimationStyle: AnimationStyle(reverseCurve: Curves.easeInOut),
      position: RelativeRect.fromLTRB(centerWidth - 60, 50, centerWidth, 0),
      items: [
        PopupMenuItem(
          child: ButtonText(
              context: context,
              text: config.getModelName(1),
              onPressed: () {
                config.switchModel(1);
              }).noBorder(),
        ),
        PopupMenuItem(
          child: ButtonText(
              context: context,
              text: config.getModelName(2),
              onPressed: () {
                config.switchModel(2);
              }).noBorder(),
        ),
      ],
    );
  }
}

class Ideas {
  List<String> ideas = [
    'Tại sao 1 + 1 = 2 ?',
    'Quy tắc bàn tay phải ?',
    'Viết 1 đoạn văn về nobita.',
    'Thành phần của thuốc nổ',
    'Công thức hóa học của nước ?',
  ];
  Widget view() {
    return ValueListenableBuilder(
        valueListenable: homeController.textEditingController.value,
        builder: (context, snapshot, child) {
          return Visibility(
            visible: snapshot.text.isEmpty && homeController.chatList.isEmpty,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: ideas.length,
              itemBuilder: (context, index) {
                return Container(
                  padding: const EdgeInsets.all(5),
                  margin: const EdgeInsets.only(left: 10),
                  child: ButtonText(
                    context: context,
                    text: ideas[index],
                    onPressed: () {
                      homeController.textEditingController.value.text =
                          ideas[index];
                    },
                  ).rectangle(),
                );
              },
            ),
          );
        });
  }
}
