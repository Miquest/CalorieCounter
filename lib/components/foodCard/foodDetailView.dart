import 'package:caloriecounter/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:openfoodfacts/openfoodfacts.dart';

class FoodDetailView extends StatefulWidget {
  final Product product;

  const FoodDetailView({super.key, required this.product});

  @override
  State<FoodDetailView> createState() => _FoodDetailViewState();
}

class _FoodDetailViewState extends State<FoodDetailView> {
  Widget avatar = CircleAvatar(
    minRadius: 80,
    maxRadius: 85,
    child: Icon(Icons.fastfood),
  );

  late String prodHashCode;

  @override
  void initState() {
    prodHashCode = widget.product.hashCode.toString();

    if (widget.product.imageFrontSmallUrl != null) {
      avatar = CircleAvatar(
        minRadius: 80,
        maxRadius: 85,
        backgroundImage: NetworkImage(widget.product.imageFrontSmallUrl!),
      );
    }

    super.initState();
  }

  List<Widget> _ingredientList() {
    List<Widget> ingredientWidgets = [];

    for (Ingredient ingredient in widget.product.ingredients ?? []) {
      ingredientWidgets.add(ListTile(title: Text(ingredient.text ?? "")));
    }

    return ingredientWidgets;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(15, 20, 15, 0),
        child: ListView(
          children: [
            SizedBox(height: 30),

            Center(
              child: Hero(tag: "${prodHashCode}_avtr", child: avatar),
            ),

            SizedBox(height: 20),

            Text(
              widget.product.productName ?? S.of(context).unknown,
              overflow: TextOverflow.fade,
              style: TextStyle(
                fontSize: 40,
                fontFamily: GoogleFonts.permanentMarker().fontFamily,
              ),
            ),

            SizedBox(
              height: 20,
            ),

            Row(
              spacing: 15,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.energy_savings_leaf_outlined,
                      size: 35,
                      color:
                          widget
                                  .product
                                  .ingredientsAnalysisTags
                                  ?.veganStatus
                                  ?.offTag ==
                              "en:vegan"
                          ? Colors.greenAccent
                          : Colors.grey,
                    ),

                    Text(S.of(context).vegan)
                  ],
                ),

                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.energy_savings_leaf,
                      size: 35,
                      color: widget.product.ingredientsAnalysisTags?.vegetarianStatus?.offTag == "en:vegetarian" ? Colors.green : Colors.grey,
                    ),

                    Text(S.of(context).vegetarian)
                  ],
                ),
              ],
            ),

            SizedBox(height: 10),
            Divider(),
            SizedBox(height: 10),

            TextField(
              readOnly: true,
              controller: TextEditingController(
                text: widget.product.brands ?? "",
              ),
              decoration: InputDecoration(
                label: Text(S.of(context).manufacturer),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            SizedBox(height: 20),

            TextField(
              readOnly: true,
              controller: TextEditingController(
                text:
                    widget.product.nutriments!
                        .getValue(Nutrient.energyKCal, PerSize.oneHundredGrams)
                        .toString() ??
                    "",
              ),
              decoration: InputDecoration(
                label: Text(
                  S
                      .of(context)
                      .energy100g(widget.product.nutrimentEnergyUnit ?? "kcal"),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            SizedBox(height: 20),

            TextField(
              readOnly: true,
              controller: TextEditingController(
                text: (widget.product.nutriscore ?? "").toUpperCase(),
              ),
              decoration: InputDecoration(
                label: Text(S.of(context).nutriscore),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            SizedBox(height: 20),

            ExpansionTile(
              collapsedShape: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
                borderRadius: BorderRadius.circular(20),
              ),
              shape: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
                borderRadius: BorderRadius.circular(20),
              ),
              title: Text(S.of(context).ingredients),
              children: _ingredientList(),
            ),

            SizedBox(height: 20),

            TextField(
              readOnly: true,
              controller: TextEditingController(
                text: (widget.product.stores ?? "").toUpperCase(),
              ),
              decoration: InputDecoration(
                label: Text(S.of(context).stores),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
