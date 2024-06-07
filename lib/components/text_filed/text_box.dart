import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pink_ai/controllers/home_controller.dart';

class TextBox {
  final Widget? suffix;
  ValueNotifier? onTap;
  final TextEditingController textEditingController;
  final BuildContext context;

  TextBox({
    this.onTap,
    this.suffix,
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

  Widget chat() {
    return Container(
      constraints: const BoxConstraints(minHeight: 0.0),
      padding: const EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        border: Border.all(
          color: Theme.of(context).primaryColor.withOpacity(0.3),
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
          cursorColor: Theme.of(context).primaryColor,
          keyboardAppearance: Theme.of(context).brightness,
          controller: textEditingController,
          minLines: 1,
          maxLines: 4,
          textInputAction: Platform.isIOS ? TextInputAction.done : TextInputAction.none,
          onChanged: (_) {},
          onTap: () {
            onTap!.value = true;
          },
          onTapOutside: (i) {
            onTap!.value = false;
            _focusNode.unfocus();
          },
          decoration: InputDecoration(
            suffixIcon: suffix,
            suffixIconConstraints: const BoxConstraints(
              maxHeight: 30,
            ),
            border: const OutlineInputBorder(
              borderSide: BorderSide.none,
            ),
            hintText: 'Aa',
            hintStyle: Theme.of(context).textTheme.labelSmall,
            contentPadding:
                const EdgeInsets.only(left: 15, right: 15, top: 15, bottom: 15),
          ),
          style: Theme.of(context).textTheme.labelMedium,
        ),
      ),
    );
  }

  Widget inputInfoCirlce(String text, {bool isPassword = false}) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 500.0),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        border: Border.all(
          color: Theme.of(context).primaryColor,
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
          obscureText: isPassword,
          cursorColor: Theme.of(context).primaryColor,
          controller: textEditingController,
          maxLines: 1,

          textInputAction: Platform.isIOS ? TextInputAction.done : TextInputAction.none,
          // onChanged: (_) {
          //   print(_);
          // },
          onTap: () {},
          onTapOutside: (i) {
            _focusNode.unfocus();
          },
          decoration: InputDecoration(
            border: const OutlineInputBorder(
              borderSide: BorderSide.none,
            ),
            hintText: text,
            hintStyle: Theme.of(context).textTheme.labelMedium,
            contentPadding:
                const EdgeInsets.only(left: 20, right: 20, top: 5, bottom: 5),
          ),
          style: Theme.of(context).textTheme.labelMedium,
        ),
      ),
    );
  }

  Widget inputInfoRectangle(String text, {bool isPassword = false}) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 500.0),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        border: Border.all(
          color: Theme.of(context).primaryColor,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: KeyboardListener(
        focusNode: _focusNode,
        onKeyEvent: (KeyEvent event) {
          keyPress(event);
        },
        child: TextField(
          obscureText: isPassword,
          cursorColor: Theme.of(context).primaryColor,
          controller: textEditingController,
          maxLines: 1,

         textInputAction: Platform.isIOS ? TextInputAction.done : TextInputAction.none,
          // onChanged: (_) {
          //   print(_);
          // },
          onTap: () {},
          onTapOutside: (i) {
            _focusNode.unfocus();
          },
          decoration: InputDecoration(
            border: const OutlineInputBorder(
              borderSide: BorderSide.none,
            ),
            hintText: text,
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
