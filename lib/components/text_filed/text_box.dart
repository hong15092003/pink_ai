import 'package:flutter/material.dart';
import 'package:pink_ai/components/color/color_component.dart';
import 'package:pink_ai/controllers/home_controller.dart';

class TextBox {
  final TextEditingController textEditingController;
  dynamic focus;

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
        onSubmitted: (_) {
          homeController.getContent();
        },
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
