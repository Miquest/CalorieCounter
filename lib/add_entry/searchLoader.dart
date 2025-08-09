import 'package:caloriecounter/components/foodDialogs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:openfoodfacts/openfoodfacts.dart';

class FoodSearchLoader with ChangeNotifier {
  final BuildContext context;

  FoodSearchLoader({required this.context});

  List<Widget> searchResults = [];
  bool loading = false;
  ProductField _field = ProductField.NAME;

  ProductField get field => _field;

  set field(ProductField newField) {
    _field = newField;
    notifyListeners();
  }

  Future<void> searchByString(String searchString) async {
    searchResults = [];
    loading = true;
    notifyListeners();

    OpenFoodAPIConfiguration.userAgent = UserAgent(name: 'Calorie Counter');

    ProductSearchQueryConfiguration configuration =
        ProductSearchQueryConfiguration(
          fields: [ProductField.ALL],
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

    loading = false;
    notifyListeners();
  }

  void addListTile(Product product) {
    try {
      searchResults.add(
        ListTile(
          title: Text(product.productName ?? ""),
          subtitle: Text(
            "Calories (100g): ${product.nutriments!.getValue(Nutrient.energyKCal, PerSize.oneHundredGrams)}",
          ),
          trailing: Icon(Icons.add),
          onTap: () async {
            int? amountGrams = await showDialog(
              context: context,
              builder: (context) => FoodAmountDialog(product: product),
            );

            if (amountGrams != null && context.mounted) {
              Map<String, dynamic> foodMap = product.toJson();
              foodMap["amountGrams"] = amountGrams;
              Navigator.of(context).pop(foodMap);
            }
          },
        ),
      );
    } catch (e) {
      print("Null recieved");
    }
  }
}
