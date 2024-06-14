import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class MarkDown extends StatelessWidget {
  final String _data;
  final Color? color;

  const MarkDown(this._data, {super.key, this.color});
  @override
  Widget build(BuildContext context) {
     TextStyle textSytyle = Theme.of(context).textTheme.labelSmall!.copyWith(
        color: color ?? Theme.of(context).textTheme.labelSmall!.color,
      );
    return MarkdownBody(
      onSelectionChanged: (a, b, c) => (),
      selectable: true,
      data: _data,
      styleSheet: MarkdownStyleSheet(
        a: textSytyle,
        p: textSytyle,
        code: textSytyle,
        h1: textSytyle,
        h2: textSytyle,
        h3: textSytyle,
        h4: textSytyle,
        h5: textSytyle,
        h6: textSytyle,
        em: textSytyle,
        strong: textSytyle,
        del: textSytyle,
        blockquote: textSytyle,
        img: textSytyle,
        checkbox: textSytyle,
        tableHead: textSytyle,
        tableBody: textSytyle,
        listBullet: textSytyle,
        codeblockDecoration: BoxDecoration(
          color: Colors.grey[900],
          borderRadius: BorderRadius.circular(5),
          border: Border.all(
            color: Colors.grey[800]!,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey[800]!,
              blurRadius: 2.0,
              spreadRadius: 1.0,
            ),
          ],
        ),
      ),
    );
  }
}
