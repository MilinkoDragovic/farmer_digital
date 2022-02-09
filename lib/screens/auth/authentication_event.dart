part of 'authentication_bloc.dart';

abstract class AuthenticationEvent {}

class FinishedOnBoardingEvent extends AuthenticationEvent {}

class CheckFirstRunEvent extends AuthenticationEvent {}

class LoginWithEmailAndPasswordEvent extends AuthenticationEvent {
  String email;
  String password;

  LoginWithEmailAndPasswordEvent({
    required this.email,
    required this.password,
  });
}

class ConfirmSignUpCodeEvent extends AuthenticationEvent {
  String email;
  String code;

  ConfirmSignUpCodeEvent({
    required this.email,
    required this.code,
  });
}

class SignupWithEmailAndPasswordEvent extends AuthenticationEvent {
  String emailAddress;
  String password;
  String mobileNumber;
  String firstName;
  String lastName;

  SignupWithEmailAndPasswordEvent({
    required this.emailAddress,
    required this.password,
    required this.mobileNumber,
    required this.firstName,
    required this.lastName,
  });
}

class LogoutEvent extends AuthenticationEvent {
  LogoutEvent();
}
