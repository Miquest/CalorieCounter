import 'package:caloriecounter/add_entry/foodSearch.dart';
import 'package:caloriecounter/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:openfoodfacts/openfoodfacts.dart';

import '../components/foodDataLoader.dart';

class TableContentPage extends StatefulWidget {
  final String mealName;

  const TableContentPage({super.key, required this.mealName});

  @override
  State<TableContentPage> createState() => _TableContentPageState();
}

class _TableContentPageState extends State<TableContentPage> {
  late FoodDataLoader loader;

  List<Widget> _buildMealView() {
    List<Widget> tiles = [];

    for (Map<String, dynamic> item in loader.selectedFoods) {
      int amountGrams = item.remove("amountGrams");
      Product product = Product.fromJson(item);

      Widget avatar = CircleAvatar(child: Icon(Icons.fastfood));

      if (product.imageFrontSmallUrl != null) {
        avatar = CircleAvatar(
          backgroundImage: NetworkImage(product.imageFrontSmallUrl ?? ""),
        );
      }

      tiles.add(
        ListTile(
          title: Text(product.productName!),
          subtitle: Text("${amountGrams}g"),
          leading: avatar,
          trailing: IconButton(
            onPressed: () {
              loader.deleteSelectedFood(item);
            },
            icon: Icon(Icons.delete),
          ),
        ),
      );
    }

    return tiles;
  }

  @override
  Widget build(BuildContext context) {
    loader = FoodDataLoader(context: context, date: DateTime.now());
    loader.loadFromStorage();
    loader.tag = widget.mealName;

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.fromLTRB(15, 20, 15, 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: [
            SizedBox(height: 30),

            Text(
              widget.mealName,
              style: TextStyle(
                fontFamily: GoogleFonts.permanentMarker().fontFamily,
                fontSize: 50,
              ),
            ),

            ListenableBuilder(
              listenable: loader,
              builder: (BuildContext context, Widget? child) {
                return Flexible(
                  child: ListView(
                    children: _buildMealView(),
                  ),
                );
              },
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                OutlinedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(S.of(context).cancel),
                ),

                IconButton(
                  iconSize: 30,
                  onPressed: () async {
                    Map<String, dynamic>? selectedFood =
                        await Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => FoodSearch(),
                          ),
                        );

                    if (selectedFood != null) {
                      loader.addFood(selectedFood);
                    }
                  },
                  icon: Icon(Icons.add),
                ),

                FilledButton(
                  onPressed: () {
                    loader.saveToStorage();
                    Navigator.of(context).pop();
                  },
                  child: Text(S.of(context).save),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
