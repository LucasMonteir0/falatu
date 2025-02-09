import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

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
  /// **'Confirm'**
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
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['pt'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'pt': return AppLocalizationsPt();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
