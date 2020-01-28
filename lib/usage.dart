import 'package:flutter/material.dart';

class Usage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Center(
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
                'Ancient proverb',
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
                  'Increase your productivity by organizing your tasks in the '
                  'most natural way - by queueing them. Stop procrastinating '
                  'and let the app to engage you to do tasks without the '
                  'possibility to change their order.\n\n'
                  'Just press the \'Add\' button to create one. Set a short '
                  'title and a little longer description. Push even more tasks '
                  'to the Queue and always start your work with the first one.',
                  textAlign: TextAlign.justify,
                  // style: Theme.of(context).textTheme.
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
