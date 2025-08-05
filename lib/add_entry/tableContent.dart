import 'package:caloriecounter/add_entry/foodSearch.dart';
import 'package:caloriecounter/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:openfoodfacts/openfoodfacts.dart';

import 'foodDataLoader.dart';

class TableContentPage extends StatefulWidget {
  final String mealName;

  const TableContentPage({super.key, required this.mealName});

  @override
  State<TableContentPage> createState() => _TableContentPageState();
}

class _TableContentPageState extends State<TableContentPage> {
  late FoodDataLoader loader;

  List<Widget> _buildMealView(List<Map<String, dynamic>> items) {
    List<Widget> tiles = [];

    for (Map<String, dynamic> item in items) {
      Product product = Product.fromJson(item);

      int index = loader.selectedFoods.indexOf(item);
      Map amountConf = loader.amounts[index];

      Widget avatar = CircleAvatar(child: Icon(Icons.fastfood));

      if (product.imageFrontSmallUrl != null) {
        avatar = CircleAvatar(
          backgroundImage: NetworkImage(product.imageFrontSmallUrl ?? ""),
        );
      }

      tiles.add(
        ListTile(
          title: Text(product.productName!),
          subtitle: Text(
            "Amount: ${amountConf["amount"]} ${amountConf["unit"]} ",
          ),
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
  void initState() {
    loader = FoodDataLoader(context: context);
    loader.loadFromStorage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                    children: _buildMealView(loader.selectedFoods),
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
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => FoodSearch(loader: loader),
                      ),
                    );
                  },
                  icon: Icon(Icons.add),
                ),

                FilledButton(onPressed: () {
                  loader.saveToStorage();
                  Navigator.of(context).pop();
                }, child: Text("Save")),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
