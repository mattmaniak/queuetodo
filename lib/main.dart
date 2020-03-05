import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

// import 'package:easy_localization/easy_localization.dart';

import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
// import 'package:flutter_localizations/flutter_localizations.dart';`

import 'package:queuetodo/app.dart';
// import 'package:queuetodo/localization.dart';
import 'package:queuetodo/theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  LIST_OF_LANGS = ['en', 'pl'];
  LANGS_DIR = 'assets/lang/';
  await translator.init();

  runApp(LocalizedApp(
    child: _LocalizedMaterialApp(),
  ));
}

class _LocalizedMaterialApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        DefaultCupertinoLocalizations.delegate,
      ],
      locale: translator.locale,
      supportedLocales: translator.locals(),
      theme: theme,
      title: 'QueueToDo',
      home: SafeArea(
        child: App(),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
