// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Log In`
  String get Log_In {
    return Intl.message(
      'Log In',
      name: 'Log_In',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get Email {
    return Intl.message(
      'Email',
      name: 'Email',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get Password {
    return Intl.message(
      'Password',
      name: 'Password',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Password`
  String get confirmPassword {
    return Intl.message(
      'Confirm Password',
      name: 'confirmPassword',
      desc: '',
      args: [],
    );
  }

  /// `Enter`
  String get Enter {
    return Intl.message(
      'Enter',
      name: 'Enter',
      desc: '',
      args: [],
    );
  }

  /// `¿Don't have an account?`
  String get Dont_have_an_account {
    return Intl.message(
      '¿Don\'t have an account?',
      name: 'Dont_have_an_account',
      desc: '',
      args: [],
    );
  }

  /// ` Sing Up`
  String get Sing_Up {
    return Intl.message(
      ' Sing Up',
      name: 'Sing_Up',
      desc: '',
      args: [],
    );
  }

  /// `Or log in with Google`
  String get Or_log_in_with_Google {
    return Intl.message(
      'Or log in with Google',
      name: 'Or_log_in_with_Google',
      desc: '',
      args: [],
    );
  }

  /// `Email@gmail.com`
  String get emailsample {
    return Intl.message(
      'Email@gmail.com',
      name: 'emailsample',
      desc: '',
      args: [],
    );
  }

  /// `Complete the fields for a better user experience`
  String get datos_google {
    return Intl.message(
      'Complete the fields for a better user experience',
      name: 'datos_google',
      desc: '',
      args: [],
    );
  }

  /// `username`
  String get label_username {
    return Intl.message(
      'username',
      name: 'label_username',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get label_name {
    return Intl.message(
      'Name',
      name: 'label_name',
      desc: '',
      args: [],
    );
  }

  /// `Last name`
  String get label_lastname {
    return Intl.message(
      'Last name',
      name: 'label_lastname',
      desc: '',
      args: [],
    );
  }

  /// `Age`
  String get label_age {
    return Intl.message(
      'Age',
      name: 'label_age',
      desc: '',
      args: [],
    );
  }

  /// `Weight (kg)`
  String get label_weight {
    return Intl.message(
      'Weight (kg)',
      name: 'label_weight',
      desc: '',
      args: [],
    );
  }

  /// `Height (cm)`
  String get label_height {
    return Intl.message(
      'Height (cm)',
      name: 'label_height',
      desc: '',
      args: [],
    );
  }

  /// `Select your gender`
  String get label_gender {
    return Intl.message(
      'Select your gender',
      name: 'label_gender',
      desc: '',
      args: [],
    );
  }

  /// `Man`
  String get label_man {
    return Intl.message(
      'Man',
      name: 'label_man',
      desc: '',
      args: [],
    );
  }

  /// `Woman`
  String get label_woman {
    return Intl.message(
      'Woman',
      name: 'label_woman',
      desc: '',
      args: [],
    );
  }

  /// `Intensity level`
  String get label_intensity {
    return Intl.message(
      'Intensity level',
      name: 'label_intensity',
      desc: '',
      args: [],
    );
  }

  /// `Beginner`
  String get label_intensity1 {
    return Intl.message(
      'Beginner',
      name: 'label_intensity1',
      desc: '',
      args: [],
    );
  }

  /// `Medium`
  String get label_intensity2 {
    return Intl.message(
      'Medium',
      name: 'label_intensity2',
      desc: '',
      args: [],
    );
  }

  /// `Advanced`
  String get label_intensity3 {
    return Intl.message(
      'Advanced',
      name: 'label_intensity3',
      desc: '',
      args: [],
    );
  }

  /// `Save and continue`
  String get save {
    return Intl.message(
      'Save and continue',
      name: 'save',
      desc: '',
      args: [],
    );
  }

  /// `Empty fields`
  String get login1 {
    return Intl.message(
      'Empty fields',
      name: 'login1',
      desc: '',
      args: [],
    );
  }

  /// `Please complete all fields`
  String get login2 {
    return Intl.message(
      'Please complete all fields',
      name: 'login2',
      desc: '',
      args: [],
    );
  }

  /// `Try again!`
  String get tryagain {
    return Intl.message(
      'Try again!',
      name: 'tryagain',
      desc: '',
      args: [],
    );
  }

  /// `Incorrect email or password.`
  String get tryagain2 {
    return Intl.message(
      'Incorrect email or password.',
      name: 'tryagain2',
      desc: '',
      args: [],
    );
  }

  /// `Login canceled`
  String get cancel {
    return Intl.message(
      'Login canceled',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `The user canceled the login.`
  String get cancel2 {
    return Intl.message(
      'The user canceled the login.',
      name: 'cancel2',
      desc: '',
      args: [],
    );
  }

  /// `The user ID could not be obtained.`
  String get error1 {
    return Intl.message(
      'The user ID could not be obtained.',
      name: 'error1',
      desc: '',
      args: [],
    );
  }

  /// `Authentication error`
  String get error2 {
    return Intl.message(
      'Authentication error',
      name: 'error2',
      desc: '',
      args: [],
    );
  }

  /// `An error occurred while logging in with Google.`
  String get error3 {
    return Intl.message(
      'An error occurred while logging in with Google.',
      name: 'error3',
      desc: '',
      args: [],
    );
  }

  /// `Error logging in with Google. Please try again.`
  String get error4 {
    return Intl.message(
      'Error logging in with Google. Please try again.',
      name: 'error4',
      desc: '',
      args: [],
    );
  }

  /// `Accept`
  String get aceptar {
    return Intl.message(
      'Accept',
      name: 'aceptar',
      desc: '',
      args: [],
    );
  }

  /// `  Minimum 6 characters`
  String get min6 {
    return Intl.message(
      '  Minimum 6 characters',
      name: 'min6',
      desc: '',
      args: [],
    );
  }

  /// `  Enter a valid email address`
  String get valid_email {
    return Intl.message(
      '  Enter a valid email address',
      name: 'valid_email',
      desc: '',
      args: [],
    );
  }

  /// `  The value entered is not an email`
  String get no_correo {
    return Intl.message(
      '  The value entered is not an email',
      name: 'no_correo',
      desc: '',
      args: [],
    );
  }

  /// `  Enter a user name`
  String get nombreusuario {
    return Intl.message(
      '  Enter a user name',
      name: 'nombreusuario',
      desc: '',
      args: [],
    );
  }

  /// `Continue`
  String get continue_register {
    return Intl.message(
      'Continue',
      name: 'continue_register',
      desc: '',
      args: [],
    );
  }

  /// `Passwords do not match.`
  String get passwordmatch {
    return Intl.message(
      'Passwords do not match.',
      name: 'passwordmatch',
      desc: '',
      args: [],
    );
  }

  /// `The email is not valid.`
  String get emailvalid {
    return Intl.message(
      'The email is not valid.',
      name: 'emailvalid',
      desc: '',
      args: [],
    );
  }

  /// `The email is already in use.`
  String get emailused {
    return Intl.message(
      'The email is already in use.',
      name: 'emailused',
      desc: '',
      args: [],
    );
  }

  /// `¿Do you already have an account?`
  String get yatienescuenta {
    return Intl.message(
      '¿Do you already have an account?',
      name: 'yatienescuenta',
      desc: '',
      args: [],
    );
  }

  /// `Close`
  String get cerrar {
    return Intl.message(
      'Close',
      name: 'cerrar',
      desc: '',
      args: [],
    );
  }

  /// `Loading...`
  String get loading {
    return Intl.message(
      'Loading...',
      name: 'loading',
      desc: '',
      args: [],
    );
  }

  /// `Give it all you've got!`
  String get home1 {
    return Intl.message(
      'Give it all you\'ve got!',
      name: 'home1',
      desc: '',
      args: [],
    );
  }

  /// `Thank you very much for sharing with us how you feel.`
  String get thanksuser {
    return Intl.message(
      'Thank you very much for sharing with us how you feel.',
      name: 'thanksuser',
      desc: '',
      args: [],
    );
  }

  /// `List of exercises`
  String get listaejercicio1 {
    return Intl.message(
      'List of exercises',
      name: 'listaejercicio1',
      desc: '',
      args: [],
    );
  }

  /// `Achievements`
  String get logros1 {
    return Intl.message(
      'Achievements',
      name: 'logros1',
      desc: '',
      args: [],
    );
  }

  /// `Objectives`
  String get objetivos1 {
    return Intl.message(
      'Objectives',
      name: 'objetivos1',
      desc: '',
      args: [],
    );
  }

  /// `Glossary`
  String get glosario1 {
    return Intl.message(
      'Glossary',
      name: 'glosario1',
      desc: '',
      args: [],
    );
  }

  /// `Sign out`
  String get cerrarsesion {
    return Intl.message(
      'Sign out',
      name: 'cerrarsesion',
      desc: '',
      args: [],
    );
  }

  /// `¡Hello,`
  String get hola {
    return Intl.message(
      '¡Hello,',
      name: 'hola',
      desc: '',
      args: [],
    );
  }

  /// `¿How are you feeling today?`
  String get comotesientes {
    return Intl.message(
      '¿How are you feeling today?',
      name: 'comotesientes',
      desc: '',
      args: [],
    );
  }

  /// `Sad`
  String get triste {
    return Intl.message(
      'Sad',
      name: 'triste',
      desc: '',
      args: [],
    );
  }

  /// `Normal`
  String get normal {
    return Intl.message(
      'Normal',
      name: 'normal',
      desc: '',
      args: [],
    );
  }

  /// `Good`
  String get bien {
    return Intl.message(
      'Good',
      name: 'bien',
      desc: '',
      args: [],
    );
  }

  /// `Super Good`
  String get Superbien {
    return Intl.message(
      'Super Good',
      name: 'Superbien',
      desc: '',
      args: [],
    );
  }

  /// `Recommended`
  String get recomendado {
    return Intl.message(
      'Recommended',
      name: 'recomendado',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get home {
    return Intl.message(
      'Home',
      name: 'home',
      desc: '',
      args: [],
    );
  }

  /// `Routines`
  String get rutina {
    return Intl.message(
      'Routines',
      name: 'rutina',
      desc: '',
      args: [],
    );
  }

  /// `Progress`
  String get Progreso {
    return Intl.message(
      'Progress',
      name: 'Progreso',
      desc: '',
      args: [],
    );
  }

  /// `Profile`
  String get perfil {
    return Intl.message(
      'Profile',
      name: 'perfil',
      desc: '',
      args: [],
    );
  }

  /// `Level`
  String get nivel {
    return Intl.message(
      'Level',
      name: 'nivel',
      desc: '',
      args: [],
    );
  }

  /// `Strength Routine`
  String get rutinafuerza1 {
    return Intl.message(
      'Strength Routine',
      name: 'rutinafuerza1',
      desc: '',
      args: [],
    );
  }

  /// `Cardio Routine`
  String get rutinacardio1 {
    return Intl.message(
      'Cardio Routine',
      name: 'rutinacardio1',
      desc: '',
      args: [],
    );
  }

  /// `Flexibility Routine`
  String get rutinaflexibilidad1 {
    return Intl.message(
      'Flexibility Routine',
      name: 'rutinaflexibilidad1',
      desc: '',
      args: [],
    );
  }

  /// `Exercises`
  String get ejercicios {
    return Intl.message(
      'Exercises',
      name: 'ejercicios',
      desc: '',
      args: [],
    );
  }

  /// `Apply`
  String get apply {
    return Intl.message(
      'Apply',
      name: 'apply',
      desc: '',
      args: [],
    );
  }

  /// `Change Language`
  String get change_language {
    return Intl.message(
      'Change Language',
      name: 'change_language',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'es'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
