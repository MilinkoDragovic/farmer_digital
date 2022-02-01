part of 'language_bloc.dart';

abstract class LanguageEvent {}

abstract class AuthenticationEvent {}

class ChangeLanguageEvent extends LanguageEvent {
  Locale locale;

  ChangeLanguageEvent({required this.locale});
}
