import 'package:farmer_digital/constants.dart';
import 'package:farmer_digital/localizations/available_locales.dart';
import 'package:farmer_digital/widgets/language_widget/language_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OnBoardingBeginScreen extends StatefulWidget {
  final AnimationController animationController;

  const OnBoardingBeginScreen({Key? key, required this.animationController})
      : super(key: key);

  @override
  _OnBoardingBeginScreenState createState() => _OnBoardingBeginScreenState();
}

class _OnBoardingBeginScreenState extends State<OnBoardingBeginScreen> {
  @override
  Widget build(BuildContext context) {
    final _introductionanimation =
        Tween<Offset>(begin: const Offset(0, 0), end: const Offset(0.0, -1.0))
            .animate(CurvedAnimation(
      parent: widget.animationController,
      curve: const Interval(
        0.0,
        0.2,
        curve: Curves.fastOutSlowIn,
      ),
    ));

    return BlocProvider(
      create: (context) => LanguageBloc(),
      child: SlideTransition(
        position: _introductionanimation,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 60.0, bottom: 30.0),
                child: SizedBox(
                  width: 200.0,
                  child: Image.asset(
                    'assets/images/dark-logo.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Image.asset(
                  'assets/images/on-boarding-start-screen.png',
                  fit: BoxFit.cover,
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(
                  top: 20.0,
                  bottom: 10.0,
                ),
                child: Text(
                  "Welcome to Farmer Digital",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold,
                      color: Color(textColor)),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(
                  left: 20.0,
                  right: 20.0,
                ),
                child: Text(
                  "Welcome to the Farmer digital app. Please be free to go through on boarding steps.",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Color(textColor),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(
                  left: 20.0,
                  right: 20.0,
                  top: 10.0,
                ),
                child: Text(
                  "Choose your language or leave the default one.",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Color(textColor),
                  ),
                ),
              ),
              SizedBox(
                width: 200,
                height: 200,
                child: ListView.builder(
                    itemCount: AvailableLocales.all.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Directionality(
                        textDirection: TextDirection.rtl,
                        child: TextButton.icon(
                          onPressed: () {
                            context
                                .read<LanguageBloc>()
                                .add(ChangeLanguageEvent(
                                  locale: AvailableLocales.all[index],
                                ));
                          },
                          icon: Icon(
                            index == 0 ? Icons.check_outlined : null,
                            color: Colors.green,
                          ),
                          label: Text(
                            AvailableLocales.all[index].languageCode,
                          ),
                        ),
                      );
                    }),
              ),
              Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).padding.bottom + 16),
                child: InkWell(
                  onTap: () {
                    widget.animationController.animateTo(0.2);
                  },
                  child: Container(
                    height: 58,
                    padding: const EdgeInsets.only(
                      left: 56.0,
                      right: 56.0,
                      top: 16,
                      bottom: 16,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(38.0),
                      color: const Color(textColor),
                    ),
                    child: const Text(
                      "Let's begin",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
