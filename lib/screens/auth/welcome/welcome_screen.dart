import 'package:farmer_digital/constants.dart';
import 'package:farmer_digital/screens/auth/login/login_screen.dart';
import 'package:farmer_digital/screens/auth/signUp/signup_screen.dart';
import 'package:farmer_digital/services/helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'welcome_bloc.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<WelcomeBloc>(
      create: (context) => WelcomeBloc(),
      child: Builder(builder: (context) {
        return Scaffold(
          body: BlocListener<WelcomeBloc, WelcomeInitial>(
            listener: (context, state) {
              switch (state.pressTarget) {
                case WelcomePressTarget.login:
                  push(context, const LoginScreen());
                  break;
                case WelcomePressTarget.signup:
                  push(context, const SignUpScreen());
                  break;
                default:
                  break;
              }
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Center(
                  child: Image.asset(
                    'assets/images/logo.png',
                    width: 150.0,
                    height: 150.0,
                    fit: BoxFit.cover,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(
                    left: 16,
                    top: 32,
                    right: 16,
                    bottom: 8,
                  ),
                  child: Text(
                    'Say Hello for your new app!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(colorPrimary),
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 16,
                  ),
                  child: Text(
                    'You\'ve just saved a week of development and headaches.',
                    style: TextStyle(fontSize: 18),
                    textAlign: TextAlign.center,
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(right: 40.0, left: 40.0, top: 40.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: const Color(colorPrimary),
                      textStyle: const TextStyle(color: Colors.white),
                      padding: const EdgeInsets.only(top: 12, bottom: 20),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        side: const BorderSide(
                          color: Color(colorPrimary),
                        ),
                      ),
                    ),
                    child: const Text(
                      'Log In',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onPressed: () {
                      context.read<WelcomeBloc>().add(LoginPressed());
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    right: 40.0,
                    left: 40.0,
                    top: 20,
                    bottom: 20,
                  ),
                  child: TextButton(
                    child: const Text(
                      'Sign Up',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(colorPrimary),
                      ),
                    ),
                    onPressed: () {
                      context.read<WelcomeBloc>().add(SignupPressed());
                    },
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                        const EdgeInsets.only(top: 12, bottom: 12),
                      ),
                      shape: MaterialStateProperty.all<OutlinedBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25.9),
                          side: const BorderSide(
                            color: Color(colorPrimary),
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      }),
    );
  }
}
