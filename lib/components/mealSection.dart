import 'package:flutter/material.dart';
import 'package:caloriecounter/components/foodCard.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:caloriecounter/generated/l10n.dart';

class MealSection extends StatefulWidget {

  final String sectionTitle;

  const MealSection({super.key, required this.sectionTitle});

  @override
  State<MealSection> createState() => _MealSectionState();
}

class _MealSectionState extends State<MealSection> {
  @override
  Widget build(BuildContext context) {
    return    SliverList(
      delegate: SliverChildListDelegate([
        Text(
          widget.sectionTitle,
          style: TextStyle(
            color: Colors.white.withAlpha(980),
            fontSize: 40,
            fontFamily: GoogleFonts.permanentMarker().fontFamily,
          ),
        ),

        Text(
          "09:00",
          style: TextStyle(
            color: Colors.grey,
            fontStyle: FontStyle.italic,
          ),
        ),

        SizedBox(height: 20),

        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 200,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              FoodCard(name: "Bread", amount: 120),
              SizedBox(width: 10),
              FoodCard(name: "Cheese", amount: 20),
              SizedBox(width: 10),
              FoodCard(name: "Apple", amount: 130),
              SizedBox(width: 10),
              FoodCard(name: "Pineapple", amount: 20),
            ],
          ),
        ),

        SizedBox(height: 20),
      ]),
    );
  }
}
