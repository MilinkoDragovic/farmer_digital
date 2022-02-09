part of 'authentication_bloc.dart';

enum AuthState {
  firstRun,
  authenticated,
  noConfirmed,
  confirmed,
  unauthenticated,
}

class AuthenticationState {
  final AuthState authState;
  final User? user;
  final String? message;
  final String? email;
  final String? password;
  final bool? isSignedIn;

  const AuthenticationState._(this.authState,
      {this.user, this.message, this.email, this.password, this.isSignedIn});

  const AuthenticationState.unauthenticated({String? message})
      : this._(AuthState.unauthenticated,
            message: message ?? 'Unauthenticated');

  const AuthenticationState.onBoarding() : this._(AuthState.firstRun);

  const AuthenticationState.authenticated(bool isSignedIn)
      : this._(AuthState.authenticated, isSignedIn: isSignedIn);

  const AuthenticationState.confirmed({String? message})
      : this._(AuthState.confirmed, message: message ?? 'SignUpComplete');

  const AuthenticationState.noConfirmed({
    String? message,
    String? email,
    String? password,
  }) : this._(
          AuthState.noConfirmed,
          message: message ?? 'noConfirmed',
          email: email,
          password: password,
        );
}
