import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

// import 'package:flutter/cupertino.dart';

import 'package:queuetodo/app.dart';
import 'package:queuetodo/localization.dart';
import 'package:queuetodo/theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    MaterialApp(
      localizationsDelegates: [
        const LocalizationDelegate(),
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
      debugShowCheckedModeBanner: false,
    ),
  );
}
