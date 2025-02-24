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
  String get emailLabel => 'E-mail';

  @override
  String get passwordLabel => 'Senha';

  @override
  String get forgotPassword => 'Esqueceu a senha?';

  @override
  String get clickHere => 'Clique aqui';

  @override
  String get hasAccount => 'Ainda não tem conta?';

  @override
  String get invalidEmailOrPassword => 'Email ou senha inválido.';

  @override
  String get requiredFieldError => 'Campo obrigatório.';

  @override
  String get invalidEmailError => 'Email inválido.';

  @override
  String get clear => 'Limpar';

  @override
  String get register => 'Registre-se';

  @override
  String get registerSubtitle => 'Crie sua nova conta';

  @override
  String get fullNameLabel => 'Nome Completo';

  @override
  String get invalidNameError => 'Nome inválido';

  @override
  String get weekPasswordError => 'Senha muito fraca.';

  @override
  String get confirmPasswordLabel => 'Confirmar Senha';

  @override
  String get differentPasswordsError => 'As senhas são diferentes.';

  @override
  String get confirm => 'Confirmar';

  @override
  String get atLeastSixCharacters => 'Ao menos 6 caracteres.';

  @override
  String get shouldHaveAtLeastOneDigit => 'Deve conter pelo menos 1 número.';

  @override
  String get shouldHaveBothUpperAndLowerCaseLetters => 'Deve conter letras maiúsculas e minúsculas.';

  @override
  String get shouldHaveAtLeastOneSpecialCharacter => 'Deve conter ao menos 1 caractere especial.';

  @override
  String get fullNameMaxCharactersError => 'O nome não pode conter mais que 16 caracteres.';

  @override
  String get onUserCreationMessage => 'Usuário criado com sucesso.';

  @override
  String get emailAlreadyInUseMessage => 'Este E-mail já está sendo usado.';

  @override
  String get yesterday => 'ontem';

  @override
  String get audio => 'Àudio';

  @override
  String get image => 'Imagem';

  @override
  String get video => 'Vídeo';

  @override
  String get file => 'Arquivo';

  @override
  String get messages => 'Mensagens';

  @override
  String get loadChatsError => 'Não foi possível carregar os chats, tente novamente mais tarde.';

  @override
  String get friendsTab => 'Amigos';

  @override
  String get groupsTab => 'Grupos';

  @override
  String get emptyChatsMessage => 'Ainda nao existem chats aqui.';

  @override
  String get you => 'Você';
}
