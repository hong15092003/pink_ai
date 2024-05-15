import 'package:flutter/material.dart';
import 'package:pink_ai/Extensions/markdown.dart';
import 'package:pink_ai/components/color_component.dart';
import 'package:pink_ai/controllers/history_controller.dart';
import 'package:pink_ai/models/ai_content_model.dart';

class ButtonText {
  final String text;
  final VoidCallback onPressed;

  const ButtonText({
    required this.text,
    required this.onPressed,
  });
}

class ButtonIcon {
  final IconData icon;
  final VoidCallback onPressed;

  const ButtonIcon({
    required this.icon,
    required this.onPressed,
  });

  Widget circle() {
    return Container(
      height: 40,
      width: 40,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: ColorStyle.primary,
        boxShadow: [
          BoxShadow(
            color: ColorStyle.primary,
            blurRadius: 10.0,
            spreadRadius: 0.0,
            // offset: Offset(2.0, 2.0), // shadow direction: bottom right
          )
        ],
      ),
      child: IconButton(
        color: ColorStyle.text,
        icon: Icon(icon, size: 20),
        onPressed: onPressed,
      ),
    );
  }
}

class TextBox {
  final TextEditingController textEditingController;
  final focus;

  TextBox({
    required this.textEditingController,
    required this.focus,
  });

  Widget textBox() {
    return Container(
      constraints: const BoxConstraints(minHeight: 0.0),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(25),
      ),
      child: TextField(
        controller: textEditingController,
        minLines: 1,
        maxLines: 10,
        // expands: true,
        // onChanged: (_) {},
        // onTap: () {},
        // onTapOutside: (i) {},
        decoration: InputDecoration(
          border: const OutlineInputBorder(
            borderSide: BorderSide.none,
          ),
          hintText: 'Nhập câu hỏi...',
          hintStyle: TextStyle(color: ColorStyle.text, fontSize: 15),
          contentPadding:
              const EdgeInsets.only(left: 20, right: 20, top: 5, bottom: 5),
        ),
        style: TextStyle(
          color: ColorStyle.text,
          fontSize: 15,
        ),
      ),
    );
  }
}

class TextLogo {
  const TextLogo();

  Widget textLogo() {
    return const Align(
      alignment: Alignment.center,
      child: Text(
        'PIAI',
        style: TextStyle(
          fontSize: 80,
          fontWeight: FontWeight.bold,
          color: Color.fromRGBO(46, 46, 46, 1),
        ),
      ),
    );
  }
}

class BodyHome {
  List<ChatModel> list;
  BodyHome({required this.list});

  bool checkRoleUser(int index) {
    return list[index].role == 'user';
  }

  Widget view() {
    return ListView.builder(
      padding: const EdgeInsets.only(top: 80, bottom: 80),
      itemCount: list.length,
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
              color: checkRoleUser(index) ? Colors.blue : Colors.grey[900],
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: checkRoleUser(index) ? Colors.blue : Colors.grey,
                  blurRadius: 5.0,
                  spreadRadius: 0.0,
                  // offset: Offset(2.0, 2.0), // shadow direction: bottom right
                )
              ],
            ),
            child: MarkDown(
              list[index].text,
            ),
            // child: Text(
            //   list.getlist(index),
            //   style: const TextStyle(
            //     color: Colors.white,
            //   ),
            // ),
          ),
        );
      },
    );
  }
}

class BodyHistory {
  final snapshot;
  BodyHistory({required this.snapshot});
  Widget view() {
    final data = snapshot.data;
    return ListView.builder(
      itemCount: data!.length,
      itemBuilder: (context, index) {
        final item = data.values.elementAt(index);

        return Container(
          margin: const EdgeInsets.only(top: 20, left: 10, right: 10),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: ColorStyle.backgroundColor,
            borderRadius: BorderRadius.circular(10),
            boxShadow: const [
              BoxShadow(
                color: Colors.grey,
                blurRadius: 5.0,
                spreadRadius: 1.0,
                offset: Offset(1, 1),
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
                Text(
                  item['name'],
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: ColorStyle.text,
                    fontSize: 15,
                  ),
                ),
                ButtonIcon(
                  onPressed: () {
                    historyController.deleteHistory(item['id']);
                  },
                  icon: Icons.delete_rounded,
                ).circle(),
              ],
            ),
          ),
        );
      },
    );
  }
}
