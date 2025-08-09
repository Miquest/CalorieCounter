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
  int amountGrams = 0;
  bool servingSize = false;

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
            initialSelection: "g",
            dropdownMenuEntries: [
              DropdownMenuEntry(value: "g", label: "Grams (g)"),
              DropdownMenuEntry(
                value: "servingSize",
                label: widget.product.servingSize ?? "",
              ),
            ],
            onSelected: (value) {
              servingSize = true;
              if (value == "servingSize") {
                amountGrams = amountGrams * widget.product.servingQuantity!.toInt();
              }
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
              if (servingSize) {
                amountGrams = int.parse(value) * widget.product.servingQuantity!.toInt();
              } else {
                amountGrams = int.parse(value);
              }
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
          onPressed: () => Navigator.of(context).pop(amountGrams),
          child: Text("Ok"),
        ),
      ],
    );
  }
}
