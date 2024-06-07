// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:pink_ai/components/button/icon_button.dart';
import 'package:pink_ai/components/button/text_button.dart';
import 'package:pink_ai/controllers/firebase_controller.dart';
import 'package:pink_ai/controllers/login_register_controller.dart';

class SettingsView extends StatelessWidget {
  final ValueNotifier<bool> display;
  const SettingsView({super.key, required this.display});

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
                display.value = !display.value;
              }).noBorder(),
        ),
        Card(
          context: context,
          title: 'Tên',
          item: ButtonTextFuture(
            future: firebaseController.getName(),
          ).view(),
        ).view(),
        Card(
          context: context,
          title: 'Email',
          item: ButtonTextFuture(
            future: firebaseController.getEmail(),
          ).view(),
        ).view(),
        Card(
          context: context,
          title: 'Chủ đề',
          item: ThemeChange(context: context).button(),
        ).view(),
        Card(
          context: context,
          title: 'Đăng xuất',
          item: ButtonIcon(
              context: context,
              icon: Icons.logout,
              onPressed: () {
                loginRegisterController.signOut();
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
          item,
        ],
      ),
    );
  }
}

class ButtonTextFuture {
  final Future<String> future;

  const ButtonTextFuture({
    required this.future,
  });
  Widget view() {
    return FutureBuilder<String>(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return ButtonText(context: context,text: snapshot.data!,onPressed: (){

          }).noBorder();
        } else {
          return const Text('Loading...');
        }
      },
    );
  }
}
