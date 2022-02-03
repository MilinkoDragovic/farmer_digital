import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TranslateText extends StatelessWidget {
  String data;

  TranslateText(this.data, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Locale locale = Localizations.localeOf(context);
    return Text(
      AppLocalizations.of(context)!.helloWorld,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 18.0,
        fontWeight: FontWeight.bold,
      ),
      textAlign: TextAlign.center,
    );
  }
}
