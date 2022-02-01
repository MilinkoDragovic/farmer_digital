import 'package:farmer_digital/localizations/app_localization.dart';
import 'package:flutter/material.dart';

class TranslateText extends StatelessWidget {
  String data;

  TranslateText(this.data, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      AppLocalization.of(context).getTranslatedValues(data) as String,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 18.0,
        fontWeight: FontWeight.bold,
      ),
      textAlign: TextAlign.center,
    );
  }
}
