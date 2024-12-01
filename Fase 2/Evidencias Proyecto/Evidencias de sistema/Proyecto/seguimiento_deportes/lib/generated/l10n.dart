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

  /// `intermediate`
  String get intermedio {
    return Intl.message(
      'intermediate',
      name: 'intermedio',
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

  /// `Log out`
  String get cerrarsesion {
    return Intl.message(
      'Log out',
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

  /// `1RM (One Repetition Maximum)`
  String get oneRM_One_Repetition_Maximum {
    return Intl.message(
      '1RM (One Repetition Maximum)',
      name: 'oneRM_One_Repetition_Maximum',
      desc: '',
      args: [],
    );
  }

  /// `Grip`
  String get Grip {
    return Intl.message(
      'Grip',
      name: 'Grip',
      desc: '',
      args: [],
    );
  }

  /// `Aerobic`
  String get Aerobic {
    return Intl.message(
      'Aerobic',
      name: 'Aerobic',
      desc: '',
      args: [],
    );
  }

  /// `Isolation`
  String get Isolation {
    return Intl.message(
      'Isolation',
      name: 'Isolation',
      desc: '',
      args: [],
    );
  }

  /// `Range of Motion (ROM)`
  String get Range_of_Motion_ROM {
    return Intl.message(
      'Range of Motion (ROM)',
      name: 'Range_of_Motion_ROM',
      desc: '',
      args: [],
    );
  }

  /// `AMRAP (As Many Reps As Possible)`
  String get AMRAP_As_Many_Reps_As_Possible {
    return Intl.message(
      'AMRAP (As Many Reps As Possible)',
      name: 'AMRAP_As_Many_Reps_As_Possible',
      desc: '',
      args: [],
    );
  }

  /// `Swinging`
  String get Swinging {
    return Intl.message(
      'Swinging',
      name: 'Swinging',
      desc: '',
      args: [],
    );
  }

  /// `Biceps`
  String get Biceps {
    return Intl.message(
      'Biceps',
      name: 'Biceps',
      desc: '',
      args: [],
    );
  }

  /// `Biomechanics`
  String get Biomechanics {
    return Intl.message(
      'Biomechanics',
      name: 'Biomechanics',
      desc: '',
      args: [],
    );
  }

  /// `Warm-Up`
  String get Warm_Up {
    return Intl.message(
      'Warm-Up',
      name: 'Warm_Up',
      desc: '',
      args: [],
    );
  }

  /// `Cardiovascular`
  String get Cardiovascular {
    return Intl.message(
      'Cardiovascular',
      name: 'Cardiovascular',
      desc: '',
      args: [],
    );
  }

  /// `Training Cycle`
  String get Training_Cycle {
    return Intl.message(
      'Training Cycle',
      name: 'Training_Cycle',
      desc: '',
      args: [],
    );
  }

  /// `Core`
  String get Core {
    return Intl.message(
      'Core',
      name: 'Core',
      desc: '',
      args: [],
    );
  }

  /// `Pull-Ups`
  String get Pull_Ups {
    return Intl.message(
      'Pull-Ups',
      name: 'Pull_Ups',
      desc: '',
      args: [],
    );
  }

  /// `Drop Set`
  String get Drop_Set {
    return Intl.message(
      'Drop Set',
      name: 'Drop_Set',
      desc: '',
      args: [],
    );
  }

  /// `e1RM (Estimated 1 Repetition Maximum)`
  String get e1RM_Estimated_One_Repetition_Maximum {
    return Intl.message(
      'e1RM (Estimated 1 Repetition Maximum)',
      name: 'e1RM_Estimated_One_Repetition_Maximum',
      desc: '',
      args: [],
    );
  }

  /// `EMOM (Every Minute On the Minute)`
  String get EMOM_Every_Minute_On_the_Minute {
    return Intl.message(
      'EMOM (Every Minute On the Minute)',
      name: 'EMOM_Every_Minute_On_the_Minute',
      desc: '',
      args: [],
    );
  }

  /// `Strength Training`
  String get Strength_Training {
    return Intl.message(
      'Strength Training',
      name: 'Strength_Training',
      desc: '',
      args: [],
    );
  }

  /// `Stretching`
  String get Stretching {
    return Intl.message(
      'Stretching',
      name: 'Stretching',
      desc: '',
      args: [],
    );
  }

  /// `Compound Exercise`
  String get Compound_Exercise {
    return Intl.message(
      'Compound Exercise',
      name: 'Compound_Exercise',
      desc: '',
      args: [],
    );
  }

  /// `Failure`
  String get Failure {
    return Intl.message(
      'Failure',
      name: 'Failure',
      desc: '',
      args: [],
    );
  }

  /// `Muscle Failure`
  String get Muscle_Failure {
    return Intl.message(
      'Muscle Failure',
      name: 'Muscle_Failure',
      desc: '',
      args: [],
    );
  }

  /// `Flexibility`
  String get Flexibility {
    return Intl.message(
      'Flexibility',
      name: 'Flexibility',
      desc: '',
      args: [],
    );
  }

  /// `Muscle Gain`
  String get Muscle_Gain {
    return Intl.message(
      'Muscle Gain',
      name: 'Muscle_Gain',
      desc: '',
      args: [],
    );
  }

  /// `Glutes`
  String get Glutes {
    return Intl.message(
      'Glutes',
      name: 'Glutes',
      desc: '',
      args: [],
    );
  }

  /// `Hyperextension`
  String get Hyperextension {
    return Intl.message(
      'Hyperextension',
      name: 'Hyperextension',
      desc: '',
      args: [],
    );
  }

  /// `Hypertrophy`
  String get Hypertrophy {
    return Intl.message(
      'Hypertrophy',
      name: 'Hypertrophy',
      desc: '',
      args: [],
    );
  }

  /// `Intensity`
  String get Intensity {
    return Intl.message(
      'Intensity',
      name: 'Intensity',
      desc: '',
      args: [],
    );
  }

  /// `Rest Interval`
  String get Rest_Interval {
    return Intl.message(
      'Rest Interval',
      name: 'Rest_Interval',
      desc: '',
      args: [],
    );
  }

  /// `Pull`
  String get Pull {
    return Intl.message(
      'Pull',
      name: 'Pull',
      desc: '',
      args: [],
    );
  }

  /// `Olympic Lifting`
  String get Olympic_Lifting {
    return Intl.message(
      'Olympic Lifting',
      name: 'Olympic_Lifting',
      desc: '',
      args: [],
    );
  }

  /// `Lunge`
  String get Lunge {
    return Intl.message(
      'Lunge',
      name: 'Lunge',
      desc: '',
      args: [],
    );
  }

  /// `Dumbbell`
  String get Dumbbell {
    return Intl.message(
      'Dumbbell',
      name: 'Dumbbell',
      desc: '',
      args: [],
    );
  }

  /// `Maximum Repetition (1RM)`
  String get Maximum_Repetition_OneRM {
    return Intl.message(
      'Maximum Repetition (1RM)',
      name: 'Maximum_Repetition_OneRM',
      desc: '',
      args: [],
    );
  }

  /// `Bodybuilding`
  String get Bodybuilding {
    return Intl.message(
      'Bodybuilding',
      name: 'Bodybuilding',
      desc: '',
      args: [],
    );
  }

  /// `Deadlift`
  String get Deadlift {
    return Intl.message(
      'Deadlift',
      name: 'Deadlift',
      desc: '',
      args: [],
    );
  }

  /// `Plank`
  String get Plank {
    return Intl.message(
      'Plank',
      name: 'Plank',
      desc: '',
      args: [],
    );
  }

  /// `Plyometrics`
  String get Plyometrics {
    return Intl.message(
      'Plyometrics',
      name: 'Plyometrics',
      desc: '',
      args: [],
    );
  }

  /// `Press`
  String get Press {
    return Intl.message(
      'Press',
      name: 'Press',
      desc: '',
      args: [],
    );
  }

  /// `Repetitions (Reps)`
  String get Repetitions_Reps {
    return Intl.message(
      'Repetitions (Reps)',
      name: 'Repetitions_Reps',
      desc: '',
      args: [],
    );
  }

  /// `RM (Repetition Maximum)`
  String get RM_Repetition_Maximum {
    return Intl.message(
      'RM (Repetition Maximum)',
      name: 'RM_Repetition_Maximum',
      desc: '',
      args: [],
    );
  }

  /// `RPE (Rate of Perceived Exertion)`
  String get RPE_Rate_of_Perceived_Exertion {
    return Intl.message(
      'RPE (Rate of Perceived Exertion)',
      name: 'RPE_Rate_of_Perceived_Exertion',
      desc: '',
      args: [],
    );
  }

  /// `Sets`
  String get Sets {
    return Intl.message(
      'Sets',
      name: 'Sets',
      desc: '',
      args: [],
    );
  }

  /// `Submaximal`
  String get Submaximal {
    return Intl.message(
      'Submaximal',
      name: 'Submaximal',
      desc: '',
      args: [],
    );
  }

  /// `Superset`
  String get Superset {
    return Intl.message(
      'Superset',
      name: 'Superset',
      desc: '',
      args: [],
    );
  }

  /// `Tempo`
  String get Tempo {
    return Intl.message(
      'Tempo',
      name: 'Tempo',
      desc: '',
      args: [],
    );
  }

  /// `Toning`
  String get Toning {
    return Intl.message(
      'Toning',
      name: 'Toning',
      desc: '',
      args: [],
    );
  }

  /// `Trapezius`
  String get Trapezius {
    return Intl.message(
      'Trapezius',
      name: 'Trapezius',
      desc: '',
      args: [],
    );
  }

  /// `VO2 Max`
  String get VO2_Max {
    return Intl.message(
      'VO2 Max',
      name: 'VO2_Max',
      desc: '',
      args: [],
    );
  }

  /// `Training Volume`
  String get Training_Volume {
    return Intl.message(
      'Training Volume',
      name: 'Training_Volume',
      desc: '',
      args: [],
    );
  }

  /// `Heart Rate Zone`
  String get Heart_Rate_Zone {
    return Intl.message(
      'Heart Rate Zone',
      name: 'Heart_Rate_Zone',
      desc: '',
      args: [],
    );
  }

  /// `The maximum weight a person can lift in a single repetition for a specific exercise.`
  String get oneRM_One_Repetition_Maximum_definition {
    return Intl.message(
      'The maximum weight a person can lift in a single repetition for a specific exercise.',
      name: 'oneRM_One_Repetition_Maximum_definition',
      desc: '',
      args: [],
    );
  }

  /// `The way to hold a barbell or dumbbells during an exercise. It can be supinated (palms up), pronated (palms down), or neutral (palms facing each other).`
  String get Grip_definition {
    return Intl.message(
      'The way to hold a barbell or dumbbells during an exercise. It can be supinated (palms up), pronated (palms down), or neutral (palms facing each other).',
      name: 'Grip_definition',
      desc: '',
      args: [],
    );
  }

  /// `Exercise that requires oxygen to produce energy, such as running or cycling. It focuses on improving cardiovascular endurance.`
  String get Aerobic_definition {
    return Intl.message(
      'Exercise that requires oxygen to produce energy, such as running or cycling. It focuses on improving cardiovascular endurance.',
      name: 'Aerobic_definition',
      desc: '',
      args: [],
    );
  }

  /// `An exercise that targets a single muscle group, such as a bicep curl.`
  String get Isolation_definition {
    return Intl.message(
      'An exercise that targets a single muscle group, such as a bicep curl.',
      name: 'Isolation_definition',
      desc: '',
      args: [],
    );
  }

  /// `The full range of motion in a joint during an exercise.`
  String get Range_of_Motion_ROM_definition {
    return Intl.message(
      'The full range of motion in a joint during an exercise.',
      name: 'Range_of_Motion_ROM_definition',
      desc: '',
      args: [],
    );
  }

  /// `A workout where as many repetitions as possible are performed within a set time or until muscle failure.`
  String get AMRAP_As_Many_Reps_As_Possible_definition {
    return Intl.message(
      'A workout where as many repetitions as possible are performed within a set time or until muscle failure.',
      name: 'AMRAP_As_Many_Reps_As_Possible_definition',
      desc: '',
      args: [],
    );
  }

  /// `A movement that uses momentum instead of controlled muscular strength, often avoided to prevent injuries.`
  String get Swinging_definition {
    return Intl.message(
      'A movement that uses momentum instead of controlled muscular strength, often avoided to prevent injuries.',
      name: 'Swinging_definition',
      desc: '',
      args: [],
    );
  }

  /// `A muscle in the upper arm responsible for elbow flexion.`
  String get Biceps_definition {
    return Intl.message(
      'A muscle in the upper arm responsible for elbow flexion.',
      name: 'Biceps_definition',
      desc: '',
      args: [],
    );
  }

  /// `The study of body movement, including how muscles and joints interact during exercises.`
  String get Biomechanics_definition {
    return Intl.message(
      'The study of body movement, including how muscles and joints interact during exercises.',
      name: 'Biomechanics_definition',
      desc: '',
      args: [],
    );
  }

  /// `A series of light exercises to prepare the body for training, increasing muscle temperature and circulation.`
  String get Warm_Up_definition {
    return Intl.message(
      'A series of light exercises to prepare the body for training, increasing muscle temperature and circulation.',
      name: 'Warm_Up_definition',
      desc: '',
      args: [],
    );
  }

  /// `Exercise that improves the efficiency of the cardiovascular system, such as running, swimming, or cycling.`
  String get Cardiovascular_definition {
    return Intl.message(
      'Exercise that improves the efficiency of the cardiovascular system, such as running, swimming, or cycling.',
      name: 'Cardiovascular_definition',
      desc: '',
      args: [],
    );
  }

  /// `A defined period for following a specific training routine.`
  String get Training_Cycle_definition {
    return Intl.message(
      'A defined period for following a specific training routine.',
      name: 'Training_Cycle_definition',
      desc: '',
      args: [],
    );
  }

  /// `A group of muscles in the midsection of the body, including the abdominals, lower back, and obliques, providing stability.`
  String get Core_definition {
    return Intl.message(
      'A group of muscles in the midsection of the body, including the abdominals, lower back, and obliques, providing stability.',
      name: 'Core_definition',
      desc: '',
      args: [],
    );
  }

  /// `An exercise involving pulling the body up using the arms and back muscles.`
  String get Pull_Ups_definition {
    return Intl.message(
      'An exercise involving pulling the body up using the arms and back muscles.',
      name: 'Pull_Ups_definition',
      desc: '',
      args: [],
    );
  }

  /// `A technique where weight is reduced after reaching muscle failure to continue the exercise without rest.`
  String get Drop_Set_definition {
    return Intl.message(
      'A technique where weight is reduced after reaching muscle failure to continue the exercise without rest.',
      name: 'Drop_Set_definition',
      desc: '',
      args: [],
    );
  }

  /// `An estimation of the maximum weight a person could lift in a single repetition, calculated using formulas based on weight and completed repetitions in a set.`
  String get e1RM_Estimated_One_Repetition_Maximum_definition {
    return Intl.message(
      'An estimation of the maximum weight a person could lift in a single repetition, calculated using formulas based on weight and completed repetitions in a set.',
      name: 'e1RM_Estimated_One_Repetition_Maximum_definition',
      desc: '',
      args: [],
    );
  }

  /// `A workout where a series of exercises are performed at the start of each minute, resting for the remainder of the minute before starting again.`
  String get EMOM_Every_Minute_On_the_Minute_definition {
    return Intl.message(
      'A workout where a series of exercises are performed at the start of each minute, resting for the remainder of the minute before starting again.',
      name: 'EMOM_Every_Minute_On_the_Minute_definition',
      desc: '',
      args: [],
    );
  }

  /// `Exercise focusing on developing muscle strength through weightlifting or resistance.`
  String get Strength_Training_definition {
    return Intl.message(
      'Exercise focusing on developing muscle strength through weightlifting or resistance.',
      name: 'Strength_Training_definition',
      desc: '',
      args: [],
    );
  }

  /// `Exercises to improve flexibility and prevent injuries by stretching the muscles.`
  String get Stretching_definition {
    return Intl.message(
      'Exercises to improve flexibility and prevent injuries by stretching the muscles.',
      name: 'Stretching_definition',
      desc: '',
      args: [],
    );
  }

  /// `An exercise that works multiple muscle groups and joints, such as bench presses or squats.`
  String get Compound_Exercise_definition {
    return Intl.message(
      'An exercise that works multiple muscle groups and joints, such as bench presses or squats.',
      name: 'Compound_Exercise_definition',
      desc: '',
      args: [],
    );
  }

  /// `The point at which muscles can no longer perform another repetition with proper form, requiring rest.`
  String get Failure_definition {
    return Intl.message(
      'The point at which muscles can no longer perform another repetition with proper form, requiring rest.',
      name: 'Failure_definition',
      desc: '',
      args: [],
    );
  }

  /// `The point at which muscles can no longer perform another repetition with proper form.`
  String get Muscle_Failure_definition {
    return Intl.message(
      'The point at which muscles can no longer perform another repetition with proper form.',
      name: 'Muscle_Failure_definition',
      desc: '',
      args: [],
    );
  }

  /// `The ability of a joint to move through its full range of motion.`
  String get Flexibility_definition {
    return Intl.message(
      'The ability of a joint to move through its full range of motion.',
      name: 'Flexibility_definition',
      desc: '',
      args: [],
    );
  }

  /// `The goal of increasing muscle size and volume through strength exercises and proper diet.`
  String get Muscle_Gain_definition {
    return Intl.message(
      'The goal of increasing muscle size and volume through strength exercises and proper diet.',
      name: 'Muscle_Gain_definition',
      desc: '',
      args: [],
    );
  }

  /// `Large muscles in the buttocks responsible for hip extension and rotation.`
  String get Glutes_definition {
    return Intl.message(
      'Large muscles in the buttocks responsible for hip extension and rotation.',
      name: 'Glutes_definition',
      desc: '',
      args: [],
    );
  }

  /// `Excessive movement of a joint beyond its normal range, which can cause injuries.`
  String get Hyperextension_definition {
    return Intl.message(
      'Excessive movement of a joint beyond its normal range, which can cause injuries.',
      name: 'Hyperextension_definition',
      desc: '',
      args: [],
    );
  }

  /// `Growth in muscle size due to specific training and proper nutrition.`
  String get Hypertrophy_definition {
    return Intl.message(
      'Growth in muscle size due to specific training and proper nutrition.',
      name: 'Hypertrophy_definition',
      desc: '',
      args: [],
    );
  }

  /// `The level of effort required to perform an exercise or routine, usually measured as a percentage of maximum effort.`
  String get Intensity_definition {
    return Intl.message(
      'The level of effort required to perform an exercise or routine, usually measured as a percentage of maximum effort.',
      name: 'Intensity_definition',
      desc: '',
      args: [],
    );
  }

  /// `The recovery time between sets or exercises.`
  String get Rest_Interval_definition {
    return Intl.message(
      'The recovery time between sets or exercises.',
      name: 'Rest_Interval_definition',
      desc: '',
      args: [],
    );
  }

  /// `A pulling motion, such as in back exercises that require pulling a load toward the body.`
  String get Pull_definition {
    return Intl.message(
      'A pulling motion, such as in back exercises that require pulling a load toward the body.',
      name: 'Pull_definition',
      desc: '',
      args: [],
    );
  }

  /// `Sports and specific movements that include lifts like the clean and jerk and the snatch.`
  String get Olympic_Lifting_definition {
    return Intl.message(
      'Sports and specific movements that include lifts like the clean and jerk and the snatch.',
      name: 'Olympic_Lifting_definition',
      desc: '',
      args: [],
    );
  }

  /// `A leg exercise where one foot steps forward and the knee bends, working the glutes and quadriceps.`
  String get Lunge_definition {
    return Intl.message(
      'A leg exercise where one foot steps forward and the knee bends, working the glutes and quadriceps.',
      name: 'Lunge_definition',
      desc: '',
      args: [],
    );
  }

  /// `A free weight held in one hand, used in strength exercises.`
  String get Dumbbell_definition {
    return Intl.message(
      'A free weight held in one hand, used in strength exercises.',
      name: 'Dumbbell_definition',
      desc: '',
      args: [],
    );
  }

  /// `The maximum weight a person can lift in a single repetition for a given exercise.`
  String get Maximum_Repetition_OneRM_definition {
    return Intl.message(
      'The maximum weight a person can lift in a single repetition for a given exercise.',
      name: 'Maximum_Repetition_OneRM_definition',
      desc: '',
      args: [],
    );
  }

  /// `Training focused on developing muscle size and strength.`
  String get Bodybuilding_definition {
    return Intl.message(
      'Training focused on developing muscle size and strength.',
      name: 'Bodybuilding_definition',
      desc: '',
      args: [],
    );
  }

  /// `A compound exercise that involves multiple muscle groups, lifting a barbell from the ground.`
  String get Deadlift_definition {
    return Intl.message(
      'A compound exercise that involves multiple muscle groups, lifting a barbell from the ground.',
      name: 'Deadlift_definition',
      desc: '',
      args: [],
    );
  }

  /// `An isometric core exercise where the body is held straight in a push-up position.`
  String get Plank_definition {
    return Intl.message(
      'An isometric core exercise where the body is held straight in a push-up position.',
      name: 'Plank_definition',
      desc: '',
      args: [],
    );
  }

  /// `Exercises designed to increase power and speed through explosive movements, such as jumps or throws.`
  String get Plyometrics_definition {
    return Intl.message(
      'Exercises designed to increase power and speed through explosive movements, such as jumps or throws.',
      name: 'Plyometrics_definition',
      desc: '',
      args: [],
    );
  }

  /// `A pushing exercise involving movements like bench presses or shoulder presses.`
  String get Press_definition {
    return Intl.message(
      'A pushing exercise involving movements like bench presses or shoulder presses.',
      name: 'Press_definition',
      desc: '',
      args: [],
    );
  }

  /// `The number of times an exercise is performed in a set.`
  String get Repetitions_Reps_definition {
    return Intl.message(
      'The number of times an exercise is performed in a set.',
      name: 'Repetitions_Reps_definition',
      desc: '',
      args: [],
    );
  }

  /// `The maximum number of repetitions that can be done with a given weight before reaching muscle failure.`
  String get RM_Repetition_Maximum_definition {
    return Intl.message(
      'The maximum number of repetitions that can be done with a given weight before reaching muscle failure.',
      name: 'RM_Repetition_Maximum_definition',
      desc: '',
      args: [],
    );
  }

  /// `A subjective scale measuring perceived exercise intensity, usually from 1 to 10, where 10 is maximum effort.`
  String get RPE_Rate_of_Perceived_Exertion_definition {
    return Intl.message(
      'A subjective scale measuring perceived exercise intensity, usually from 1 to 10, where 10 is maximum effort.',
      name: 'RPE_Rate_of_Perceived_Exertion_definition',
      desc: '',
      args: [],
    );
  }

  /// `A set of repetitions performed in an exercise before resting.`
  String get Sets_definition {
    return Intl.message(
      'A set of repetitions performed in an exercise before resting.',
      name: 'Sets_definition',
      desc: '',
      args: [],
    );
  }

  /// `Weight or effort that is below the maximum level, used in training to avoid exhaustion.`
  String get Submaximal_definition {
    return Intl.message(
      'Weight or effort that is below the maximum level, used in training to avoid exhaustion.',
      name: 'Submaximal_definition',
      desc: '',
      args: [],
    );
  }

  /// `A technique where two exercises are performed back-to-back without rest, usually for opposing muscle groups.`
  String get Superset_definition {
    return Intl.message(
      'A technique where two exercises are performed back-to-back without rest, usually for opposing muscle groups.',
      name: 'Superset_definition',
      desc: '',
      args: [],
    );
  }

  /// `Controlled speed of each phase of movement in an exercise, often expressed in a sequence of four numbers (e.g., 2-0-2-0) to regulate execution.`
  String get Tempo_definition {
    return Intl.message(
      'Controlled speed of each phase of movement in an exercise, often expressed in a sequence of four numbers (e.g., 2-0-2-0) to regulate execution.',
      name: 'Tempo_definition',
      desc: '',
      args: [],
    );
  }

  /// `A program of exercises and diet to reduce fat and increase muscle definition without significant volume gains.`
  String get Toning_definition {
    return Intl.message(
      'A program of exercises and diet to reduce fat and increase muscle definition without significant volume gains.',
      name: 'Toning_definition',
      desc: '',
      args: [],
    );
  }

  /// `A large back muscle that controls scapula and neck movements.`
  String get Trapezius_definition {
    return Intl.message(
      'A large back muscle that controls scapula and neck movements.',
      name: 'Trapezius_definition',
      desc: '',
      args: [],
    );
  }

  /// `The body's maximum capacity to transport and use oxygen during intense exercise, an indicator of cardiovascular fitness.`
  String get VO2_Max_definition {
    return Intl.message(
      'The body\'s maximum capacity to transport and use oxygen during intense exercise, an indicator of cardiovascular fitness.',
      name: 'VO2_Max_definition',
      desc: '',
      args: [],
    );
  }

  /// `The total amount of work performed, usually calculated as sets x repetitions x weight.`
  String get Training_Volume_definition {
    return Intl.message(
      'The total amount of work performed, usually calculated as sets x repetitions x weight.',
      name: 'Training_Volume_definition',
      desc: '',
      args: [],
    );
  }

  /// `The range of heartbeats per minute suitable for a specific training goal (e.g., aerobic, anaerobic zone).`
  String get Heart_Rate_Zone_definition {
    return Intl.message(
      'The range of heartbeats per minute suitable for a specific training goal (e.g., aerobic, anaerobic zone).',
      name: 'Heart_Rate_Zone_definition',
      desc: '',
      args: [],
    );
  }

  /// `All`
  String get todas {
    return Intl.message(
      'All',
      name: 'todas',
      desc: '',
      args: [],
    );
  }

  /// `Group`
  String get grupo {
    return Intl.message(
      'Group',
      name: 'grupo',
      desc: '',
      args: [],
    );
  }

  /// `Difficulty`
  String get dificultad {
    return Intl.message(
      'Difficulty',
      name: 'dificultad',
      desc: '',
      args: [],
    );
  }

  /// `Description`
  String get descripcion {
    return Intl.message(
      'Description',
      name: 'descripcion',
      desc: '',
      args: [],
    );
  }

  /// `Instructions`
  String get instrucciones1 {
    return Intl.message(
      'Instructions',
      name: 'instrucciones1',
      desc: '',
      args: [],
    );
  }

  /// `Global achievements`
  String get logros_globales {
    return Intl.message(
      'Global achievements',
      name: 'logros_globales',
      desc: '',
      args: [],
    );
  }

  /// `Achievements obtained`
  String get logros_obtenidos {
    return Intl.message(
      'Achievements obtained',
      name: 'logros_obtenidos',
      desc: '',
      args: [],
    );
  }

  /// `In progress`
  String get En_progreso {
    return Intl.message(
      'In progress',
      name: 'En_progreso',
      desc: '',
      args: [],
    );
  }

  /// `Completed`
  String get Completadas {
    return Intl.message(
      'Completed',
      name: 'Completadas',
      desc: '',
      args: [],
    );
  }

  /// `Unstarted`
  String get Sin_comenzar {
    return Intl.message(
      'Unstarted',
      name: 'Sin_comenzar',
      desc: '',
      args: [],
    );
  }

  /// `No description`
  String get sin_descripcion {
    return Intl.message(
      'No description',
      name: 'sin_descripcion',
      desc: '',
      args: [],
    );
  }

  /// `Initial value`
  String get valor_inicial {
    return Intl.message(
      'Initial value',
      name: 'valor_inicial',
      desc: '',
      args: [],
    );
  }

  /// `Current value`
  String get valor_actual {
    return Intl.message(
      'Current value',
      name: 'valor_actual',
      desc: '',
      args: [],
    );
  }

  /// `final value`
  String get valor_final {
    return Intl.message(
      'final value',
      name: 'valor_final',
      desc: '',
      args: [],
    );
  }

  /// `Progress`
  String get progreso {
    return Intl.message(
      'Progress',
      name: 'progreso',
      desc: '',
      args: [],
    );
  }

  /// `Delete Objetive`
  String get eliminar_objetivo {
    return Intl.message(
      'Delete Objetive',
      name: 'eliminar_objetivo',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to remove this target?`
  String get estas_seguro {
    return Intl.message(
      'Are you sure you want to remove this target?',
      name: 'estas_seguro',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancelar {
    return Intl.message(
      'Cancel',
      name: 'cancelar',
      desc: '',
      args: [],
    );
  }

  /// `Delete`
  String get eliminar {
    return Intl.message(
      'Delete',
      name: 'eliminar',
      desc: '',
      args: [],
    );
  }

  /// `Edit Current Value`
  String get Editar_valor {
    return Intl.message(
      'Edit Current Value',
      name: 'Editar_valor',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a valid value.`
  String get valor_valido {
    return Intl.message(
      'Please enter a valid value.',
      name: 'valor_valido',
      desc: '',
      args: [],
    );
  }

  /// `Update`
  String get Actualizar {
    return Intl.message(
      'Update',
      name: 'Actualizar',
      desc: '',
      args: [],
    );
  }

  /// `Diet`
  String get Dieta {
    return Intl.message(
      'Diet',
      name: 'Dieta',
      desc: '',
      args: [],
    );
  }

  /// `Error: User not authenticated`
  String get error_usuario {
    return Intl.message(
      'Error: User not authenticated',
      name: 'error_usuario',
      desc: '',
      args: [],
    );
  }

  /// `New weights`
  String get nuevos_pesos {
    return Intl.message(
      'New weights',
      name: 'nuevos_pesos',
      desc: '',
      args: [],
    );
  }

  /// `New percentage`
  String get nuevos_porcentaje {
    return Intl.message(
      'New percentage',
      name: 'nuevos_porcentaje',
      desc: '',
      args: [],
    );
  }

  /// `Increased repetitions`
  String get Aumento_rep {
    return Intl.message(
      'Increased repetitions',
      name: 'Aumento_rep',
      desc: '',
      args: [],
    );
  }

  /// `Time reduction`
  String get Reduccion_tiempo {
    return Intl.message(
      'Time reduction',
      name: 'Reduccion_tiempo',
      desc: '',
      args: [],
    );
  }

  /// `Title of the objective`
  String get Titulo_objetivo {
    return Intl.message(
      'Title of the objective',
      name: 'Titulo_objetivo',
      desc: '',
      args: [],
    );
  }

  /// `Select deadline date`
  String get seleccionar_fecha {
    return Intl.message(
      'Select deadline date',
      name: 'seleccionar_fecha',
      desc: '',
      args: [],
    );
  }

  /// `Deadline`
  String get fecha_limite {
    return Intl.message(
      'Deadline',
      name: 'fecha_limite',
      desc: '',
      args: [],
    );
  }

  /// `Save Objective`
  String get guardar_objetivo {
    return Intl.message(
      'Save Objective',
      name: 'guardar_objetivo',
      desc: '',
      args: [],
    );
  }

  /// `Create new Objetive`
  String get crear_objetivo {
    return Intl.message(
      'Create new Objetive',
      name: 'crear_objetivo',
      desc: '',
      args: [],
    );
  }

  /// `Objetive Type`
  String get tipo_objetivo {
    return Intl.message(
      'Objetive Type',
      name: 'tipo_objetivo',
      desc: '',
      args: [],
    );
  }

  /// `Explore how VitalityConnect can help you improve your physical and mental well-being. Discover our mission and vision to inspire you to reach your goals.`
  String get acercade {
    return Intl.message(
      'Explore how VitalityConnect can help you improve your physical and mental well-being. Discover our mission and vision to inspire you to reach your goals.',
      name: 'acercade',
      desc: '',
      args: [],
    );
  }

  /// `What is VitalityConnect?`
  String get acercade1 {
    return Intl.message(
      'What is VitalityConnect?',
      name: 'acercade1',
      desc: '',
      args: [],
    );
  }

  /// `VitalityConnect is an application dedicated to helping users track their physical activity and improve their overall health. With personalized functionalities, you can create routines tailored to your needs and join a community that will motivate you to reach your goals.`
  String get acercade2 {
    return Intl.message(
      'VitalityConnect is an application dedicated to helping users track their physical activity and improve their overall health. With personalized functionalities, you can create routines tailored to your needs and join a community that will motivate you to reach your goals.',
      name: 'acercade2',
      desc: '',
      args: [],
    );
  }

  /// `Our Mission`
  String get acercade3 {
    return Intl.message(
      'Our Mission',
      name: 'acercade3',
      desc: '',
      args: [],
    );
  }

  /// `Our mission is to empower people to lead a healthy lifestyle through physical activity, offering tools and resources that facilitate their progress and well-being.`
  String get acercade4 {
    return Intl.message(
      'Our mission is to empower people to lead a healthy lifestyle through physical activity, offering tools and resources that facilitate their progress and well-being.',
      name: 'acercade4',
      desc: '',
      args: [],
    );
  }

  /// `Our Vision`
  String get acercade5 {
    return Intl.message(
      'Our Vision',
      name: 'acercade5',
      desc: '',
      args: [],
    );
  }

  /// `Our vision is to be the leading fitness app, promoting health and wellness worldwide through technology and community.`
  String get acercade6 {
    return Intl.message(
      'Our vision is to be the leading fitness app, promoting health and wellness worldwide through technology and community.',
      name: 'acercade6',
      desc: '',
      args: [],
    );
  }

  /// `Selected`
  String get Seleccionado {
    return Intl.message(
      'Selected',
      name: 'Seleccionado',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get idioma {
    return Intl.message(
      'Language',
      name: 'idioma',
      desc: '',
      args: [],
    );
  }

  /// `User Information`
  String get info_usuario {
    return Intl.message(
      'User Information',
      name: 'info_usuario',
      desc: '',
      args: [],
    );
  }

  /// `No profile information available`
  String get no_info {
    return Intl.message(
      'No profile information available',
      name: 'no_info',
      desc: '',
      args: [],
    );
  }

  /// `Full Name`
  String get nombre_completo {
    return Intl.message(
      'Full Name',
      name: 'nombre_completo',
      desc: '',
      args: [],
    );
  }

  /// `Weight`
  String get peso {
    return Intl.message(
      'Weight',
      name: 'peso',
      desc: '',
      args: [],
    );
  }

  /// `Years old`
  String get anios {
    return Intl.message(
      'Years old',
      name: 'anios',
      desc: '',
      args: [],
    );
  }

  /// `Height`
  String get Estatura {
    return Intl.message(
      'Height',
      name: 'Estatura',
      desc: '',
      args: [],
    );
  }

  /// `Notifications`
  String get notificaciones {
    return Intl.message(
      'Notifications',
      name: 'notificaciones',
      desc: '',
      args: [],
    );
  }

  /// `Select the notifications you want to receive on your phone, remember that you have to accept the permissions first`
  String get notificaciones1 {
    return Intl.message(
      'Select the notifications you want to receive on your phone, remember that you have to accept the permissions first',
      name: 'notificaciones1',
      desc: '',
      args: [],
    );
  }

  /// `Motivational messages`
  String get notificaciones2 {
    return Intl.message(
      'Motivational messages',
      name: 'notificaciones2',
      desc: '',
      args: [],
    );
  }

  /// `Reminders`
  String get notificaciones3 {
    return Intl.message(
      'Reminders',
      name: 'notificaciones3',
      desc: '',
      args: [],
    );
  }

  /// `Timer`
  String get notificaciones4 {
    return Intl.message(
      'Timer',
      name: 'notificaciones4',
      desc: '',
      args: [],
    );
  }

  /// `Help`
  String get notificaciones5 {
    return Intl.message(
      'Help',
      name: 'notificaciones5',
      desc: '',
      args: [],
    );
  }

  /// `Units applied`
  String get notificaciones6 {
    return Intl.message(
      'Units applied',
      name: 'notificaciones6',
      desc: '',
      args: [],
    );
  }

  /// `Yes`
  String get si {
    return Intl.message(
      'Yes',
      name: 'si',
      desc: '',
      args: [],
    );
  }

  /// `View Information`
  String get ver_info {
    return Intl.message(
      'View Information',
      name: 'ver_info',
      desc: '',
      args: [],
    );
  }

  /// `Theme (Coming soon...)`
  String get tema {
    return Intl.message(
      'Theme (Coming soon...)',
      name: 'tema',
      desc: '',
      args: [],
    );
  }

  /// `Notifications (Coming soon...)`
  String get notificaciones_prox {
    return Intl.message(
      'Notifications (Coming soon...)',
      name: 'notificaciones_prox',
      desc: '',
      args: [],
    );
  }

  /// `Units`
  String get unidades {
    return Intl.message(
      'Units',
      name: 'unidades',
      desc: '',
      args: [],
    );
  }

  /// `Data Privacy`
  String get privacidad_datos {
    return Intl.message(
      'Data Privacy',
      name: 'privacidad_datos',
      desc: '',
      args: [],
    );
  }

  /// `About...`
  String get acerca_de {
    return Intl.message(
      'About...',
      name: 'acerca_de',
      desc: '',
      args: [],
    );
  }

  /// `1. Introduction`
  String get privacidad_datos1 {
    return Intl.message(
      '1. Introduction',
      name: 'privacidad_datos1',
      desc: '',
      args: [],
    );
  }

  /// `In our application, we protect the personal data of our users in compliance with Law No. 19,628 on the Protection of Privacy. This policy describes how we collect, use and protect personal information, in addition to ensuring the user's informed consent to promote greater awareness about the protection of their privacy.`
  String get privacidad_datos2 {
    return Intl.message(
      'In our application, we protect the personal data of our users in compliance with Law No. 19,628 on the Protection of Privacy. This policy describes how we collect, use and protect personal information, in addition to ensuring the user\'s informed consent to promote greater awareness about the protection of their privacy.',
      name: 'privacidad_datos2',
      desc: '',
      args: [],
    );
  }

  /// `2. Context: Law N°19.628`
  String get privacidad_datos3 {
    return Intl.message(
      '2. Context: Law N°19.628',
      name: 'privacidad_datos3',
      desc: '',
      args: [],
    );
  }

  /// `This law guarantees the rights of access, rectification and deletion of personal data and prohibits the use of such data without the owner's consent, except in specific cases. It also establishes the obligation to adopt adequate security measures to protect the data and to inform about the purpose of its collection.`
  String get privacidad_datos4 {
    return Intl.message(
      'This law guarantees the rights of access, rectification and deletion of personal data and prohibits the use of such data without the owner\'s consent, except in specific cases. It also establishes the obligation to adopt adequate security measures to protect the data and to inform about the purpose of its collection.',
      name: 'privacidad_datos4',
      desc: '',
      args: [],
    );
  }

  /// `3. Legal and Regulatory Compliance`
  String get privacidad_datos5 {
    return Intl.message(
      '3. Legal and Regulatory Compliance',
      name: 'privacidad_datos5',
      desc: '',
      args: [],
    );
  }

  /// `To ensure compliance with Law No. 19,628 in our mobile and web application, we apply the following measures:`
  String get privacidad_datos6 {
    return Intl.message(
      'To ensure compliance with Law No. 19,628 in our mobile and web application, we apply the following measures:',
      name: 'privacidad_datos6',
      desc: '',
      args: [],
    );
  }

  /// `- Identification of personal data: `
  String get privacidad_datos7 {
    return Intl.message(
      '- Identification of personal data: ',
      name: 'privacidad_datos7',
      desc: '',
      args: [],
    );
  }

  /// `We request only the data necessary for the operation of the application.`
  String get privacidad_datos8 {
    return Intl.message(
      'We request only the data necessary for the operation of the application.',
      name: 'privacidad_datos8',
      desc: '',
      args: [],
    );
  }

  /// `- Accessible privacy policy: `
  String get privacidad_datos9 {
    return Intl.message(
      '- Accessible privacy policy: ',
      name: 'privacidad_datos9',
      desc: '',
      args: [],
    );
  }

  /// `We clearly explain the purpose and use of the data collected.`
  String get privacidad_datos10 {
    return Intl.message(
      'We clearly explain the purpose and use of the data collected.',
      name: 'privacidad_datos10',
      desc: '',
      args: [],
    );
  }

  /// `- Informed consent: `
  String get privacidad_datos11 {
    return Intl.message(
      '- Informed consent: ',
      name: 'privacidad_datos11',
      desc: '',
      args: [],
    );
  }

  /// `We obtain the user's clear and understandable consent before collecting their data.`
  String get privacidad_datos12 {
    return Intl.message(
      'We obtain the user\'s clear and understandable consent before collecting their data.',
      name: 'privacidad_datos12',
      desc: '',
      args: [],
    );
  }

  /// `- User's rights: `
  String get privacidad_datos13 {
    return Intl.message(
      '- User\'s rights: ',
      name: 'privacidad_datos13',
      desc: '',
      args: [],
    );
  }

  /// `We offer options for users to access, correct or delete their data at any time.`
  String get privacidad_datos14 {
    return Intl.message(
      'We offer options for users to access, correct or delete their data at any time.',
      name: 'privacidad_datos14',
      desc: '',
      args: [],
    );
  }

  /// `- Safety measures: `
  String get privacidad_datos15 {
    return Intl.message(
      '- Safety measures: ',
      name: 'privacidad_datos15',
      desc: '',
      args: [],
    );
  }

  /// `We protect information through encryption, authentication and secure transmission protocols.`
  String get privacidad_datos16 {
    return Intl.message(
      'We protect information through encryption, authentication and secure transmission protocols.',
      name: 'privacidad_datos16',
      desc: '',
      args: [],
    );
  }

  /// `- Team training: `
  String get privacidad_datos17 {
    return Intl.message(
      '- Team training: ',
      name: 'privacidad_datos17',
      desc: '',
      args: [],
    );
  }

  /// `We ensure that our team is trained in secure data handling.`
  String get privacidad_datos18 {
    return Intl.message(
      'We ensure that our team is trained in secure data handling.',
      name: 'privacidad_datos18',
      desc: '',
      args: [],
    );
  }

  /// `- Transparency: `
  String get privacidad_datos19 {
    return Intl.message(
      '- Transparency: ',
      name: 'privacidad_datos19',
      desc: '',
      args: [],
    );
  }

  /// `We inform users of any changes in the handling of their data.`
  String get privacidad_datos20 {
    return Intl.message(
      'We inform users of any changes in the handling of their data.',
      name: 'privacidad_datos20',
      desc: '',
      args: [],
    );
  }

  /// `4. Requested Data`
  String get privacidad_datos21 {
    return Intl.message(
      '4. Requested Data',
      name: 'privacidad_datos21',
      desc: '',
      args: [],
    );
  }

  /// `We collect the following types of personal data to personalize the user experience:`
  String get privacidad_datos22 {
    return Intl.message(
      'We collect the following types of personal data to personalize the user experience:',
      name: 'privacidad_datos22',
      desc: '',
      args: [],
    );
  }

  /// `- Identification: `
  String get privacidad_datos23 {
    return Intl.message(
      '- Identification: ',
      name: 'privacidad_datos23',
      desc: '',
      args: [],
    );
  }

  /// `Name, e-mail and telephone number (optional).`
  String get privacidad_datos24 {
    return Intl.message(
      'Name, e-mail and telephone number (optional).',
      name: 'privacidad_datos24',
      desc: '',
      args: [],
    );
  }

  /// `- Health and Fitness: `
  String get privacidad_datos25 {
    return Intl.message(
      '- Health and Fitness: ',
      name: 'privacidad_datos25',
      desc: '',
      args: [],
    );
  }

  /// `Age, gender, weight, height, fitness goals and activity level.`
  String get privacidad_datos26 {
    return Intl.message(
      'Age, gender, weight, height, fitness goals and activity level.',
      name: 'privacidad_datos26',
      desc: '',
      args: [],
    );
  }

  /// `- Exercise Preferences: `
  String get privacidad_datos27 {
    return Intl.message(
      '- Exercise Preferences: ',
      name: 'privacidad_datos27',
      desc: '',
      args: [],
    );
  }

  /// `Preferred types of exercise and frequency of training.`
  String get privacidad_datos28 {
    return Intl.message(
      'Preferred types of exercise and frequency of training.',
      name: 'privacidad_datos28',
      desc: '',
      args: [],
    );
  }

  /// `- Progress: `
  String get privacidad_datos29 {
    return Intl.message(
      '- Progress: ',
      name: 'privacidad_datos29',
      desc: '',
      args: [],
    );
  }

  /// `Training record (exercises, duration and intensity) and body measurements.`
  String get privacidad_datos30 {
    return Intl.message(
      'Training record (exercises, duration and intensity) and body measurements.',
      name: 'privacidad_datos30',
      desc: '',
      args: [],
    );
  }

  /// `- Notifications: `
  String get privacidad_datos31 {
    return Intl.message(
      '- Notifications: ',
      name: 'privacidad_datos31',
      desc: '',
      args: [],
    );
  }

  /// `Communication preferences for reminders and motivational messages.`
  String get privacidad_datos32 {
    return Intl.message(
      'Communication preferences for reminders and motivational messages.',
      name: 'privacidad_datos32',
      desc: '',
      args: [],
    );
  }

  /// `5. Confidentiality and Use of Data`
  String get privacidad_datos33 {
    return Intl.message(
      '5. Confidentiality and Use of Data',
      name: 'privacidad_datos33',
      desc: '',
      args: [],
    );
  }

  /// `All information collected is treated with strict confidentiality and used exclusively for the purposes of improving the application experience. The data is protected in accordance with the legal regulations in force.`
  String get privacidad_datos34 {
    return Intl.message(
      'All information collected is treated with strict confidentiality and used exclusively for the purposes of improving the application experience. The data is protected in accordance with the legal regulations in force.',
      name: 'privacidad_datos34',
      desc: '',
      args: [],
    );
  }

  /// `applied`
  String get aplicado {
    return Intl.message(
      'applied',
      name: 'aplicado',
      desc: '',
      args: [],
    );
  }

  /// `Light`
  String get Claro {
    return Intl.message(
      'Light',
      name: 'Claro',
      desc: '',
      args: [],
    );
  }

  /// `Dark`
  String get Oscuro {
    return Intl.message(
      'Dark',
      name: 'Oscuro',
      desc: '',
      args: [],
    );
  }

  /// `Gender`
  String get genero {
    return Intl.message(
      'Gender',
      name: 'genero',
      desc: '',
      args: [],
    );
  }

  /// `Select your Routine`
  String get seleccion_rutina {
    return Intl.message(
      'Select your Routine',
      name: 'seleccion_rutina',
      desc: '',
      args: [],
    );
  }

  /// `Strength`
  String get Fuerza {
    return Intl.message(
      'Strength',
      name: 'Fuerza',
      desc: '',
      args: [],
    );
  }

  /// `Team sports`
  String get Deporte_equipo {
    return Intl.message(
      'Team sports',
      name: 'Deporte_equipo',
      desc: '',
      args: [],
    );
  }

  /// `Elongation`
  String get Elongacion {
    return Intl.message(
      'Elongation',
      name: 'Elongacion',
      desc: '',
      args: [],
    );
  }

  /// `Flexibility`
  String get Flexibilidad {
    return Intl.message(
      'Flexibility',
      name: 'Flexibilidad',
      desc: '',
      args: [],
    );
  }

  /// `Create your new Routine`
  String get crea_rutina {
    return Intl.message(
      'Create your new Routine',
      name: 'crea_rutina',
      desc: '',
      args: [],
    );
  }

  /// `Name of your Routine`
  String get Nombre_rutina {
    return Intl.message(
      'Name of your Routine',
      name: 'Nombre_rutina',
      desc: '',
      args: [],
    );
  }

  /// `Choose your Icon`
  String get elige_icono {
    return Intl.message(
      'Choose your Icon',
      name: 'elige_icono',
      desc: '',
      args: [],
    );
  }

  /// `Type of Routine`
  String get tipo_rutina {
    return Intl.message(
      'Type of Routine',
      name: 'tipo_rutina',
      desc: '',
      args: [],
    );
  }

  /// `Routine successfully created`
  String get crea_rutina1 {
    return Intl.message(
      'Routine successfully created',
      name: 'crea_rutina1',
      desc: '',
      args: [],
    );
  }

  /// `Error creating the routine`
  String get crea_rutina2 {
    return Intl.message(
      'Error creating the routine',
      name: 'crea_rutina2',
      desc: '',
      args: [],
    );
  }

  /// `Create `
  String get crear {
    return Intl.message(
      'Create ',
      name: 'crear',
      desc: '',
      args: [],
    );
  }

  /// `Create routine`
  String get crear_rutina {
    return Intl.message(
      'Create routine',
      name: 'crear_rutina',
      desc: '',
      args: [],
    );
  }

  /// `You have no routines created`
  String get no_rutinas {
    return Intl.message(
      'You have no routines created',
      name: 'no_rutinas',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure?`
  String get estas_seguro_rutina {
    return Intl.message(
      'Are you sure?',
      name: 'estas_seguro_rutina',
      desc: '',
      args: [],
    );
  }

  /// `Do you want to keep this routine?`
  String get deseas_guardar {
    return Intl.message(
      'Do you want to keep this routine?',
      name: 'deseas_guardar',
      desc: '',
      args: [],
    );
  }

  /// `Routine saved successfully`
  String get rutina_guardada {
    return Intl.message(
      'Routine saved successfully',
      name: 'rutina_guardada',
      desc: '',
      args: [],
    );
  }

  /// `There was an error saving the routine`
  String get rutina_guardada1 {
    return Intl.message(
      'There was an error saving the routine',
      name: 'rutina_guardada1',
      desc: '',
      args: [],
    );
  }

  /// `Fill your routine your way!`
  String get rellena_manera {
    return Intl.message(
      'Fill your routine your way!',
      name: 'rellena_manera',
      desc: '',
      args: [],
    );
  }

  /// `Routine ID`
  String get id_rutina {
    return Intl.message(
      'Routine ID',
      name: 'id_rutina',
      desc: '',
      args: [],
    );
  }

  /// `You have to add your exercises`
  String get agrega_ejercicios {
    return Intl.message(
      'You have to add your exercises',
      name: 'agrega_ejercicios',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get guardar {
    return Intl.message(
      'Save',
      name: 'guardar',
      desc: '',
      args: [],
    );
  }

  /// `Add a new exercise`
  String get agrega_nuevo_ejercicio {
    return Intl.message(
      'Add a new exercise',
      name: 'agrega_nuevo_ejercicio',
      desc: '',
      args: [],
    );
  }

  /// `Confirm deletion`
  String get confimar_eliminacion {
    return Intl.message(
      'Confirm deletion',
      name: 'confimar_eliminacion',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to eliminate this exercise?`
  String get confimar_eliminacion1 {
    return Intl.message(
      'Are you sure you want to eliminate this exercise?',
      name: 'confimar_eliminacion1',
      desc: '',
      args: [],
    );
  }

  /// `Exercise successfully eliminated`
  String get eliminacion_ejercicio {
    return Intl.message(
      'Exercise successfully eliminated',
      name: 'eliminacion_ejercicio',
      desc: '',
      args: [],
    );
  }

  /// `Error when eliminating exercise`
  String get eliminacion_ejercicio1 {
    return Intl.message(
      'Error when eliminating exercise',
      name: 'eliminacion_ejercicio1',
      desc: '',
      args: [],
    );
  }

  /// `There are no exercises in this routine.`
  String get no_ejercicios_rutina {
    return Intl.message(
      'There are no exercises in this routine.',
      name: 'no_ejercicios_rutina',
      desc: '',
      args: [],
    );
  }

  /// `Data successfully saved for the specific exercise`
  String get datos_guardados {
    return Intl.message(
      'Data successfully saved for the specific exercise',
      name: 'datos_guardados',
      desc: '',
      args: [],
    );
  }

  /// `Current Routine`
  String get rutina_actual {
    return Intl.message(
      'Current Routine',
      name: 'rutina_actual',
      desc: '',
      args: [],
    );
  }

  /// `Progress History`
  String get rutina_historial {
    return Intl.message(
      'Progress History',
      name: 'rutina_historial',
      desc: '',
      args: [],
    );
  }

  /// `Series`
  String get series {
    return Intl.message(
      'Series',
      name: 'series',
      desc: '',
      args: [],
    );
  }

  /// `Observations`
  String get Observaciones {
    return Intl.message(
      'Observations',
      name: 'Observaciones',
      desc: '',
      args: [],
    );
  }

  /// `Add your sensations to the routine`
  String get Observaciones1 {
    return Intl.message(
      'Add your sensations to the routine',
      name: 'Observaciones1',
      desc: '',
      args: [],
    );
  }

  /// `Tonnage`
  String get tonelaje {
    return Intl.message(
      'Tonnage',
      name: 'tonelaje',
      desc: '',
      args: [],
    );
  }

  /// `No history available.`
  String get no_historial {
    return Intl.message(
      'No history available.',
      name: 'no_historial',
      desc: '',
      args: [],
    );
  }

  /// `Progress of`
  String get progreso_historial {
    return Intl.message(
      'Progress of',
      name: 'progreso_historial',
      desc: '',
      args: [],
    );
  }

  /// `Comments`
  String get comentarios {
    return Intl.message(
      'Comments',
      name: 'comentarios',
      desc: '',
      args: [],
    );
  }

  /// `Series`
  String get Serie {
    return Intl.message(
      'Series',
      name: 'Serie',
      desc: '',
      args: [],
    );
  }

  /// `Daily`
  String get Diario {
    return Intl.message(
      'Daily',
      name: 'Diario',
      desc: '',
      args: [],
    );
  }

  /// `Monthly`
  String get Mensual {
    return Intl.message(
      'Monthly',
      name: 'Mensual',
      desc: '',
      args: [],
    );
  }

  /// `Physical Performance`
  String get rendimiento_fisico {
    return Intl.message(
      'Physical Performance',
      name: 'rendimiento_fisico',
      desc: '',
      args: [],
    );
  }

  /// `Mon`
  String get Lun {
    return Intl.message(
      'Mon',
      name: 'Lun',
      desc: '',
      args: [],
    );
  }

  /// `Tue`
  String get Mar {
    return Intl.message(
      'Tue',
      name: 'Mar',
      desc: '',
      args: [],
    );
  }

  /// `Wed`
  String get Mie {
    return Intl.message(
      'Wed',
      name: 'Mie',
      desc: '',
      args: [],
    );
  }

  /// `Thu`
  String get Jue {
    return Intl.message(
      'Thu',
      name: 'Jue',
      desc: '',
      args: [],
    );
  }

  /// `Fri`
  String get Vie {
    return Intl.message(
      'Fri',
      name: 'Vie',
      desc: '',
      args: [],
    );
  }

  /// `Sat`
  String get Sab {
    return Intl.message(
      'Sat',
      name: 'Sab',
      desc: '',
      args: [],
    );
  }

  /// `Sun`
  String get Dom {
    return Intl.message(
      'Sun',
      name: 'Dom',
      desc: '',
      args: [],
    );
  }

  /// `Training Progress`
  String get progreso_entrenamiento {
    return Intl.message(
      'Training Progress',
      name: 'progreso_entrenamiento',
      desc: '',
      args: [],
    );
  }

  /// `Filter`
  String get filtrar {
    return Intl.message(
      'Filter',
      name: 'filtrar',
      desc: '',
      args: [],
    );
  }

  /// `Select Routine`
  String get Seleccionar_rutina {
    return Intl.message(
      'Select Routine',
      name: 'Seleccionar_rutina',
      desc: '',
      args: [],
    );
  }

  /// `Select Exercise`
  String get Seleccionar_ejercicio {
    return Intl.message(
      'Select Exercise',
      name: 'Seleccionar_ejercicio',
      desc: '',
      args: [],
    );
  }

  /// `Graphics`
  String get graficos {
    return Intl.message(
      'Graphics',
      name: 'graficos',
      desc: '',
      args: [],
    );
  }

  /// `Publish  advice`
  String get consejo {
    return Intl.message(
      'Publish  advice',
      name: 'consejo',
      desc: '',
      args: [],
    );
  }

  /// `Write your advice here...`
  String get consejo1 {
    return Intl.message(
      'Write your advice here...',
      name: 'consejo1',
      desc: '',
      args: [],
    );
  }

  /// `Add`
  String get agregar {
    return Intl.message(
      'Add',
      name: 'agregar',
      desc: '',
      args: [],
    );
  }

  /// `Community`
  String get publi {
    return Intl.message(
      'Community',
      name: 'publi',
      desc: '',
      args: [],
    );
  }

  /// `No publications available.`
  String get no_publi {
    return Intl.message(
      'No publications available.',
      name: 'no_publi',
      desc: '',
      args: [],
    );
  }

  /// `No description`
  String get no_descripcion {
    return Intl.message(
      'No description',
      name: 'no_descripcion',
      desc: '',
      args: [],
    );
  }

  /// `Date`
  String get fecha {
    return Intl.message(
      'Date',
      name: 'fecha',
      desc: '',
      args: [],
    );
  }

  /// `Like`
  String get like {
    return Intl.message(
      'Like',
      name: 'like',
      desc: '',
      args: [],
    );
  }

  /// `Delete Publication`
  String get eliminar_publi {
    return Intl.message(
      'Delete Publication',
      name: 'eliminar_publi',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to delete this post?`
  String get eliminar_publi1 {
    return Intl.message(
      'Are you sure you want to delete this post?',
      name: 'eliminar_publi1',
      desc: '',
      args: [],
    );
  }

  /// `Forgot your password?`
  String get recuperar {
    return Intl.message(
      'Forgot your password?',
      name: 'recuperar',
      desc: '',
      args: [],
    );
  }

  /// `A recovery link has been sent to `
  String get recuperar1 {
    return Intl.message(
      'A recovery link has been sent to ',
      name: 'recuperar1',
      desc: '',
      args: [],
    );
  }

  /// `An error occurred`
  String get recuperar2 {
    return Intl.message(
      'An error occurred',
      name: 'recuperar2',
      desc: '',
      args: [],
    );
  }

  /// `No user was found with that email.`
  String get recuperar3 {
    return Intl.message(
      'No user was found with that email.',
      name: 'recuperar3',
      desc: '',
      args: [],
    );
  }

  /// `Recover Password`
  String get recuperar4 {
    return Intl.message(
      'Recover Password',
      name: 'recuperar4',
      desc: '',
      args: [],
    );
  }

  /// `Please enter the email address associated with your account. We will send you a link to reset your password.`
  String get recuperar5 {
    return Intl.message(
      'Please enter the email address associated with your account. We will send you a link to reset your password.',
      name: 'recuperar5',
      desc: '',
      args: [],
    );
  }

  /// `Please enter an email address.`
  String get recuperar6 {
    return Intl.message(
      'Please enter an email address.',
      name: 'recuperar6',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a valid email address.`
  String get recuperar7 {
    return Intl.message(
      'Please enter a valid email address.',
      name: 'recuperar7',
      desc: '',
      args: [],
    );
  }

  /// `Send Link`
  String get recuperar8 {
    return Intl.message(
      'Send Link',
      name: 'recuperar8',
      desc: '',
      args: [],
    );
  }

  /// `Back to login?`
  String get recuperar9 {
    return Intl.message(
      'Back to login?',
      name: 'recuperar9',
      desc: '',
      args: [],
    );
  }

  /// `What do you want to publish?`
  String get publicacion1 {
    return Intl.message(
      'What do you want to publish?',
      name: 'publicacion1',
      desc: '',
      args: [],
    );
  }

  /// `Select an option to continue:`
  String get publicacion2 {
    return Intl.message(
      'Select an option to continue:',
      name: 'publicacion2',
      desc: '',
      args: [],
    );
  }

  /// `Routines and Exercises`
  String get publicacion3 {
    return Intl.message(
      'Routines and Exercises',
      name: 'publicacion3',
      desc: '',
      args: [],
    );
  }

  /// `Publish routine`
  String get publicacion4 {
    return Intl.message(
      'Publish routine',
      name: 'publicacion4',
      desc: '',
      args: [],
    );
  }

  /// `Share Routine`
  String get publicacion5 {
    return Intl.message(
      'Share Routine',
      name: 'publicacion5',
      desc: '',
      args: [],
    );
  }

  /// `Do you want to share the routine`
  String get publicacion6 {
    return Intl.message(
      'Do you want to share the routine',
      name: 'publicacion6',
      desc: '',
      args: [],
    );
  }

  /// `Shared routine:`
  String get publicacion7 {
    return Intl.message(
      'Shared routine:',
      name: 'publicacion7',
      desc: '',
      args: [],
    );
  }

  /// `Routine`
  String get publicacion8 {
    return Intl.message(
      'Routine',
      name: 'publicacion8',
      desc: '',
      args: [],
    );
  }

  /// `Successfully shared.`
  String get publicacion9 {
    return Intl.message(
      'Successfully shared.',
      name: 'publicacion9',
      desc: '',
      args: [],
    );
  }

  /// `Error in sharing the routine.`
  String get publicacion10 {
    return Intl.message(
      'Error in sharing the routine.',
      name: 'publicacion10',
      desc: '',
      args: [],
    );
  }

  /// `Routine saved successfully`
  String get publicacion11 {
    return Intl.message(
      'Routine saved successfully',
      name: 'publicacion11',
      desc: '',
      args: [],
    );
  }

  /// `Error when adding exercises to the routine`
  String get publicacion12 {
    return Intl.message(
      'Error when adding exercises to the routine',
      name: 'publicacion12',
      desc: '',
      args: [],
    );
  }

  /// `Error saving routine`
  String get publicacion13 {
    return Intl.message(
      'Error saving routine',
      name: 'publicacion13',
      desc: '',
      args: [],
    );
  }

  /// `Save routine`
  String get publicacion14 {
    return Intl.message(
      'Save routine',
      name: 'publicacion14',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to save this routine on your list?`
  String get publicacion15 {
    return Intl.message(
      'Are you sure you want to save this routine on your list?',
      name: 'publicacion15',
      desc: '',
      args: [],
    );
  }

  /// `Save routine`
  String get publicacion16 {
    return Intl.message(
      'Save routine',
      name: 'publicacion16',
      desc: '',
      args: [],
    );
  }

  /// `Spanish`
  String get espaniol {
    return Intl.message(
      'Spanish',
      name: 'espaniol',
      desc: '',
      args: [],
    );
  }

  /// `English`
  String get ingles {
    return Intl.message(
      'English',
      name: 'ingles',
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
