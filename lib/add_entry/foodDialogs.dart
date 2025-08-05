import 'package:caloriecounter/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:openfoodfacts/openfoodfacts.dart';

class FoodAmountDialog extends StatefulWidget {
  final Product product;

  const FoodAmountDialog({super.key, required this.product});

  @override
  State<FoodAmountDialog> createState() => _FoodAmountDialogState();
}

class _FoodAmountDialogState extends State<FoodAmountDialog> {
  Map amount = {"amount": 1, "unit": "grams"};

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(S.of(context).chooseAmount),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        spacing: 15,
        children: [
          SizedBox(height: 5),

          DropdownMenu(
            inputDecorationTheme: InputDecorationTheme(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            width: double.infinity,
            label: Text("Unit"),
            initialSelection: "grams",
            dropdownMenuEntries: [
              DropdownMenuEntry(value: "grams", label: "Grams (g)"),
              DropdownMenuEntry(
                value: "servingSize",
                label: "Serving Size (${widget.product.servingSize ?? "100g"})",
              ),
            ],
            onSelected: (value) {
              amount["unit"] = value;
            },
          ),

          TextField(
            controller: TextEditingController(text: "1"),
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              label: Text("Amount"),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            onChanged: (value) {
              amount["amount"] = int.parse(value);
            },
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(S.of(context).cancel),
        ),

        TextButton(
          onPressed: () => Navigator.of(context).pop(amount),
          child: Text("Ok"),
        ),
      ],
    );
  }
}