import 'package:flutter/material.dart';

import 'package:url_launcher/url_launcher.dart';

import 'package:queuetodo/error.dart';

class About extends StatelessWidget {
  final String _authorUrl =
      'https://play.google.com/store/apps/developer?id=mattmaniak';
  final String _repoUrl = 'https://gitlab.com/mattmaniak/queuetodo';
  final String _semanticVersion = '1.1.0';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Text('QueueToDo $_semanticVersion'),
          subtitle: Text('adwwdd')
        ),
        _AboutButton(
          title: 'Developer\'s apps',
          url: _authorUrl,
        ),
        _AboutButton(
          title: 'Source code',
          url: _repoUrl,
        ),
        _AboutButton(
          title: 'Changelog',
          url: '$_repoUrl/blob/master/CHANGELOG.md',
        ),
        _AboutButton(
          title: 'MIT License',
          url: '$_repoUrl/blob/master/LICENSE',
        ),
        ListTile(
          title: Text('Terms of Use'),
          subtitle: Text('Described in the license.'),
        ),
        ListTile(
          title: Text('Privacy Policy'),
          subtitle: Text('No data is collected.'),
        ),
      ],
    );
  }
}

class _AboutButton extends StatelessWidget {
  final String url;
  final String title;

  const _AboutButton({@required this.title, this.url});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(title),
        trailing: IconButton(
          icon: Icon(
            Icons.open_in_new,
            color: Theme.of(context).accentColor,
          ),
          onPressed: () => _openUrlInBrowser(context),
        ),
      ),
    );
  }

  void _openUrlInBrowser(BuildContext context) async {
    if (!(await canLaunch(url) && await launch(url))) {
      showErrorSnackBar(context, 'Unable to open a browser.');
    }
  }
}
