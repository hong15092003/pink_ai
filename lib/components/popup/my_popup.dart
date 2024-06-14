import 'package:flutter/material.dart';
import 'package:pink_ai/components/button/text_button.dart';
import 'package:pink_ai/config.dart';

class MyPopup {
  void chooseModel(context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,

          title: const Center(child:  Text('Chọn model')),
          // content: Text(),
          actions: <Widget>[
            ButtonText(
              context: context,
              text: config.getModelName(1),
              onPressed: () {
                config.switchModel(1);
                Navigator.of(context).pop();
              },
            ).noBorder(),
            ButtonText(
              context: context,
              text: config.getModelName(2),
              onPressed: () {
                config.switchModel(2);
                Navigator.of(context).pop();
              },
            ).noBorder(),
          ],
        );
      },
    );
  }

  void dialog(context, status) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          // title: const Text('Lỗi'),
          content: Text(status),
          actions: <Widget>[
            ButtonText(
              context: context,
              text: 'Đóng',
              onPressed: () {
                Navigator.of(context).pop();
              },
            ).noBorder(),
          ],
        );
      },
    );
  }
}
