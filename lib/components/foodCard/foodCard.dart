import 'package:caloriecounter/components/foodCard/foodDetailView.dart';
import 'package:flutter/material.dart';
import 'package:openfoodfacts/openfoodfacts.dart';

class FoodCard extends StatefulWidget {
  final Map<String, dynamic> foodMap;

  const FoodCard({super.key, required this.foodMap});

  @override
  State<FoodCard> createState() => _FoodCardState();
}

class _FoodCardState extends State<FoodCard> {
  Widget avatar = CircleAvatar(
    minRadius: 30,
    maxRadius: 35,
    child: Icon(Icons.fastfood),
  );

  late String prodHashCode;
  late Product product;
  late int amount;

  @override
  void initState() {
    amount = widget.foodMap["amountGrams"];
    product = Product.fromJson(widget.foodMap);
    prodHashCode = product.hashCode.toString();

    if (product.imageFrontSmallUrl != null) {
      avatar = CircleAvatar(
        minRadius: 30,
        maxRadius: 35,
        backgroundImage: NetworkImage(product.imageFrontSmallUrl!),
      );
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => FoodDetailView(product: product),
            ),
          );
        },
        child: Card.outlined(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Hero(tag: "${prodHashCode}_avtr", child: avatar),

              SizedBox(height: 20),

              Text(
                product.productName ?? "Unknown",
                textAlign: TextAlign.center,
              ),

              SizedBox(height: 10),

              Text(
                "${amount}g",
                style: TextStyle(color: Colors.grey),
              ),

              SizedBox(height: 5),

              Text(
                "${(amount / 100 * product.nutriments!.getValue(Nutrient.energyKCal, PerSize.oneHundredGrams)!).roundToDouble()} kcal",
                style: TextStyle(color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
