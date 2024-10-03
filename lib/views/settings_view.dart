import 'package:flutter/material.dart';

import 'package:pink_ai/components/button/icon_button.dart';
import 'package:pink_ai/components/button/text_button.dart';
import 'package:pink_ai/config.dart';
import 'package:pink_ai/controllers/firebase_controller.dart';
import 'package:pink_ai/controllers/login_register_controller.dart';
import 'package:pink_ai/components/text_filed/text_box.dart';
import 'package:pink_ai/main.dart';
import 'package:pink_ai/views/auth_view.dart';

class SettingsView extends StatefulWidget {
  final ValueNotifier<bool> display;

  const SettingsView({super.key, required this.display});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  final ValueNotifier<bool> isNameChange = ValueNotifier(false);
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();

  // final ValueNotifier<bool> display;
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Align(
          alignment: Alignment.center,
          child: ButtonIcon(
              context: context,
              icon: Icons.keyboard_double_arrow_down_rounded,
              onPressed: () {
                widget.display.value = !widget.display.value;
              }).noBorder(),
        ),
        ValueListenableBuilder(
            valueListenable: isNameChange,
            builder: (context, value, child) {
              return Card(
                context: context,
                title: 'Tên',
                item: ButtonText(
                    context: context,
                    text:
                        '${config.lastName = lastName.text} ${config.firstName = firstName.text}',
                    onPressed: () {
                      isNameChange.value = !isNameChange.value;
                    }).noBorder(),
              ).view();
            }),
        NameChange(isNameChange, firstName, lastName, context: context).view(),
        Card(
          context: context,
          title: 'Email',
          item:
              ButtonText(context: context, text: config.email, onPressed: () {})
                  .noBorder(),
        ).view(),
        Card(
          context: context,
          title: 'Chủ đề',
          item: ThemeChange(context: context).button(),
        ).view(),
        ColorPicker().build(context),
        Card(
          context: context,
          title: 'Đăng xuất',
          item: ButtonIcon(
              context: context,
              icon: Icons.logout,
              onPressed: () {
                loginRegisterController.signOut();
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => const AuthGateWay(),
                  ),
                );
              }).noBorder(),
        ).view(),
      ],
    );
  }
}

class Card {
  final BuildContext context;
  final String title;
  final Widget item;

  Card({
    required this.context,
    required this.title,
    required this.item,
  });
  Widget view() {
    return Container(
      height: 60,
      margin: const EdgeInsets.only(top: 20, left: 10, right: 10),
      padding: const EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 20),
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

      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          Expanded(
              child:Align(
                  alignment: Alignment.centerRight,
                  child: item
              )
          ),
        ],
      ),
    );
  }
}

class NameChange {
  final ValueNotifier<bool> isNameChange;
  final BuildContext context;
  final TextEditingController firstName;
  final TextEditingController lastName;
  NameChange(this.isNameChange, this.firstName, this.lastName,
      {required this.context});
  Widget view() {
    firstName.text = config.firstName;
    lastName.text = config.lastName;
    return ValueListenableBuilder(
        valueListenable: isNameChange,
        builder: (context, value, child) {
          return Visibility(
            visible: isNameChange.value,
            child: Container(
              margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: TextBox(
                                context: context,
                                textEditingController: lastName)
                            .inputInfoRectangle('Họ'),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: TextBox(
                                context: context,
                                textEditingController: firstName)
                            .inputInfoRectangle('Tên'),
                      )
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      ButtonText(
                        context: context,
                        text: 'Huỷ',
                        onPressed: () {
                          isNameChange.value = false;
                        },
                      ).rectangle(),
                      const SizedBox(width: 10),
                      ButtonText(
                        context: context,
                        text: 'Lưu',
                        onPressed: () {
                          isNameChange.value = false;
                          firebaseController.updateName(
                            lastName.text,
                            firstName.text,
                          );
                        },
                      ).rectangle(),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }
}

class ColorPicker {
  Widget build(BuildContext context) {
    final ScrollController scrollController = ScrollController();
    List<Color> colors = [
      const Color(0xFFF44336),
      const Color(0xFF2196F3),
      const Color(0xFF4CAF50),
      const Color(0xFF9C27B0),
      const Color(0xFFFF9800),
      const Color(0xFFFB538B),
      const Color(0xFF009687),
      const Color(0xFF795548),
      const Color(0xFF9E9E9E),
    ];

    return Container(
      height: 120,
      margin: const EdgeInsets.only(top: 20, left: 10, right: 10),
      padding: const EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 20),
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

      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text('Màu chủ đề',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              Container(
                margin: const EdgeInsets.only(right: 10),
                height: 25,
                width: 25,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: primaryColorNotifier.value,
                  boxShadow: [
                    BoxShadow(
                      color: primaryColorNotifier.value,
                      blurRadius: 5.0,
                      spreadRadius: 0.0,
                    )
                  ],
                ),
              ),
            ],
          ),
          Expanded(
            child: Scrollbar(
              controller: scrollController,
              child: ListView.builder(
                controller: scrollController,
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: colors.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      primaryColorNotifier.value = colors[index];
                      firebaseController.updatePrimaryColor(colors[index]);
                    },
                    child: Container(
                      margin: const EdgeInsets.only(left: 5, right: 5),
                      height: 25,
                      width: 25,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: colors[index],
                        boxShadow: [
                          BoxShadow(
                            color: colors[index],
                            blurRadius: 5.0,
                            spreadRadius: 0.0,
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
