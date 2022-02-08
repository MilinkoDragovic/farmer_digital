part of 'sign_up_bloc.dart';

abstract class SignUpState {}

class SignUpInitial extends SignUpState {}

class ValidFields extends SignUpState {}

class SignUpFailureState extends SignUpState {
  String errorMessage;

  SignUpFailureState({required this.errorMessage});
}

class TermsOfUseToggleState extends SignUpState {
  bool termsOfUseAccepted;

  TermsOfUseToggleState(this.termsOfUseAccepted);
}
