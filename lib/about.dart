import 'package:flutter/material.dart';

import 'package:url_launcher/url_launcher.dart';

import 'error.dart';

class About extends StatelessWidget {
  static const String _authorUrl = 'https://gitlab.com/mattmaniak';
  static const String _repoUrl = '$_authorUrl/queuetodo';

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          _AboutCard(
            title: 'Created by mattmaniak',
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
      ),
    );
  }
}

class _AboutCard extends StatelessWidget {
  final String title;
  final Text subtitle;
  final String url;

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
