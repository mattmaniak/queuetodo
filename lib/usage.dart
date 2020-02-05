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
    return Center(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(
              top: 36.0,
              bottom: 4.0,
            ),
            child: Text(
              'First is first.\nLast is last.',
              style: TextStyle(
                fontStyle: FontStyle.italic,
                fontSize: 36.0,
              ),
            ),
          ),
          Text(
            'Probably an ancient proverb',
            style: TextStyle(
              fontSize: 10.0,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: 16.0,
            ),
            child: Text('Manage your everyday tasks\nthe right way.',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.title),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: 16.0,
              right: 16.0,
              bottom: 36.0,
            ),
            child: Text(
              _usageInfo.replaceAll('\n', ' '),
              textAlign: TextAlign.justify,
            ),
          ),
        ],
      ),
    );
  }
}
