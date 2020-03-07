import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:queuetodo/app.dart';
import 'package:queuetodo/localization.dart';
import 'package:queuetodo/theme.dart';

void main() {
  /// Make unit tests possible. At least in theory.
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: [
        const LocalizationDelegate(),
        GlobalCupertinoLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('en'),
        const Locale('pl'),
      ],
      theme: theme,
      title: 'QueueToDo',
      home: SafeArea(
        child: App(),
      ),
    ),
  );
}
