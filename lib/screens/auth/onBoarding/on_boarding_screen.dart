import 'package:farmer_digital/constants.dart';
import 'package:farmer_digital/screens/auth/authentication_bloc.dart';
import 'package:farmer_digital/screens/auth/onBoarding/on_boarding_cubit.dart';
import 'package:farmer_digital/screens/auth/onBoarding/parts/center_next_button.dart';
import 'package:farmer_digital/screens/auth/onBoarding/parts/on_boarding_auth_screen.dart';
import 'package:farmer_digital/screens/auth/onBoarding/parts/on_boarding_begin_screen.dart';
import 'package:farmer_digital/screens/auth/onBoarding/parts/on_boarding_eex_screen.dart';
import 'package:farmer_digital/screens/auth/onBoarding/parts/top_back_skip_button.dart';
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

class _OnBoardingScreenState extends State<OnBoardingScreen>
    with TickerProviderStateMixin {
  PageController pageController = PageController();
  AnimationController? _animationController;

  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 8));
    _animationController?.animateTo(0.0);
    super.initState();
  }

  @override
  void dispose() {
    _animationController?.dispose();
    pageController.dispose();
    super.dispose();
  }

  final List<String> _titlesList = [
    'Register your account on farmer digital',
    'Check EEX Data',
    'Connect your account with Food Business Digital',
  ];

  final List<String> _subtitlesList = [
    'Create new account with personal E-mail address or connect with Gmail or AppleID',
    'Latest updated data for EEX',
    'Scan your QR Code from Food Business Digital to get all the modules',
  ];

  final List<String> _imageList = [
    'assets/images/on-boarding-start-screen.png',
    'assets/images/on-boarding-start-screen.png',
    'assets/images/on-boarding-start-screen.png',
  ];

  void _onSkipClick() {
    _animationController?.animateTo(0.8,
        duration: Duration(milliseconds: 1200));
  }

  void _onBackClick() {
    if (_animationController!.value >= 0 &&
        _animationController!.value <= 0.2) {
      _animationController?.animateTo(0.0);
    } else if (_animationController!.value > 0.2 &&
        _animationController!.value <= 0.4) {
      _animationController?.animateTo(0.2);
    } else if (_animationController!.value > 0.4 &&
        _animationController!.value <= 0.6) {
      _animationController?.animateTo(0.4);
    } else if (_animationController!.value > 0.6 &&
        _animationController!.value <= 0.8) {
      _animationController?.animateTo(0.6);
    } else if (_animationController!.value > 0.8 &&
        _animationController!.value <= 1.0) {
      _animationController?.animateTo(0.8);
    }
  }

  void _onNextClick() {
    if (_animationController!.value >= 0 &&
        _animationController!.value <= 0.2) {
      _animationController?.animateTo(0.4);
    } else if (_animationController!.value > 0.2 &&
        _animationController!.value <= 0.4) {
      _animationController?.animateTo(0.6);
    } else if (_animationController!.value > 0.4 &&
        _animationController!.value <= 0.6) {
      _animationController?.animateTo(0.8);
    } else if (_animationController!.value > 0.6 &&
        _animationController!.value <= 0.8) {
      _signUpClick();
    }
  }

  void _signUpClick() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OnBoardingCubit(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: BlocBuilder<OnBoardingCubit, OnBoardingInitial>(
            builder: (context, state) {
          return Stack(
            children: [
              OnBoardingBeginScreen(animationController: _animationController!),
              OnBoardingAuthScreen(animationController: _animationController!),
              OnBoardingEexScreen(animationController: _animationController!),
              TopBackSkipView(
                onBackClick: _onBackClick,
                onSkipClick: _onSkipClick,
                animationController: _animationController!,
              ),
              CenterNextButton(
                animationController: _animationController!,
                onNextClick: _onNextClick,
              ),
              // Visibility(
              //   visible: state.currentPageCount + 1 == _titlesList.length,
              //   child: Padding(
              //     padding: const EdgeInsets.all(16.0),
              //     child: Align(
              //       alignment: Directionality.of(context) == TextDirection.ltr
              //           ? Alignment.bottomRight
              //           : Alignment.bottomLeft,
              //       child:
              //           BlocListener<AuthenticationBloc, AuthenticationState>(
              //         listener: (context, state) {
              //           if (state.authState == AuthState.unauthenticated) {
              //             pushAndRemoveUntil(context, WelcomeScreen(), false);
              //           }
              //         },
              //         child: OutlinedButton(
              //           onPressed: () {
              //             context
              //                 .read<AuthenticationBloc>()
              //                 .add(FinishedOnBoardingEvent());
              //           },
              //           child: const Text(
              //             'Continue',
              //             style: TextStyle(
              //               fontSize: 14.0,
              //               color: Colors.white,
              //               fontWeight: FontWeight.bold,
              //             ),
              //           ),
              //           style: OutlinedButton.styleFrom(
              //             side: const BorderSide(color: Colors.white),
              //             shape: const StadiumBorder(),
              //           ),
              //         ),
              //       ),
              //     ),
              //   ),
              // ),
              // Padding(
              //   padding: const EdgeInsets.only(bottom: 50.0),
              //   child: Align(
              //     alignment: Alignment.bottomCenter,
              //     child: SmoothPageIndicator(
              //       controller: pageController,
              //       count: 3,
              //       effect: ScrollingDotsEffect(
              //         activeDotColor: Colors.white,
              //         dotColor: Colors.grey.shade400,
              //         dotHeight: 8,
              //         dotWidth: 8,
              //         fixedCenter: true,
              //       ),
              //     ),
              //   ),
              // ),
            ],
          );
        }),
      ),
    );
  }
}
