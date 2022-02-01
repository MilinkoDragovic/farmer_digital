part of 'authentication_bloc.dart';

enum AuthState {
  firstRun,
  authenticated,
  unauthenticated,
}

class AuthenticationState {
  final AuthState authState;
  final User? user;
  final String? message;

  const AuthenticationState._(
    this.authState, {
    this.user,
    this.message,
  });

  const AuthenticationState.unauthenticated({String? message})
      : this._(AuthState.unauthenticated,
            message: message ?? 'Unauthenticated');

  const AuthenticationState.onBoarding() : this._(AuthState.firstRun);

  const AuthenticationState.authenticated(User user)
      : this._(AuthState.authenticated, user: user);
}