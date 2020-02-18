import 'package:flutter/material.dart';

import 'package:url_launcher/url_launcher.dart';

import 'package:queuetodo/error.dart';

class About extends StatelessWidget {
  static const String _authorUrl =
      'https://play.google.com/store/search?q=mattmaniak';
  final String _repoUrl = '$_authorUrl/queuetodo';
  final String _semanticVersion = '1.0.0';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _AboutCard(
          title: 'QueueToDo $_semanticVersion',
          subtitle: Text('Manage your everyday tasks the right way.'),
        ),
        _AboutCard(
          title: 'Developer: mattmaniak',
          url: _authorUrl,
        ),
        _AboutCard(
          title: 'Source code',
          url: _repoUrl,
        ),
        _AboutCard(
          title: 'Changelog',
          url: '$_repoUrl/blob/master/CHANGELOG.md',
        ),
        _AboutCard(
          title: 'MIT License',
          url: '$_repoUrl/blob/master/LICENSE',
        ),
        _AboutCard(
          title: 'Terms of Use',
          subtitle: Text('Described in the license.'),
        ),
        _AboutCard(
          title: 'Privacy Policy',
          subtitle: Text('No data is collected.'),
        ),
      ],
    );
  }
}

class _AboutCard extends StatelessWidget {
  final Text subtitle;
  final String url;
  final String title;

  const _AboutCard({@required this.title, this.subtitle, this.url});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(
            16.0,
          ),
        ),
      ),
      child: ListTile(
        title: Text(title),
        subtitle: subtitle,
        trailing: url != null
            ? IconButton(
                icon: Icon(
                  Icons.open_in_new,
                  color: Theme.of(context).accentColor,
                ),
                onPressed: () => _openUrlInBrowser(context),
              )
            : null,
      ),
    );
  }

  void _openUrlInBrowser(BuildContext context) async {
    if (!(await canLaunch(url) && await launch(url))) {
      showErrorSnackBar(context, 'Unable to open a browser.');
    }
  }
}
