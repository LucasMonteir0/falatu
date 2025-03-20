import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_pt.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'localizations/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('pt')
  ];

  /// No description provided for @appName.
  ///
  /// In pt, this message translates to:
  /// **'FalaTu'**
  String get appName;

  /// No description provided for @appSubtitle.
  ///
  /// In pt, this message translates to:
  /// **'Converse com seus amigos de qualquer lugar'**
  String get appSubtitle;

  /// No description provided for @signIn.
  ///
  /// In pt, this message translates to:
  /// **'Entrar'**
  String get signIn;

  /// No description provided for @emailLabel.
  ///
  /// In pt, this message translates to:
  /// **'E-mail'**
  String get emailLabel;

  /// No description provided for @passwordLabel.
  ///
  /// In pt, this message translates to:
  /// **'Senha'**
  String get passwordLabel;

  /// No description provided for @forgotPassword.
  ///
  /// In pt, this message translates to:
  /// **'Esqueceu a senha?'**
  String get forgotPassword;

  /// No description provided for @clickHere.
  ///
  /// In pt, this message translates to:
  /// **'Clique aqui'**
  String get clickHere;

  /// No description provided for @hasAccount.
  ///
  /// In pt, this message translates to:
  /// **'Ainda não tem conta?'**
  String get hasAccount;

  /// No description provided for @invalidEmailOrPassword.
  ///
  /// In pt, this message translates to:
  /// **'Email ou senha inválido.'**
  String get invalidEmailOrPassword;

  /// No description provided for @requiredFieldError.
  ///
  /// In pt, this message translates to:
  /// **'Campo obrigatório.'**
  String get requiredFieldError;

  /// No description provided for @invalidEmailError.
  ///
  /// In pt, this message translates to:
  /// **'Email inválido.'**
  String get invalidEmailError;

  /// No description provided for @clear.
  ///
  /// In pt, this message translates to:
  /// **'Limpar'**
  String get clear;

  /// No description provided for @register.
  ///
  /// In pt, this message translates to:
  /// **'Registre-se'**
  String get register;

  /// No description provided for @registerSubtitle.
  ///
  /// In pt, this message translates to:
  /// **'Crie sua nova conta'**
  String get registerSubtitle;

  /// No description provided for @fullNameLabel.
  ///
  /// In pt, this message translates to:
  /// **'Nome Completo'**
  String get fullNameLabel;

  /// No description provided for @invalidNameError.
  ///
  /// In pt, this message translates to:
  /// **'Nome inválido'**
  String get invalidNameError;

  /// No description provided for @weekPasswordError.
  ///
  /// In pt, this message translates to:
  /// **'Senha muito fraca.'**
  String get weekPasswordError;

  /// No description provided for @confirmPasswordLabel.
  ///
  /// In pt, this message translates to:
  /// **'Confirmar Senha'**
  String get confirmPasswordLabel;

  /// No description provided for @differentPasswordsError.
  ///
  /// In pt, this message translates to:
  /// **'As senhas são diferentes.'**
  String get differentPasswordsError;

  /// No description provided for @confirm.
  ///
  /// In pt, this message translates to:
  /// **'Confirmar'**
  String get confirm;

  /// No description provided for @atLeastSixCharacters.
  ///
  /// In pt, this message translates to:
  /// **'Ao menos 6 caracteres.'**
  String get atLeastSixCharacters;

  /// No description provided for @shouldHaveAtLeastOneDigit.
  ///
  /// In pt, this message translates to:
  /// **'Deve conter pelo menos 1 número.'**
  String get shouldHaveAtLeastOneDigit;

  /// No description provided for @shouldHaveBothUpperAndLowerCaseLetters.
  ///
  /// In pt, this message translates to:
  /// **'Deve conter letras maiúsculas e minúsculas.'**
  String get shouldHaveBothUpperAndLowerCaseLetters;

  /// No description provided for @shouldHaveAtLeastOneSpecialCharacter.
  ///
  /// In pt, this message translates to:
  /// **'Deve conter ao menos 1 caractere especial.'**
  String get shouldHaveAtLeastOneSpecialCharacter;

  /// No description provided for @fullNameMaxCharactersError.
  ///
  /// In pt, this message translates to:
  /// **'O nome não pode conter mais que 16 caracteres.'**
  String get fullNameMaxCharactersError;

  /// No description provided for @onUserCreationMessage.
  ///
  /// In pt, this message translates to:
  /// **'Usuário criado com sucesso.'**
  String get onUserCreationMessage;

  /// No description provided for @emailAlreadyInUseMessage.
  ///
  /// In pt, this message translates to:
  /// **'Este E-mail já está sendo usado.'**
  String get emailAlreadyInUseMessage;

  /// No description provided for @yesterday.
  ///
  /// In pt, this message translates to:
  /// **'ontem'**
  String get yesterday;

  /// No description provided for @today.
  ///
  /// In pt, this message translates to:
  /// **'hoje'**
  String get today;

  /// No description provided for @audio.
  ///
  /// In pt, this message translates to:
  /// **'Àudio'**
  String get audio;

  /// No description provided for @image.
  ///
  /// In pt, this message translates to:
  /// **'Imagem'**
  String get image;

  /// No description provided for @video.
  ///
  /// In pt, this message translates to:
  /// **'Vídeo'**
  String get video;

  /// No description provided for @file.
  ///
  /// In pt, this message translates to:
  /// **'Arquivo'**
  String get file;

  /// No description provided for @messages.
  ///
  /// In pt, this message translates to:
  /// **'Mensagens'**
  String get messages;

  /// No description provided for @loadChatsError.
  ///
  /// In pt, this message translates to:
  /// **'Não foi possível carregar os chats, tente novamente mais tarde.'**
  String get loadChatsError;

  /// No description provided for @friendsTab.
  ///
  /// In pt, this message translates to:
  /// **'Amigos'**
  String get friendsTab;

  /// No description provided for @groupsTab.
  ///
  /// In pt, this message translates to:
  /// **'Grupos'**
  String get groupsTab;

  /// No description provided for @emptyChatsMessage.
  ///
  /// In pt, this message translates to:
  /// **'Ainda nao existem chats aqui.'**
  String get emptyChatsMessage;

  /// No description provided for @you.
  ///
  /// In pt, this message translates to:
  /// **'Você'**
  String get you;

  /// No description provided for @writeYourMessage.
  ///
  /// In pt, this message translates to:
  /// **'Escreva sua mensagem...'**
  String get writeYourMessage;

  /// No description provided for @nonFriendsPageTitle.
  ///
  /// In pt, this message translates to:
  /// **'Inicie uma conversa'**
  String get nonFriendsPageTitle;

  /// No description provided for @startConversation.
  ///
  /// In pt, this message translates to:
  /// **'Iniciar conversa'**
  String get startConversation;

  /// No description provided for @portuguese.
  ///
  /// In pt, this message translates to:
  /// **'Português'**
  String get portuguese;

  /// No description provided for @english.
  ///
  /// In pt, this message translates to:
  /// **'Inglês'**
  String get english;

  /// No description provided for @chooseTheme.
  ///
  /// In pt, this message translates to:
  /// **'Escolha o tema'**
  String get chooseTheme;

  /// No description provided for @selectLanguage.
  ///
  /// In pt, this message translates to:
  /// **'Selecionar idioma'**
  String get selectLanguage;

  /// No description provided for @signOut.
  ///
  /// In pt, this message translates to:
  /// **'Sair da conta'**
  String get signOut;

  /// No description provided for @welcomeText.
  ///
  /// In pt, this message translates to:
  /// **'Olá, seja bem-vindo ao FalaTu! Antes de começar, vamos personalizar sua experiência configurando algumas preferências.'**
  String get welcomeText;

  /// No description provided for @continueLabel.
  ///
  /// In pt, this message translates to:
  /// **'Prosseguir'**
  String get continueLabel;

  /// No description provided for @settings.
  ///
  /// In pt, this message translates to:
  /// **'Configurações'**
  String get settings;

  /// No description provided for @gallery.
  ///
  /// In pt, this message translates to:
  /// **'Galeria'**
  String get gallery;

  /// No description provided for @camera.
  ///
  /// In pt, this message translates to:
  /// **'Câmera'**
  String get camera;

  /// No description provided for @files.
  ///
  /// In pt, this message translates to:
  /// **'Arquivos'**
  String get files;

  /// No description provided for @photos.
  ///
  /// In pt, this message translates to:
  /// **'Fotos'**
  String get photos;

  /// No description provided for @videos.
  ///
  /// In pt, this message translates to:
  /// **'Vídeos'**
  String get videos;

  /// No description provided for @photo.
  ///
  /// In pt, this message translates to:
  /// **'Foto'**
  String get photo;

  /// No description provided for @cancel.
  ///
  /// In pt, this message translates to:
  /// **'Cancelar'**
  String get cancel;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'pt'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return AppLocalizationsEn();
    case 'pt': return AppLocalizationsPt();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
