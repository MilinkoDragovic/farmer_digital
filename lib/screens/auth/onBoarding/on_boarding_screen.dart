import 'package:farmer_digital/constants.dart';
import 'package:farmer_digital/screens/auth/authentication_bloc.dart';
import 'package:farmer_digital/screens/auth/onBoarding/on_boarding_cubit.dart';
import 'package:farmer_digital/screens/auth/welcome/welcome_screen.dart';
import 'package:farmer_digital/services/helpers.dart';
import 'package:farmer_digital/widgets/language_widget/language_selector.dart';
import 'package:farmer_digital/widgets/translate_text_widget/translate_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  PageController pageController = PageController();

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  final List<String> _titlesList = [
    'Select your language',
    'Register your account on farmer digital',
    'Check EEX Data',
    'Connect your account with Food Business Digital',
  ];

  final List<String> _subtitlesList = [
    'Choose language',
    'Create new account with personal E-mail address or connect with Gmail or AppleID',
    'Latest updated data for EEX',
    'Scan your QR Code from Food Business Digital to get all the modules',
  ];

  final List<dynamic> _imageList = [
    Icons.developer_mode,
    Icons.developer_mode,
    Icons.layers,
    Icons.account_circle,
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OnBoardingCubit(),
      child: Scaffold(
        backgroundColor: const Color(colorPrimary),
        body: BlocBuilder<OnBoardingCubit, OnBoardingInitial>(
            builder: (context, state) {
          return Stack(
            children: [
              PageView.builder(
                itemBuilder: (context, index) => getPage(
                  index,
                  _imageList[index],
                  _titlesList[index],
                  _subtitlesList[index],
                  context,
                ),
                controller: pageController,
                itemCount: _titlesList.length,
                onPageChanged: (int index) {
                  context.read<OnBoardingCubit>().onPageChanged(index);
                },
              ),
              Visibility(
                visible: state.currentPageCount + 1 == _titlesList.length,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Align(
                    alignment: Directionality.of(context) == TextDirection.ltr
                        ? Alignment.bottomRight
                        : Alignment.bottomLeft,
                    child:
                        BlocListener<AuthenticationBloc, AuthenticationState>(
                      listener: (context, state) {
                        if (state.authState == AuthState.unauthenticated) {
                          pushAndRemoveUntil(context, WelcomeScreen(), false);
                        }
                      },
                      child: OutlinedButton(
                        onPressed: () {
                          context
                              .read<AuthenticationBloc>()
                              .add(FinishedOnBoardingEvent());
                        },
                        child: const Text(
                          'Continue',
                          style: TextStyle(
                            fontSize: 14.0,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Colors.white),
                          shape: const StadiumBorder(),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 50.0),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: SmoothPageIndicator(
                    controller: pageController,
                    count: _titlesList.length,
                    effect: ScrollingDotsEffect(
                      activeDotColor: Colors.white,
                      dotColor: Colors.grey.shade400,
                      dotHeight: 8,
                      dotWidth: 8,
                      fixedCenter: true,
                    ),
                  ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }

  Widget getPage(int index, dynamic image, String title, String subtitle,
      BuildContext context) {
    return index == 0
        ? const LanguageSelector()
        : Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              image is String
                  ? Image.asset(
                      image,
                      width: 150,
                      height: 150,
                      fit: BoxFit.cover,
                    )
                  : Icon(
                      image as IconData,
                      color: Colors.white,
                      size: 150,
                    ),
              const SizedBox(
                height: 40,
              ),
              TranslateText('onBoardingTitle$index'),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  subtitle,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14.0,
                  ),
                  textAlign: TextAlign.center,
                ),
              )
            ],
          );
  }
}
