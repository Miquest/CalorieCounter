// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  static String m0(calories) => "Calories (100g): ${calories}";

  static String m1(unit) => "Energy (${unit} / 100g)";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "amount": MessageLookupByLibrary.simpleMessage("Amount"),
    "brand": MessageLookupByLibrary.simpleMessage("Brand"),
    "breakfast": MessageLookupByLibrary.simpleMessage("Breakfast"),
    "calorieIntakeKcal": MessageLookupByLibrary.simpleMessage(
      "Calorie intake (kcal)",
    ),
    "calorieSubtitle": m0,
    "calories": MessageLookupByLibrary.simpleMessage("Calories"),
    "cancel": MessageLookupByLibrary.simpleMessage("Cancel"),
    "carbIntakeG": MessageLookupByLibrary.simpleMessage("Carb intake (g)"),
    "carbs": MessageLookupByLibrary.simpleMessage("Carbs"),
    "chooseAmount": MessageLookupByLibrary.simpleMessage("Choose amount"),
    "dinner": MessageLookupByLibrary.simpleMessage("Dinner"),
    "encryptData": MessageLookupByLibrary.simpleMessage("Encrypt data"),
    "encryptDataSubtitle": MessageLookupByLibrary.simpleMessage(
      "You can encrypt your data with a local key",
    ),
    "energy100g": m1,
    "exportData": MessageLookupByLibrary.simpleMessage("Export data"),
    "exportDataSubtitle": MessageLookupByLibrary.simpleMessage(
      "Export you data as a backup or for another device",
    ),
    "fat": MessageLookupByLibrary.simpleMessage("Fat"),
    "fatIntakeG": MessageLookupByLibrary.simpleMessage("Fat intake (g)"),
    "gramsText": MessageLookupByLibrary.simpleMessage("Grams (g)"),
    "history": MessageLookupByLibrary.simpleMessage("History"),
    "home": MessageLookupByLibrary.simpleMessage("Home"),
    "ingredients": MessageLookupByLibrary.simpleMessage("Ingredients"),
    "intakeGoals": MessageLookupByLibrary.simpleMessage("Intake goals"),
    "licenses": MessageLookupByLibrary.simpleMessage("Licenses"),
    "lunch": MessageLookupByLibrary.simpleMessage("Lunch"),
    "manufacturer": MessageLookupByLibrary.simpleMessage("Manufacturer"),
    "name": MessageLookupByLibrary.simpleMessage("Name"),
    "nutriscore": MessageLookupByLibrary.simpleMessage("Nutriscore"),
    "preferences": MessageLookupByLibrary.simpleMessage("Preferences"),
    "protein": MessageLookupByLibrary.simpleMessage("Protein"),
    "proteinIntakeG": MessageLookupByLibrary.simpleMessage(
      "Protein intake (g)",
    ),
    "resetApp": MessageLookupByLibrary.simpleMessage("Reset app"),
    "save": MessageLookupByLibrary.simpleMessage("Save"),
    "search": MessageLookupByLibrary.simpleMessage("Search"),
    "searchProduct": MessageLookupByLibrary.simpleMessage("Search product..."),
    "settings": MessageLookupByLibrary.simpleMessage("Settings"),
    "snacks": MessageLookupByLibrary.simpleMessage("Snacks"),
    "stores": MessageLookupByLibrary.simpleMessage("Stores"),
    "type": MessageLookupByLibrary.simpleMessage("Type"),
    "unit": MessageLookupByLibrary.simpleMessage("Unit"),
    "unknown": MessageLookupByLibrary.simpleMessage("Unknown"),
    "vegan": MessageLookupByLibrary.simpleMessage("Vegan"),
    "veganMode": MessageLookupByLibrary.simpleMessage("Vegan mode"),
    "vegetarian": MessageLookupByLibrary.simpleMessage("Vegetarian"),
    "vegetarianMode": MessageLookupByLibrary.simpleMessage("Vegetarian mode"),
    "welcomeSubtitle": MessageLookupByLibrary.simpleMessage(
      "Welcome to your calorie diary!",
    ),
  };
}
