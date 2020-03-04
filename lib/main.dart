import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:easy_localization/easy_localization.dart';

import 'package:queuetodo/app.dart';
// import 'package:queuetodo/localization.dart';
import 'package:queuetodo/theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    EasyLocalization(
      child: _LocalizedMaterialApp(),
    ),
  );
}

class _LocalizedMaterialApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return EasyLocalizationProvider(
      child: MaterialApp(
        supportedLocales: [
          Locale('en', 'US'),
          Locale('pl', 'PL'),
        ],
        locale: EasyLocalizationProvider.of(context).data.locale,
        localizationsDelegates: [
          EasyLocalizationDelegate(
            locale: EasyLocalizationProvider.of(context).data.locale,
            path: 'assets/lang',
          ),
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
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
}
