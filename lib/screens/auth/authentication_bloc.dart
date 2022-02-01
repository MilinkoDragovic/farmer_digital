import 'dart:io';

import 'package:amplify_flutter/amplify.dart';
import 'package:bloc/bloc.dart';
import 'package:farmer_digital/constants.dart';
import 'package:farmer_digital/models/user.dart';
import 'package:farmer_digital/services/authentication.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  User? user;

  // Wraps platform-specific persistent storage for simple data (NSUserDefaults on iOS and macOS, SharedPreferences on Android, etc.). Data may be persisted to disk asynchronously, and there is no guarantee that writes will be persisted to disk after returning, so this plugin must not be used for storing critical data.
  late SharedPreferences prefs;

  late bool finishedOnBoarding;

  AuthenticationBloc({this.user})
      : super(const AuthenticationState.unauthenticated()) {
    on<CheckFirstRunEvent>((event, emit) async {
      prefs = await SharedPreferences.getInstance();
      finishedOnBoarding = prefs.getBool(FINISHED_ON_BOARDING) ?? false;

      if (!finishedOnBoarding) {
        emit(const AuthenticationState.onBoarding());
      } else {
        user = (await Amplify.Auth.fetchUserAttributes()) as User?;

        if (user == null) {
          emit(const AuthenticationState.unauthenticated());
        } else {
          emit(AuthenticationState.authenticated(user!));
        }
      }
    });
    on<FinishedOnBoardingEvent>((event, emit) async {
      await prefs.setBool(FINISHED_ON_BOARDING, true);
      emit(const AuthenticationState.unauthenticated());
    });
    on<LoginWithEmailAndPasswordEvent>((event, emit) async {
      dynamic result = await AmplifyUtils.loginWithEmailAndPassword(
        event.email,
        event.password,
      );

      if (result != null && result is User) {
        user = result;
        emit(AuthenticationState.authenticated(user!));
      } else if (result != null && result is String) {
        emit(AuthenticationState.unauthenticated(message: result));
      } else {
        emit(
          const AuthenticationState.unauthenticated(
              message: 'Login failed. Please try again.'),
        );
      }
    });
    on<SignupWithEmailAndPasswordEvent>((event, emit) async {
      dynamic result = await AmplifyUtils.signUpWithEmailAndPassword(
        emailAddress: event.emailAddress,
        password: event.password,
        firstName: event.firstName,
        lastName: event.lastName,
        mobileNumber: event.mobileNumber,
      );

      if (result != null && result is User) {
        user = result;
        emit(AuthenticationState.authenticated(user!));
      } else if (result != null && result is String) {
        emit(AuthenticationState.unauthenticated(message: result));
      } else {
        emit(const AuthenticationState.unauthenticated(
            message: 'Couldn\'t sign up'));
      }
    });
    on<LogoutEvent>((event, emit) async {
      await Amplify.Auth.signOut();
      user = null;
      emit(const AuthenticationState.unauthenticated());
    });
  }
}
