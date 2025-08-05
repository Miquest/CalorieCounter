import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:openfoodfacts/openfoodfacts.dart';

import 'foodDialogs.dart';

class FoodDataLoader with ChangeNotifier {
  BuildContext context;

  FoodDataLoader({required this.context});

  List<Widget> results = [];

  List<Map<String, dynamic>> selectedFoods = [];
  List amounts = [];

  void deleteSelectedFood(Map<String, dynamic> item) {
    int index = selectedFoods.indexOf(item);
    amounts.removeAt(index);
    selectedFoods.removeAt(index);
    notifyListeners();
  }

  Future<void> loadFromStorage() async {
    notifyListeners();
  }

  Future<void> saveToStorage() async {
    /// Implement saving function
  }

  Future<void> searchByString(String searchString) async {
    this.results = [];

    OpenFoodAPIConfiguration.userAgent = UserAgent(name: 'Calorie Counter');

    ProductSearchQueryConfiguration configuration =
        ProductSearchQueryConfiguration(
          parametersList: [
            SearchTerms(terms: [searchString]),
          ],
          version: ProductQueryVersion.v3,
        );

    SearchResult results = await OpenFoodAPIClient.searchProducts(
      User(
        userId: dotenv.env["OPENFOODFACTS_USER"]!,
        password: dotenv.env["OPENFOODFACTS_PASS"]!,
      ),
      configuration,
    );

    for (Product product in results.products ?? []) {
      addListTile(product);
    }

    notifyListeners();
  }

  void addListTile(Product product) {
    try {
      results.add(
        ListTile(
          title: Text(product.productName ?? ""),
          subtitle: Text(
            "Calories (100g): ${product.nutriments!.getValue(Nutrient.energyKCal, PerSize.oneHundredGrams)}",
          ),
          trailing: Icon(Icons.add),
          onTap: () async {
            Map? amount = await showDialog(
              context: context,
              builder: (context) => FoodAmountDialog(product: product),
            );

            if (amount != null) {
              amounts.add(amount);
              selectedFoods.add(product.toJson());
              notifyListeners();
            }
          },
        ),
      );
    } catch (e) {
      print("Null recieved");
    }
  }
}
