part of 'sign_up_bloc.dart';

abstract class SignUpEvent {}

class RetrieveLostDataEvent extends SignUpEvent {}

class ValidateFieldsEvent extends SignUpEvent {
  GlobalKey<FormState> key;
  bool acceptTermsOfUse;

  ValidateFieldsEvent(this.key, {required this.acceptTermsOfUse});
}

class ToggleTermsOfUseCheckboxEvent extends SignUpEvent {
  bool termsOfUseAccepted;

  ToggleTermsOfUseCheckboxEvent({required this.termsOfUseAccepted});
}
