import 'package:flutter/material.dart';

class AvailableLocales {
  static final all = [
    const Locale('en'),
    const Locale('de'),
    const Locale('fr'),
    const Locale('nl'),
  ];

  static String getFlag(String code) {
    switch (code) {
      case 'de':
        return 'german';
      case 'fr':
        return 'franch';
      case 'nl':
        return 'holland';
      case 'en':
      default:
        return 'english';
    }
  }
}
