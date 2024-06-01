import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pink_ai/controllers/home_controller.dart';

class TextBox {
  final TextEditingController textEditingController;
  final BuildContext context;

  TextBox({
    required this.textEditingController,
    required this.context,
  });
  final FocusNode _focusNode = FocusNode();
  bool _isShiftPressed = false;

  void keyPress(event) {
    // Add this condition
    if (event is KeyDownEvent) {
      if (event.logicalKey == LogicalKeyboardKey.shiftLeft ||
          event.logicalKey == LogicalKeyboardKey.shiftRight) {
        _isShiftPressed = true;
      }
    } else if (event is KeyUpEvent) {
      if (event.logicalKey == LogicalKeyboardKey.shiftLeft ||
          event.logicalKey == LogicalKeyboardKey.shiftRight) {
        _isShiftPressed = false;
      }
    }

    if (event is KeyDownEvent) {
      if (_isShiftPressed && event.logicalKey == LogicalKeyboardKey.enter) {
        textEditingController.text += '\n';
        textEditingController.selection = TextSelection.fromPosition(
          TextPosition(offset: textEditingController.text.length),
        );
      } else if (event.logicalKey == LogicalKeyboardKey.enter) {
        String trimmedText = textEditingController.text.trim();
        if (trimmedText.isEmpty) return;
        homeController.getContent();
        return;
      }
    }
  }

  Widget textBox() {
    return Container(
      constraints: const BoxConstraints(minHeight: 0.0),
      decoration: BoxDecoration(
        color: Theme.of(context).canvasColor,
        border: Border.all(
          color: Theme.of(context).dividerColor,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(25),
      ),
      child: KeyboardListener(
        focusNode: _focusNode,
        onKeyEvent: (KeyEvent event) {
          keyPress(event);
        },
        child: TextField(
          controller: textEditingController,
          minLines: 1,
          maxLines: 4,
          textInputAction: TextInputAction.none,
          // onChanged: (_) {
          //   print(_);
          // },
          onTap: () {},
          onTapOutside: (i) {},
          decoration: InputDecoration(
            border: const OutlineInputBorder(
              borderSide: BorderSide.none,
            ),
            hintText: 'Nhập câu hỏi...',
            hintStyle: Theme.of(context).textTheme.labelMedium,
            contentPadding:
                const EdgeInsets.only(left: 20, right: 20, top: 5, bottom: 5),
          ),
          style: Theme.of(context).textTheme.labelMedium,
        ),
      ),
    );
  }
}
