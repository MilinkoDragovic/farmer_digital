import 'package:farmer_digital/constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
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
  var languages = ["English", "German"];
  String lang = "German";

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

    return BlocProvider<LanguageCubit>(
      create: (context) => LanguageCubit(LanguageInitial.initial()),
      child: Builder(builder: (context) {
        return SlideTransition(
          position: _introductionanimation,
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(
                        top: (MediaQuery.of(context).padding.top + 16),
                        bottom: 20.0,
                      ),
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Image.asset(
                          "assets/images/dark-logo.png",
                          height: 80,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 180,
                  width: MediaQuery.of(context).size.width,
                  child: Image.asset(
                    'assets/images/on_boarding_start_screen.png',
                    fit: BoxFit.fitHeight,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 20.0,
                    bottom: 10.0,
                    left: 20.0,
                    right: 20.0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Flexible(
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: AppLocalizations.of(context)!
                                    .welcomeTextPartOne,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              TextSpan(
                                text: AppLocalizations.of(context)!
                                    .welcomeTextPartTwo,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ],
                            style: const TextStyle(
                              fontSize: 30.0,
                              color: Color(textColor),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 20.0,
                    right: 20.0,
                    bottom: 20.0,
                  ),
                  child: Text(
                    AppLocalizations.of(context)!
                        .onBoardingBeginScreenDescription,
                    textAlign: TextAlign.start,
                    style: const TextStyle(
                      color: Color(textColor),
                      fontSize: 18.0,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 20.0,
                    right: 20.0,
                    bottom: 40.0,
                  ),
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: const Color(colorPrimary),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 30.0,
                        right: 30.0,
                        top: 5.0,
                        bottom: 5.0,
                      ),
                      child: DropdownButton(
                        value: lang,
                        icon: const Padding(
                          padding: EdgeInsets.only(left: 20.0),
                          child: Icon(Icons.keyboard_arrow_down_rounded),
                        ),
                        iconEnabledColor: Colors.white,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                        dropdownColor: const Color(colorPrimary),
                        underline: Container(),
                        isExpanded: true,
                        items: languages.map((String items) {
                          return DropdownMenuItem(
                            value: items,
                            child: Text(items),
                          );
                        }).toList(),
                        onChanged: (String? value) {
                          setState(() {
                            if (value == 'English') {
                              context
                                  .read<LanguageCubit>()
                                  .changeLanguageEvent(Locale('en', 'US'));
                            } else {
                              context
                                  .read<LanguageCubit>()
                                  .changeLanguageEvent(Locale('de'));
                            }

                            lang = value!;
                          });
                        },
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).padding.bottom,
                  ),
                  child: InkWell(
                    onTap: () {
                      widget.animationController.animateTo(0.2);
                    },
                    child: Align(
                      alignment: Alignment.center,
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.5,
                        height: 60,
                        padding: const EdgeInsets.only(
                          left: 50.0,
                          right: 50.0,
                          top: 15.0,
                          bottom: 15.0,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          color: const Color(colorPrimary),
                        ),
                        child: const Text(
                          "Let's begin",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
