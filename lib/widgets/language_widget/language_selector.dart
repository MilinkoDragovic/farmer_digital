import 'package:farmer_digital/localizations/available_locales.dart';
import 'package:farmer_digital/widgets/language_widget/language_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LanguageSelector extends StatelessWidget {
  const LanguageSelector({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LanguageBloc(),
      child: Center(
        child: SizedBox(
          width: 200,
          height: 200,
          child: ListView.builder(
              itemCount: AvailableLocales.all.length,
              itemBuilder: (BuildContext context, int index) {
                return TextButton(
                  onPressed: () {
                    context.read<LanguageBloc>().add(ChangeLanguageEvent(
                          locale: AvailableLocales.all[index],
                        ));
                  },
                  child: Text(AvailableLocales.all[index].languageCode),
                );
              }),
        ),
      ),
    );
  }
}
