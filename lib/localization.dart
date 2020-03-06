import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LocalizationDelegate extends LocalizationsDelegate<Localization> {
  const LocalizationDelegate();

  @override
  Future<Localization> load(Locale locale) async {
    final localization = Localization(locale);
    await localization.load();
    return localization;
  }

  @override
  bool isSupported(Locale locale) => ['en', 'pl'].contains(locale.languageCode);

  @override
  bool shouldReload(LocalizationDelegate _) => false;
}

class Localization {
  final Locale locale;
  Map<String, dynamic> words = {};

  Localization(this.locale) {
    load();
  }

  Future<void> load() async {
    words = json.decode(
        await rootBundle.loadString('assets/lang/${locale.languageCode}.json'));
  }

  static Localization of(BuildContext context) {
    return Localizations.of<Localization>(context, Localization);
  }
}
