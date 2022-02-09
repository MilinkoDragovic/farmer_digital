part of 'confirm_sign_up_bloc.dart';

abstract class ConfirmSignUpEvent {}

class SendConfirmationCodeEvent extends ConfirmSignUpEvent {
  String emailAddress;

  SendConfirmationCodeEvent({
    required this.emailAddress,
  });
}

class ValidateConfirmSignUpFieldsEvent extends ConfirmSignUpEvent {
  GlobalKey<FormState> key;

  ValidateConfirmSignUpFieldsEvent(this.key);
}
