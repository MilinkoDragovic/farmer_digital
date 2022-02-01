part of 'language_bloc.dart';

class LanguageState extends Equatable {
  final Locale locale;
  const LanguageState({required this.locale});

  @override
  // ignore: todo
  // TODO: implement props
  List<Object> get props => [locale];
}
