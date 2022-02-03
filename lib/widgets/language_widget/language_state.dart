part of 'language_bloc.dart';

abstract class LanguageState {}

class LanguageInitial extends LanguageState {
  final Locale locale;

  LanguageInitial(this.locale);

  factory LanguageInitial.initial() => LanguageInitial(const Locale('de', ''));
}
