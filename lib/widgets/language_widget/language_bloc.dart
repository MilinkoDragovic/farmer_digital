import 'dart:ui';
import 'package:bloc/bloc.dart';

part 'language_state.dart';

class LanguageCubit extends Cubit<LanguageInitial> {
  LanguageCubit(LanguageState initialState) : super(LanguageInitial.initial());

  changeLanguageEvent(Locale locale) {
    emit(LanguageInitial(locale));
  }
}
