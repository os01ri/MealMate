part of 'language_cubit.dart';

class LanguageState {
  final Locale? locale;
  const LanguageState({this.locale});

  LanguageState copyWith({
    Locale? locale,
  }) {
    return LanguageState(
      locale: locale ?? this.locale,
    );
  }
}
