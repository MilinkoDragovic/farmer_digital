import 'dart:async';
import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'language_event.dart';
part 'language_state.dart';

class LanguageBloc extends Bloc<LanguageEvent, LanguageState> {
  LanguageBloc() : super(const LanguageState(locale: Locale('de', 'DE'))) {
    on<ChangeLanguageEvent>((event, emit) async {
      emit(LanguageState(locale: event.locale));
    });
  }
}
