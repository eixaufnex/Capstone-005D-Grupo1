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

  /// `Enter`
  String get Enter {
    return Intl.message(
      'Enter',
      name: 'Enter',
      desc: '',
      args: [],
    );
  }

  /// `Don't have an account?`
  String get Dont_have_an_account {
    return Intl.message(
      'Don\'t have an account?',
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
