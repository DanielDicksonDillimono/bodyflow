import 'package:flutter/material.dart';

class AppLocalization {
  static AppLocalization of(BuildContext context) {
    return Localizations.of<AppLocalization>(context, AppLocalization)!;
  }

  static const _strings = <String, String>{
    // App and Authentication
    'app_name': 'BodyFlow',
    'bodyflow': 'BODYFLOW',
    'welcome': 'Welcome',
    'welcome_message': 'Welcome to Body Therapy',
    'login': 'Login',
    'name': 'Name',
    'sign_up': 'Sign Up',
    'email': 'Email',
    'password': 'Password',
    'confirm_password': 'Confirm Password',
    'repeat_password': 'Repeat Password',
    'forgot_password': 'Forgot Password?',
    'create_account': 'Create Account',
    'already_have_account': 'Already have an account',
    'dont_have_account': "Don't have an account?",
    'password_recovery': 'Password\nRecovery',
    'password_reset_instruction': 'Enter email to receive a password reset link',
    'reset': 'Reset',
    
    // Navigation
    'home': 'Home',
    'create': 'Create',
    'me': 'Me',
    'exercises': 'Exercises',
    'reports': 'Reports',
    'preferences': 'Preferences',
    
    // Home Page
    'recently_generated': 'Recently generated',
    'quick_workouts': 'Quick Workouts',
    'workout_a': 'Workout A',
    'full_body_blast': 'Full Body Blast',
    'minutes_45': '45 mins',
    'minutes_text': 'minutes',
    
    // Generator Page
    'generator': 'Generator',
    'generator_subtitle': 'Create workout sessions or schedules',
    'generator_description': 'Workouts are one-time sessions, while schedules are recurring plans.',
    'workout': 'Workout',
    'schedule': 'Schedule',
    'split': 'Split',
    'days': 'Days',
    'time': 'Time',
    'time_in_minutes': ' (in minutes)',
    'enter_session_length': 'Enter session length in minutes',
    'target': 'Target',
    'generate': 'Generate',
    
    // Workout and Exercise Pages
    'legs': 'LEGS',
    'squats': 'squats, deadlifts, lunges',
    'sets': 'Sets',
    'reps': 'Reps',
    'duration': 'Duration',
    'instructions': 'Instructions',
    
    // Profile Page
    'last_months_stats': 'Last Months Stats',
    'about_bodyflow': 'About BodyFlow',
    'sign_out': 'Sign out',
    'delete_account': 'Delete Account',
    'visit_website': 'Visit Website',
    'licenses': 'Licenses',
    
    // Validation and Errors
    'get_a_life': 'Get a life!',
    'get_a_life_message': 'More than 2 hour workout? You should really get a life outside of the gym.',
    'ok': 'OK',
    'no_body_parts_selected': 'No body parts selected',
    'select_body_part_message': 'Please select at least one body part to generate a workout.',
    'no_days_selected': 'No days selected',
    'select_day_message': 'Please select at least one day for your schedule.',
    'invalid_duration': 'Invalid duration',
    'invalid_duration_message': 'Please enter a valid session length greater than 0 minutes.',
    
    // Existing strings
    'login_message': 'Please login to continue',
    'sign_up_message': 'Create Account',
    'submit': 'Submit',
    'cancel': 'Cancel',
    'settings': 'Settings',
    'language': 'Language',
    'dark_mode': 'Dark Mode',
    'light_mode': 'Light Mode',
    'enter_email': 'Enter your email',
    'enter_password': 'Enter your password',
    'enter_email_or_password': 'Please enter your email or password',
    'enter_valid_password': 'Please enter a valid password',
    'sign_up_error': 'Sign Up Error',
    'login_button_text': 'Login',
    'sign_up_button_text': 'Sign Up',
    'email_validation': 'Please enter a valid email',
    'enter_confirm_password': 'Confirm your password',
    'enter_valid_name': 'Please enter a valid name',
    'sign_up_failed': 'Sign Up Failed',
    'create_report': 'Create Report',
    'accept_terms': 'Please accept the terms and conditions',
    'terms_conditions': 'Open Terms and Conditions',
    'i_accept': 'I Accept',
    'disclaimer':
        'This app is not a substitute for professional medical advice, diagnosis, or treatment. Always seek the advice of your physician or other qualified health provider with any questions you may have regarding a medical condition.',
  };

  //in case the key is not found, it will return the key itself
  static String _get(String key) {
    return _strings[key] ?? key;
  }

  // App and Authentication
  String get appName => _get('app_name');
  String get bodyflow => _get('bodyflow');
  String get welcome => _get('welcome');
  String get welcomeMessage => _get('welcome_message');
  String get login => _get('login');
  String get name => _get('name');
  String get signUp => _get('sign_up');
  String get email => _get('email');
  String get password => _get('password');
  String get confirmPassword => _get('confirm_password');
  String get repeatPassword => _get('repeat_password');
  String get forgotPassword => _get('forgot_password');
  String get createAccount => _get('create_account');
  String get alreadyHaveAccount => _get('already_have_account');
  String get dontHaveAccount => _get('dont_have_account');
  String get passwordRecovery => _get('password_recovery');
  String get passwordResetInstruction => _get('password_reset_instruction');
  String get reset => _get('reset');
  
  // Navigation
  String get home => _get('home');
  String get create => _get('create');
  String get me => _get('me');
  String get exercises => _get('exercises');
  String get reports => _get('reports');
  String get preferences => _get('preferences');
  
  // Home Page
  String get recentlyGenerated => _get('recently_generated');
  String get quickWorkouts => _get('quick_workouts');
  String get workoutA => _get('workout_a');
  String get fullBodyBlast => _get('full_body_blast');
  String get minutes45 => _get('minutes_45');
  String get minutesText => _get('minutes_text');
  
  // Generator Page
  String get generator => _get('generator');
  String get generatorSubtitle => _get('generator_subtitle');
  String get generatorDescription => _get('generator_description');
  String get workout => _get('workout');
  String get schedule => _get('schedule');
  String get split => _get('split');
  String get days => _get('days');
  String get time => _get('time');
  String get timeInMinutes => _get('time_in_minutes');
  String get enterSessionLength => _get('enter_session_length');
  String get target => _get('target');
  String get generate => _get('generate');
  
  // Workout and Exercise Pages
  String get legs => _get('legs');
  String get squats => _get('squats');
  String get sets => _get('sets');
  String get reps => _get('reps');
  String get duration => _get('duration');
  String get instructions => _get('instructions');
  
  // Profile Page
  String get lastMonthsStats => _get('last_months_stats');
  String get aboutBodyflow => _get('about_bodyflow');
  String get signOut => _get('sign_out');
  String get deleteAccount => _get('delete_account');
  String get visitWebsite => _get('visit_website');
  String get licenses => _get('licenses');
  
  // Validation and Errors
  String get getALife => _get('get_a_life');
  String get getALifeMessage => _get('get_a_life_message');
  String get ok => _get('ok');
  String get noBodyPartsSelected => _get('no_body_parts_selected');
  String get selectBodyPartMessage => _get('select_body_part_message');
  String get noDaysSelected => _get('no_days_selected');
  String get selectDayMessage => _get('select_day_message');
  String get invalidDuration => _get('invalid_duration');
  String get invalidDurationMessage => _get('invalid_duration_message');
  
  // Existing strings
  String get loginMessage => _get('login_message');
  String get signUpMessage => _get('sign_up_message');
  String get submit => _get('submit');
  String get cancel => _get('cancel');
  String get settings => _get('settings');
  String get language => _get('language');
  String get darkMode => _get('dark_mode');
  String get lightMode => _get('light_mode');
  String get enterEmail => _get('enter_email');
  String get enterPassword => _get('enter_password');
  String get enterConfirmPassword => _get('confirm_password');
  String get enterEmailOrPassword => _get('enter_email_or_password');
  String get enterValidEmail => _get('email_validation');
  String get enterValidPassword => _get('enter_valid_password');
  String get signUpError => _get('sign_up_error');
  String get loginButtonText => _get('login_button_text');
  String get signUpButtonText => _get('sign_up_button_text');
  String get enterValidName => _get('enter_valid_name');
  String get signUpFailed => _get('key_sign_up_failed');
  String get createReport => _get('Create Report');
  String get acceptTerms => _get('accept_terms');
  String get termsConditions => _get('terms_conditions');
  String get iAccept => _get('i_accept');
  String get disclaimer => _get('disclaimer');

  String defaultError(String message) =>
      '$message An error occurred. Please try again.';

  String get emailRegex => r'^[^@]+@[^@]+\.[^@]+';
}

class AppLocalizationDelegate extends LocalizationsDelegate<AppLocalization> {
  const AppLocalizationDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['en', 'es', 'nl', 'de'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalization> load(Locale locale) async {
    return AppLocalization();
  }

  @override
  bool shouldReload(AppLocalizationDelegate old) => false;
}
