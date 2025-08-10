import 'package:caloriecounter/components/foodCard/foodCard.dart';
import 'package:caloriecounter/components/foodDataLoader.dart';
import 'package:caloriecounter/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MealSection extends StatefulWidget {
  final String sectionTag;
  final DateTime date;

  const MealSection({
    super.key,
    required this.sectionTag,
    required this.date
  });

  @override
  State<MealSection> createState() => _MealSectionState();
}

class _MealSectionState extends State<MealSection> {
  late Map stringMappings;
  late FoodDataLoader loader;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    loader = FoodDataLoader(context: context, date: widget.date);
    loader.tag = widget.sectionTag;
    loader.selectedFoods = [];
    loader.loadFromStorage();

    stringMappings = {
      "breakfast": S.of(context).breakfast,
      "lunch": S.of(context).lunch,
      "dinner": S.of(context).dinner,
      "snacks": S.of(context).snacks,
    };

    return SliverList(
      delegate: SliverChildListDelegate([
        Text(
          stringMappings[widget.sectionTag] ?? "Custom",
          style: TextStyle(
            color: Colors.white.withAlpha(980),
            fontSize: 40,
            fontFamily: GoogleFonts.permanentMarker().fontFamily,
          ),
        ),

        /*
        Text(
          "09:00",
          style: TextStyle(color: Colors.grey, fontStyle: FontStyle.italic),
        ),
        */


        SizedBox(height: 20),

        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 220,
          child: ListenableBuilder(
            listenable: loader,
            builder: (BuildContext context, Widget? child) {

              if (loader.selectedFoods.isNotEmpty) {
                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: loader.selectedFoods.length,
                  itemBuilder: (BuildContext context, index) {
                    return FoodCard(foodMap: loader.selectedFoods[index]);
                  },
                );
              }

              return Icon(Icons.dnd_forwardslash, size: 60, color: Colors.grey);
            },
          ),
        ),

        SizedBox(height: 20),
      ]),
    );
  }
}
