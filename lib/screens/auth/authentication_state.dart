part of 'authentication_bloc.dart';

enum AuthState {
  firstRun,
  authenticated,
  noConfirmed,
  confirmed,
  unauthenticated,
  signedUp,
}

class AuthenticationState {
  final AuthState authState;
  final User? user;
  final String? message;
  final String? email;
  final String? password;
  final bool? isSignedIn;
  final bool? isSignedUp;

  const AuthenticationState._(this.authState,
      {this.user,
      this.message,
      this.email,
      this.password,
      this.isSignedIn,
      this.isSignedUp});

  const AuthenticationState.unauthenticated({String? message})
      : this._(AuthState.unauthenticated,
            message: message ?? 'Unauthenticated');

  const AuthenticationState.onBoarding() : this._(AuthState.firstRun);

  const AuthenticationState.authenticated(bool isSignedIn)
      : this._(AuthState.authenticated, isSignedIn: isSignedIn);

  const AuthenticationState.confirmed({String? message})
      : this._(AuthState.confirmed, message: message ?? 'SignUpComplete');

  const AuthenticationState.signedUp({
    bool? isSignedUp,
    String? email,
    String? password,
  }) : this._(
          AuthState.signedUp,
          isSignedUp: isSignedUp,
          email: email,
          password: password,
        );

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
