import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class MarkDown extends StatelessWidget {
  final String _data;
  const MarkDown(this._data, {super.key});
  @override
  Widget build(BuildContext context) {
    return MarkdownBody(
      selectable: true,
      data: _data,
      styleSheet: MarkdownStyleSheet(
        a: const TextStyle(color: Colors.white),
        p: const TextStyle(color: Colors.white),
        code: const TextStyle(
            color: Colors.white, backgroundColor: Colors.transparent),
        h1: const TextStyle(color: Colors.white),
        h2: const TextStyle(color: Colors.white),
        h3: const TextStyle(color: Colors.white),
        h4: const TextStyle(color: Colors.white),
        h5: const TextStyle(color: Colors.white),
        h6: const TextStyle(color: Colors.white),
        em: const TextStyle(color: Colors.white),
        strong: const TextStyle(color: Colors.white),
        del: const TextStyle(color: Colors.white),
        blockquote: const TextStyle(color: Colors.white),
        img: const TextStyle(color: Colors.white),
        checkbox: const TextStyle(color: Colors.white),
        tableHead: const TextStyle(color: Colors.white),
        tableBody: const TextStyle(color: Colors.white),
        listBullet: const TextStyle(color: Colors.white),
        codeblockDecoration: BoxDecoration(
          color: Colors.grey[850],
          borderRadius: BorderRadius.circular(5),
          border: Border.all(
            color: Colors.grey[850]!,
          ),
          boxShadow: const [
            BoxShadow(
              color: Colors.blue,
              blurRadius: 2.0,
              spreadRadius: 1.0,
            ),
          ],
        ),
      ),
    );
  }
}