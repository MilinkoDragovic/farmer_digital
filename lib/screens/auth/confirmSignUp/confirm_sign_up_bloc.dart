import 'package:bloc/bloc.dart';
import 'package:farmer_digital/services/authentication.dart';
import 'package:flutter/material.dart';

part 'confirm_sign_up_event.dart';
part 'confirm_sign_up_state.dart';

class ConfirmSignUpBloc extends Bloc<ConfirmSignUpEvent, ConfirmSignUpState> {
  ConfirmSignUpBloc() : super(ConfirmSignUpInitial()) {
    on<ValidateConfirmSignUpFieldsEvent>((event, emit) {
      if (event.key.currentState?.validate() ?? false) {
        event.key.currentState!.save();
        emit(ValidConfirmSignUpField());
      } else {
        emit(ConfirmSignUpFailureState(
            errorMessage: 'Please fill code field to complete sign up.'));
      }
    });

    on<SendConfirmationCodeEvent>(
      (event, emit) async {
        dynamic result =
            await AmplifyUtils.resendConfirmationCode(event.emailAddress);

        emit(SentConfirmationCode());
      },
    );
  }
}
