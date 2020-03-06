import 'package:flutter/material.dart';

import 'package:queuetodo/localization.dart';

class Usage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Text(
            Localization.of(context).words['usage']['quote'],
            textAlign: TextAlign.center,
            style: TextStyle(
              fontStyle: FontStyle.italic,
              fontSize: 36.0,
            ),
          ),
          subtitle: Text(
            Localization.of(context).words['usage']['quote_author'],
            textAlign: TextAlign.center,
          ),
        ),
        ListTile(
          title: Text(
            Localization.of(context).words['usage']['description'],
            textAlign: TextAlign.justify,
          ),
        ),
      ],
    );
  }
}
