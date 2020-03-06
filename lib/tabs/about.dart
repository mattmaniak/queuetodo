import 'package:flutter/material.dart';

import 'package:url_launcher/url_launcher.dart';

import 'package:queuetodo/error.dart';
import 'package:queuetodo/localization.dart';

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
            subtitle: Text(Localization.of(context).words['about']['motto'])),
        _AboutButton(
          title: Localization.of(context).words['about']['developer_apps'],
          url: _authorUrl,
        ),
        _AboutButton(
          title: Localization.of(context).words['about']['source_code'],
          url: _repoUrl,
        ),
        _AboutButton(
          title: Localization.of(context).words['about']['changelog'],
          url: '$_repoUrl/blob/master/CHANGELOG.md',
        ),
        _AboutButton(
          title: Localization.of(context).words['about']['license'],
          url: '$_repoUrl/blob/master/LICENSE',
        ),
        ListTile(
          title: Text(
              Localization.of(context).words['about']['terms_of_use_title']),
          subtitle: Text(
              Localization.of(context).words['about']['terms_of_use_subtitle']),
        ),
        ListTile(
          title: Text(
              Localization.of(context).words['about']['privacy_policy_title']),
          subtitle: Text(Localization.of(context).words['about']
              ['privacy_policy_subtitle']),
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
      showErrorSnackBar(
          context, Localization.of(context).words['about']['browser_error']);
    }
  }
}
