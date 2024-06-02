import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class MarkDown extends StatelessWidget {
  final String _data;
  const MarkDown(this._data, {super.key});
  @override
  Widget build(BuildContext context) {
    return MarkdownBody(
      onSelectionChanged: (a, b, c) => (),
      selectable: true,
      data: _data,
      styleSheet: MarkdownStyleSheet(
        a: Theme.of(context).textTheme.labelMedium,
        p: Theme.of(context).textTheme.labelMedium,
        code: TextStyle(
          color: Theme.of(context).primaryColor,
          backgroundColor: Colors.transparent,
          fontWeight: FontWeight.bold,
        ),
        h1: Theme.of(context).textTheme.labelMedium,
        h2: Theme.of(context).textTheme.labelMedium,
        h3: Theme.of(context).textTheme.labelMedium,
        h4: Theme.of(context).textTheme.labelMedium,
        h5: Theme.of(context).textTheme.labelMedium,
        h6: Theme.of(context).textTheme.labelMedium,
        em: Theme.of(context).textTheme.labelMedium,
        strong: Theme.of(context).textTheme.labelMedium,
        del: Theme.of(context).textTheme.labelMedium,
        blockquote: Theme.of(context).textTheme.labelMedium,
        img: Theme.of(context).textTheme.labelMedium,
        checkbox: Theme.of(context).textTheme.labelMedium,
        tableHead: Theme.of(context).textTheme.labelMedium,
        tableBody: Theme.of(context).textTheme.labelMedium,
        listBullet: Theme.of(context).textTheme.labelMedium,
        codeblockDecoration: BoxDecoration(
          color: Theme.of(context).canvasColor,
          borderRadius: BorderRadius.circular(5),
          border: Border.all(
            color: Theme.of(context).canvasColor,
          ),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).shadowColor,
              blurRadius: 2.0,
              spreadRadius: 1.0,
            ),
          ],
        ),
      ),
    );
  }
}
