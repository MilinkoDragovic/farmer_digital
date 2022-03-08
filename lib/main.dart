import 'package:farmer_digital/l10n/l10n.dart';
import 'package:farmer_digital/screens/auth/authentication_bloc.dart';
import 'package:farmer_digital/widgets/language_widget/language_bloc.dart';
import 'package:farmer_digital/widgets/loader/loading_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:farmer_digital/constants.dart';

import 'package:farmer_digital/screens/auth/launcher/laucher_screen.dart';

// Amplify configuration
import 'package:farmer_digital/helpers/configure_amplify.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureAmplify();
  runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) => AuthenticationBloc()),
        RepositoryProvider(
            create: (context) => LanguageCubit(LanguageInitial.initial())),
        RepositoryProvider(create: (context) => LoadingCubit()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget with WidgetsBindingObserver {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LanguageCubit, LanguageInitial>(
        builder: (context, state) {
      print(state.locale);
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Farmer Digital',
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: bgColor,
          canvasColor: secondaryColor,
        ),
        // locale: state.locale,
        supportedLocales: L10n.all,
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        home: const LauncherScreen(),
      );
    });
  }
}

class HexColor extends Color {
  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));

  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF' + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }
}
