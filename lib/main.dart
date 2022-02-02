import 'package:farmer_digital/localizations/app_localization.dart';
import 'package:farmer_digital/localizations/available_locales.dart';
import 'package:farmer_digital/screens/auth/authentication_bloc.dart';
import 'package:farmer_digital/widgets/language_widget/language_bloc.dart';
import 'package:farmer_digital/widgets/loader/loading_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:farmer_digital/constants.dart';

import 'package:farmer_digital/screens/auth/launcher/laucher_screen.dart';

// Amplify configuration
// import 'package:farmer_digital/helpers/configure_amplify.dart';

void main() => runApp(MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (_) => AuthenticationBloc()),
        RepositoryProvider(create: (_) => LanguageBloc()),
        RepositoryProvider(create: (_) => LoadingCubit()),
      ],
      child: const MyApp(),
    ));

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> with WidgetsBindingObserver {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LanguageBloc, LanguageState>(builder: (context, state) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Farmer Digital',
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: bgColor,
          canvasColor: secondaryColor,
        ),
        locale: state.locale,
        supportedLocales: AvailableLocales.all,
        localizationsDelegates: const [
          AppLocalization.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        home: const LauncherScreen(),
      );
    });
  }
}
