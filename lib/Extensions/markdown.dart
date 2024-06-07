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
        a: Theme.of(context).textTheme.labelSmall,
        p: Theme.of(context).textTheme.labelSmall,
        code: Theme.of(context).textTheme.labelSmall,
        h1: Theme.of(context).textTheme.labelSmall,
        h2: Theme.of(context).textTheme.labelSmall,
        h3: Theme.of(context).textTheme.labelSmall,
        h4: Theme.of(context).textTheme.labelSmall,
        h5: Theme.of(context).textTheme.labelSmall,
        h6: Theme.of(context).textTheme.labelSmall,
        em: Theme.of(context).textTheme.labelSmall,
        strong: Theme.of(context).textTheme.labelSmall,
        del: Theme.of(context).textTheme.labelSmall,
        blockquote: Theme.of(context).textTheme.labelSmall,
        img: Theme.of(context).textTheme.labelSmall,
        checkbox: Theme.of(context).textTheme.labelSmall,
        tableHead: Theme.of(context).textTheme.labelSmall,
        tableBody: Theme.of(context).textTheme.labelSmall,
        listBullet: Theme.of(context).textTheme.labelSmall,
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
