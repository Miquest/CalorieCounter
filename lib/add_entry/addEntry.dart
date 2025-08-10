import 'package:caloriecounter/add_entry/mealContent.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:caloriecounter/generated/l10n.dart';

class AddEntry extends StatefulWidget {
  const AddEntry({super.key});

  @override
  State<AddEntry> createState() => _AddEntryState();
}

class _AddEntryState extends State<AddEntry> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.fromLTRB(15, 20, 15, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 30),

            Text(
              "Logbook",
              style: TextStyle(
                fontSize: 50,
                fontFamily: GoogleFonts.permanentMarker().fontFamily,
              ),
            ),

            SizedBox(height: 30),

            ListTile(
              leading: Icon(Icons.sunny),
              title: Text(S.of(context).breakfast),
              trailing: Icon(Icons.keyboard_arrow_right),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => MealContentPage(mealName: "breakfast"))
                );
              },
            ),

            ListTile(
              leading: Icon(Icons.fastfood),
              title: Text(S.of(context).lunch),
              trailing: Icon(Icons.keyboard_arrow_right),
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => MealContentPage(mealName: "lunch"))
                );
              },
            ),

            ListTile(
              leading: Icon(Icons.nightlight),
              title: Text(S.of(context).dinner),
              trailing: Icon(Icons.keyboard_arrow_right),
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => MealContentPage(mealName: "dinner"))
                );
              },
            ),

            ListTile(
              leading: Icon(Icons.emoji_food_beverage),
              title: Text(S.of(context).snacks),
              trailing: Icon(Icons.keyboard_arrow_right),
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => MealContentPage(mealName: "snacks"))
                );
              },
            ),

            SizedBox(height: 20),

            OutlinedButton(
              onPressed: () => Navigator.of(context).pop(),
              child: SizedBox(
                width: double.infinity,
                child: Center(child: Text(S.of(context).cancel)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
