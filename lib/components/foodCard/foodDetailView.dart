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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(15, 20, 15, 0),
        child: ListView(
          children: [

            SizedBox(
              height: 30,
            ),

            Center(child: Hero(tag: "${prodHashCode}_avtr", child: avatar)),

            SizedBox(height: 20),

            Text(
              widget.product.productName ?? "Unknown",
              style: TextStyle(
                fontSize: 40,
                fontFamily: GoogleFonts.permanentMarker().fontFamily,
              ),
            ),

            SizedBox(height: 10),
            Divider(),
            SizedBox(height: 10),

            TextField(
              readOnly: true,
              controller: TextEditingController(text: widget.product.brands ?? ""),
              decoration: InputDecoration(
                label: Text("Manufacturer"),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(20))
              ),
            ),
            SizedBox(height: 20),

            TextField(
              readOnly: true,
              controller: TextEditingController(text: widget.product.nutriments!.getValue(Nutrient.energyKCal, PerSize.oneHundredGrams).toString() ?? ""),
              decoration: InputDecoration(
                  label: Text("Energy (${widget.product.nutrimentEnergyUnit ?? "kcal"} / 100g)"),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(20))
              ),
            ),
            SizedBox(height: 20),


            TextField(
              readOnly: true,
              controller: TextEditingController(text: (widget.product.nutriscore ?? "").toUpperCase()),
              decoration: InputDecoration(
                  label: Text("Nutriscore"),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(20))
              ),
            ),
            SizedBox(height: 20),

          ],
        ),
      ),
    );
  }
}
