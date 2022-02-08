import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'sign_up_state.dart';
part 'sign_up_event.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc() : super(SignUpInitial()) {
    on<ValidateFieldsEvent>((event, emit) async {
      if (event.key.currentState?.validate() ?? false) {
        if (event.acceptTermsOfUse) {
          event.key.currentState!.save();
          emit(ValidFields());
        } else {
          emit(SignUpFailureState(
              errorMessage: 'Please accept our terms of use.'));
        }
      } else {
        emit(SignUpFailureState(
            errorMessage: 'Please fill required fields. You stupid woman!'));
      }
    });
    on<ToggleTermsOfUseCheckboxEvent>(
        (event, emit) => emit(TermsOfUseToggleState(event.termsOfUseAccepted)));
  }
}
