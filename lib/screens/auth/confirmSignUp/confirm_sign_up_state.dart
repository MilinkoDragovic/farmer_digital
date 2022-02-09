part of 'confirm_sign_up_bloc.dart';

abstract class ConfirmSignUpState {}

class ConfirmSignUpInitial extends ConfirmSignUpState {}

class ValidConfirmSignUpField extends ConfirmSignUpState {}

class SentConfirmationCode extends ConfirmSignUpState {}

class ConfirmSignUpFailureState extends ConfirmSignUpState {
  String errorMessage;

  ConfirmSignUpFailureState({required this.errorMessage});
}
