import 'package:caloriecounter/components/foodDataLoader.dart';
import 'package:caloriecounter/components/foodDialogs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:openfoodfacts/openfoodfacts.dart';
import 'package:caloriecounter/generated/l10n.dart';
import 'package:hive_flutter/hive_flutter.dart';

class FoodSearchLoader with ChangeNotifier {
  final BuildContext context;
  final FoodDataLoader foodLoader;

  FoodSearchLoader({required this.context, required this.foodLoader});

  List<Widget> searchResults = [];
  bool loading = false;
  ProductField _field = ProductField.NAME;

  ProductField get field => _field;

  set field(ProductField newField) {
    _field = newField;
    notifyListeners();
  }


  Future<void> searchByBarcode(String barcode) async {

    if (!Hive.isBoxOpen("settings")) {
      await Hive.openBox("settings");
    }

    searchResults = [];
    loading = true;
    notifyListeners();

    OpenFoodAPIConfiguration.userAgent = UserAgent(name: 'Calorie Counter');
    OpenFoodAPIConfiguration.globalCountry = OpenFoodFactsCountry.fromOffTag(Localizations.localeOf(context).countryCode);

    ProductResultV3? result = await OpenFoodAPIClient.getProductV3(
      ProductQueryConfiguration(barcode, version: ProductQueryVersion.v3)
    );

    if (result.product != null) {
      addListTile(result.product!);
    }

    loading = false;
    notifyListeners();
  }

  Future<void> searchByString(String searchString) async {

    if (!Hive.isBoxOpen("settings")) {
      await Hive.openBox("settings");
    }

    final settingsBox = Hive.box("settings");

    OpenFoodAPIConfiguration.userAgent = UserAgent(name: 'Calorie Counter');
    OpenFoodAPIConfiguration.globalCountry = OpenFoodFactsCountry.fromOffTag(Localizations.localeOf(context).countryCode);

    searchResults = [];
    loading = true;
    notifyListeners();

    ProductSearchQueryConfiguration configuration =
        ProductSearchQueryConfiguration(
          fields: [ProductField.ALL],
          parametersList: [
            SearchTerms(terms: [searchString]),
          ],
          language: OpenFoodFactsLanguage.fromOffTag(Localizations.localeOf(context).countryCode),
          version: ProductQueryVersion.v3,
        );

    SearchResult results = await OpenFoodAPIClient.searchProducts(
      User(
        userId: dotenv.env["OPENFOODFACTS_USER"]!,
        password: dotenv.env["OPENFOODFACTS_PASS"]!,
      ),
      configuration,
    );

    List<Product> products = results.products ?? [];

    if (settingsBox.get("vegetarianMode", defaultValue: false)) {
      products = products.where((x) => x.ingredientsAnalysisTags?.vegetarianStatus?.offTag == "en:vegetarian").toList();
    }

    if (settingsBox.get("veganMode", defaultValue: false)){
      products = products.where((x) => x.ingredientsAnalysisTags?.veganStatus?.offTag == "en:vegan").toList();
    }

    for (Product product in products) {
      addListTile(product);
    }

    loading = false;
    notifyListeners();
  }

  void addListTile(Product product) {
    try {
      searchResults.add(
        ListTile(
          title: Text(product.productName!),
          subtitle: Text(
            S.of(context).calorieSubtitle(product.nutriments!.getValue(Nutrient.energyKCal, PerSize.oneHundredGrams).toString()),
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
              foodLoader.addFood(foodMap);
            }
          },
        ),
      );
    } catch (e) {
      print("Null recieved");
    }
  }
}
