import 'package:caloriecounter/components/typeCasters.dart';
import 'package:caloriecounter/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:openfoodfacts/openfoodfacts.dart';

class FoodDataLoader with ChangeNotifier {
  final BuildContext context;
  final DateTime date;

  FoodDataLoader({required this.context, required this.date});

  late Map tagMappings;
  late Map stringMappings;

  // Pre define the tag, can be changed later in code
  String tag = "breakfast";
  List<Map<String, dynamic>> selectedFoods = [];
  List<Widget> searchResults = [];
  Map<String, double> nutrimentStats = {"calories": 0, "fat": 0, "carbs": 0};

  void _calculateNutrimentStats() {
    // Reset nutriment stats
    nutrimentStats.map((key, value) => MapEntry(key, 0));

    for (Map<String, dynamic> item in selectedFoods) {
      int amount = item.remove("amountGrams");
      Product product = Product.fromJson(item);

      nutrimentStats["calories"] =
          nutrimentStats["calories"]! +
          (amount / 100) *
              (product.nutriments!.getValue(
                    Nutrient.energyKCal,
                    PerSize.oneHundredGrams,
                  ) ??
                  0);

      nutrimentStats["fat"] =
          nutrimentStats["fat"]! +
          (amount / 100) *
              (product.nutriments!.getValue(
                    Nutrient.fat,
                    PerSize.oneHundredGrams,
                  ) ??
                  0);

      nutrimentStats["carbs"] =
          nutrimentStats["carbs"]! +
          (amount / 100) *
              (product.nutriments!.getValue(
                    Nutrient.carbohydrates,
                    PerSize.oneHundredGrams,
                  ) ??
                  0);
    }

    notifyListeners();
  }

  void _initMappings() {
    tagMappings = {
      S.of(context).breakfast: "breakfast",
      S.of(context).lunch: "lunch",
      S.of(context).dinner: "dinner",
      S.of(context).snacks: "snacks",
    };

    stringMappings = {
      "breakfast": S.of(context).breakfast,
      "lunch": S.of(context).lunch,
      "dinner": S.of(context).dinner,
      "snacks": S.of(context).snacks,
    };
  }

  void addFood(Map<String, dynamic> item) {
    selectedFoods.add(item);
    _calculateNutrimentStats();
    notifyListeners();
  }

  void editFood(Map<String, dynamic> original, Map<String, dynamic> edited) {
    selectedFoods.remove(original);
    selectedFoods.add(edited);
    _calculateNutrimentStats();
    notifyListeners();
  }

  void deleteSelectedFood(Map<String, dynamic> item) {
    selectedFoods.remove(item);
    _calculateNutrimentStats();
    notifyListeners();
  }

  Future<void> loadFromStorage() async {
    _initMappings();
    if (!Hive.isBoxOpen("logbook")) {
      await Hive.openLazyBox("logbook");
    }
    final box = Hive.lazyBox("logbook");

    String boxKey =
        "${date.year}-${date.month.toString().padLeft(2)}-${date.day.toString().padLeft(2)}";

    if (box.containsKey(boxKey)) {
      Map data = await box.get(boxKey);
      if (data.containsKey(tagMappings[tag])) {
        List mealData = (await box.get(boxKey))[tagMappings[tag]];

        for (Map item in mealData) {
          selectedFoods.add(deepCastMap(item));
        }
      }

      _calculateNutrimentStats();
    }

    notifyListeners();
  }

  Future<void> saveToStorage() async {
    _initMappings();

    if (!Hive.isBoxOpen("logbook")) {
      await Hive.openLazyBox("logbook");
    }

    final box = Hive.lazyBox("logbook");

    String boxKey =
        "${date.year}-${date.month.toString().padLeft(2)}-${date.day.toString().padLeft(2)}";

    if (box.containsKey(boxKey)) {
      Map data = await box.get(boxKey);
      data[tagMappings[tag]] = selectedFoods;
      await box.put(boxKey, data);
    } else {
      Map data = {tagMappings[tag]: selectedFoods};
      await box.put(boxKey, data);
    }
  }
}
