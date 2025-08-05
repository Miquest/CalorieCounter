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

  /// `Home`
  String get home {
    return Intl.message(
      'Home',
      name: 'home',
      desc: '',
      args: [],
    );
  }

  /// `Welcome to your calorie diary!`
  String get welcomeSubtitle {
    return Intl.message(
      'Welcome to your calorie diary!',
      name: 'welcomeSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Breakfast`
  String get breakfast {
    return Intl.message(
      'Breakfast',
      name: 'breakfast',
      desc: '',
      args: [],
    );
  }

  /// `Lunch`
  String get lunch {
    return Intl.message(
      'Lunch',
      name: 'lunch',
      desc: '',
      args: [],
    );
  }

  /// `Dinner`
  String get dinner {
    return Intl.message(
      'Dinner',
      name: 'dinner',
      desc: '',
      args: [],
    );
  }

  /// `Reset app`
  String get resetApp {
    return Intl.message(
      'Reset app',
      name: 'resetApp',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get settings {
    return Intl.message(
      'Settings',
      name: 'settings',
      desc: '',
      args: [],
    );
  }

  /// `History`
  String get history {
    return Intl.message(
      'History',
      name: 'history',
      desc: '',
      args: [],
    );
  }

  /// `Encrypt data`
  String get encryptData {
    return Intl.message(
      'Encrypt data',
      name: 'encryptData',
      desc: '',
      args: [],
    );
  }

  /// `You can encrypt your data with a local key`
  String get encryptDataSubtitle {
    return Intl.message(
      'You can encrypt your data with a local key',
      name: 'encryptDataSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Vegetarian mode`
  String get vegetarianMode {
    return Intl.message(
      'Vegetarian mode',
      name: 'vegetarianMode',
      desc: '',
      args: [],
    );
  }

  /// `Vegan mode`
  String get veganMode {
    return Intl.message(
      'Vegan mode',
      name: 'veganMode',
      desc: '',
      args: [],
    );
  }

  /// `Export data`
  String get exportData {
    return Intl.message(
      'Export data',
      name: 'exportData',
      desc: '',
      args: [],
    );
  }

  /// `Export you data as a backup or for another device`
  String get exportDataSubtitle {
    return Intl.message(
      'Export you data as a backup or for another device',
      name: 'exportDataSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Licenses`
  String get licenses {
    return Intl.message(
      'Licenses',
      name: 'licenses',
      desc: '',
      args: [],
    );
  }

  /// `Custom`
  String get custom {
    return Intl.message(
      'Custom',
      name: 'custom',
      desc: '',
      args: [],
    );
  }

  /// `Snacks`
  String get snacks {
    return Intl.message(
      'Snacks',
      name: 'snacks',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `Add an entry for the breakfast`
  String get addBreakfastSubtitle {
    return Intl.message(
      'Add an entry for the breakfast',
      name: 'addBreakfastSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Add an entry for lunch`
  String get addLunchSubtitle {
    return Intl.message(
      'Add an entry for lunch',
      name: 'addLunchSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Add an entry for your dinner`
  String get addDinnerSubtitle {
    return Intl.message(
      'Add an entry for your dinner',
      name: 'addDinnerSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Add a snack to your logbook`
  String get addSnackSubtitle {
    return Intl.message(
      'Add a snack to your logbook',
      name: 'addSnackSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Add an entry to a customized meal`
  String get addCustomSubtitle {
    return Intl.message(
      'Add an entry to a customized meal',
      name: 'addCustomSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Choose amount`
  String get chooseAmount {
    return Intl.message(
      'Choose amount',
      name: 'chooseAmount',
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
