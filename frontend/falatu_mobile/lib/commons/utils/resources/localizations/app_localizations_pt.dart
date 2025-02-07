import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get appName => 'FalaTu';

  @override
  String get appSubtitle => 'Converse com seus amigos de qualquer lugar';

  @override
  String get signIn => 'Entrar';

  @override
  String get email => 'E-mail';

  @override
  String get password => 'Senha';

  @override
  String get forgotPassword => 'Esqueceu a senha?';

  @override
  String get clickHere => 'Clique aqui';

  @override
  String get hasAccount => 'Ainda não tem conta?';

  @override
  String get invalidEmailOrPassword => 'Email ou senha inválido.';

  @override
  String get requiredField => 'Campo obrigatório.';

  @override
  String get invalidEmail => 'Email inválido.';
}
