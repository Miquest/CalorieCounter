// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a de locale. All the
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
  String get localeName => 'de';

  static String m0(calories) => "Kalorien (100g): ${calories}";

  static String m1(unit) => "Energie (${unit} / 100g)";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "amount": MessageLookupByLibrary.simpleMessage("Menge"),
        "brand": MessageLookupByLibrary.simpleMessage("Hersteller"),
        "breakfast": MessageLookupByLibrary.simpleMessage("Frühstück"),
        "calorieIntakeKcal":
            MessageLookupByLibrary.simpleMessage("Kalorien (kcal)"),
        "calorieSubtitle": m0,
        "calories": MessageLookupByLibrary.simpleMessage("Kalorien"),
        "cancel": MessageLookupByLibrary.simpleMessage("Abbrechen"),
        "carbIntakeG":
            MessageLookupByLibrary.simpleMessage("Kohlenhydrate (g)"),
        "carbs": MessageLookupByLibrary.simpleMessage("Kohlenhydrate"),
        "chooseAmount": MessageLookupByLibrary.simpleMessage("Menge wählen"),
        "dinner": MessageLookupByLibrary.simpleMessage("Abendbrot"),
        "encryptDataSubtitle": MessageLookupByLibrary.simpleMessage(
            "You can encrypt your data with a local key"),
        "energy100g": m1,
        "exportData": MessageLookupByLibrary.simpleMessage("Daten exportieren"),
        "exportDataSubtitle": MessageLookupByLibrary.simpleMessage(
            "Exportiere deine Daten als Backup oder für ein anderes Gerät"),
        "fat": MessageLookupByLibrary.simpleMessage("Fett"),
        "fatIntakeG": MessageLookupByLibrary.simpleMessage("Fett (g)"),
        "gramsText": MessageLookupByLibrary.simpleMessage("Gramm (g)"),
        "history": MessageLookupByLibrary.simpleMessage("Verlauf"),
        "home": MessageLookupByLibrary.simpleMessage("Home"),
        "ingredients": MessageLookupByLibrary.simpleMessage("Inhaltsstoffe"),
        "intakeGoals": MessageLookupByLibrary.simpleMessage("Ernährungsziele"),
        "licenses": MessageLookupByLibrary.simpleMessage("Lizenzen"),
        "lunch": MessageLookupByLibrary.simpleMessage("Mittagessen"),
        "manufacturer": MessageLookupByLibrary.simpleMessage("Hersteller"),
        "name": MessageLookupByLibrary.simpleMessage("Name"),
        "nutriscore": MessageLookupByLibrary.simpleMessage("Nutriscore"),
        "preferences": MessageLookupByLibrary.simpleMessage("Präferenzen"),
        "protein": MessageLookupByLibrary.simpleMessage("Protein"),
        "proteinIntakeG": MessageLookupByLibrary.simpleMessage("Proteine (g)"),
        "resetApp": MessageLookupByLibrary.simpleMessage("Zurücksetzen"),
        "save": MessageLookupByLibrary.simpleMessage("Speichern"),
        "search": MessageLookupByLibrary.simpleMessage("Suche"),
        "searchProduct":
            MessageLookupByLibrary.simpleMessage("Produkt suchen..."),
        "settings": MessageLookupByLibrary.simpleMessage("Einstellungen"),
        "snacks": MessageLookupByLibrary.simpleMessage("Snacks"),
        "stores": MessageLookupByLibrary.simpleMessage("Vertriebe"),
        "type": MessageLookupByLibrary.simpleMessage("Kategorie"),
        "unit": MessageLookupByLibrary.simpleMessage("Einheit"),
        "unknown": MessageLookupByLibrary.simpleMessage("Unbekannt"),
        "vegan": MessageLookupByLibrary.simpleMessage("Vegan"),
        "veganMode": MessageLookupByLibrary.simpleMessage("Veganer Modus"),
        "vegetarian": MessageLookupByLibrary.simpleMessage("Vegetarisch"),
        "vegetarianMode":
            MessageLookupByLibrary.simpleMessage("Vegetarier Modus"),
        "welcomeSubtitle": MessageLookupByLibrary.simpleMessage(
            "Wilkommen bei deinem Kalorientagebuch!")
      };
}
