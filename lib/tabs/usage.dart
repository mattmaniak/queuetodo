import 'package:flutter/material.dart';

const String _usageInfo = '''
Just press the wide blue button and 'Push a task' which basically creates an
empty task and adds it to the queue. Fill a title and expand it to provide more
data in a description field. Is a task already done? Just click the
'Pop the first task' button above the queue and remove the first task.
Forget about tapping the 'Save' button. There is nothing like that. Everything
happens on the fly.
''';

class Usage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Text(
            'First is first.\nLast is last.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontStyle: FontStyle.italic,
              fontSize: 36.0,
            ),
          ),
          subtitle: Text(
            'Probably an ancient proverb',
            textAlign: TextAlign.center,
          ),
        ),
        ListTile(
          title: Text(
            _usageInfo.replaceAll('\n', ' '),
            textAlign: TextAlign.justify,
          ),
        ),
      ],
    );
  }
}
