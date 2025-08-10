import 'package:caloriecounter/components/foodDataLoader.dart';
import 'package:caloriecounter/components/mealSection.dart';
import 'package:caloriecounter/components/progress_arc.dart';
import 'package:caloriecounter/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:hive_flutter/hive_flutter.dart';

class History extends StatefulWidget {
  const History({super.key});

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  late FoodDataLoader loader;
  final box = Hive.box("settings");

  List<String> sectionTags = ["breakfast", "lunch", "dinner", "snacks"];
  List<Widget> sections = [];

  DateTime selectedDate = DateTime.now();

  Future<void> _selectNewDate() async {
    DateTime? newDate = await showDatePicker(
      context: context,
      firstDate: DateTime.fromMicrosecondsSinceEpoch(0),
      lastDate: DateTime.now().add(Duration(days: 365)),
    );
    _loadNewData(newDate ?? selectedDate);
  }

  Future<void> _loadNewData(DateTime date) async {
    sections = [];
    loader.nutrimentStats = loader.nutrimentStats.map(
      (key, value) => MapEntry(key, 0),
    );
    loader.date = date;
    await loader.loadFromStorage();

    for (String section in sectionTags) {
      sections.add(MealSection(sectionTag: section, date: date));
    }

    setState(() {
      selectedDate = date;
    });
  }

  @override
  void initState() {
    loader = FoodDataLoader(context: context, date: selectedDate);
    sections = [];

    for (String section in sectionTags) {
      sections.add(MealSection(sectionTag: section, date: selectedDate));
    }

    initializeDateFormatting();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    loader.loadFromStorage();

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.fromLTRB(15, 20, 15, 0),
        child: CustomScrollView(
          slivers: [
            SliverList(
              delegate: SliverChildListDelegate([
                SizedBox(height: 40),

                Text(
                  S.of(context).history,
                  style: TextStyle(
                    fontFamily: GoogleFonts.permanentMarker().fontFamily,
                    fontSize: 50,
                  ),
                ),

                SizedBox(height: 20),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {
                        _loadNewData(selectedDate.subtract(Duration(days: 1)));
                      },
                      icon: Icon(Icons.keyboard_arrow_left),
                    ),

                    GestureDetector(
                      onTap: _selectNewDate,
                      child: Chip(
                        label: Text(DateFormat.yMMMd().format(selectedDate)),
                        avatar: Icon(Icons.calendar_month),
                      ),
                    ),

                    IconButton(
                      onPressed: () {
                        _loadNewData(selectedDate.add(Duration(days: 1)));
                      },
                      icon: Icon(Icons.keyboard_arrow_right),
                    ),
                  ],
                ),

                SizedBox(height: 40),

                ListenableBuilder(
                  listenable: loader,
                  builder: (BuildContext context, Widget? child) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          spacing: 15,
                          children: [
                            ProgressArc(
                              value: (loader.nutrimentStats["calories"] ?? 0).toString(),
                              unit: "kcal",
                              fontSize: 20,
                              progress: (loader.nutrimentStats["calories"] ?? 0) / box.get("calorieIntake", defaultValue: 2000),
                              size: 70,
                            ),

                            Text(S.of(context).calories),
                          ],
                        ),

                        Column(
                          spacing: 15,
                          children: [
                            ProgressArc(
                              value: (loader.nutrimentStats["protein"] ?? 0).toString(),
                              unit: "g",
                              fontSize: 20,
                              progress: (loader.nutrimentStats["protein"] ?? 0) / box.get("proteinIntake", defaultValue: 50),
                              size: 70,
                            ),

                            Text(S.of(context).protein),
                          ],
                        ),

                        Column(
                          spacing: 15,
                          children: [
                            ProgressArc(
                              value: (loader.nutrimentStats["carbs"] ?? 0).toString(),
                              unit: "g",
                              fontSize: 20,
                              progress: (loader.nutrimentStats["carbs"] ?? 0) / box.get("carbIntake", defaultValue: 300),
                              size: 70,
                            ),

                            Text(S.of(context).carbs),
                          ],
                        ),

                        Column(
                          spacing: 15,
                          children: [
                            ProgressArc(
                              value: (loader.nutrimentStats["fat"] ?? 0).toString(),
                              unit: "g",
                              fontSize: 20,
                              progress: (loader.nutrimentStats["fat"] ?? 0) / box.get("fatIntake", defaultValue: 70),
                              size: 70,
                            ),

                            Text(S.of(context).fat),
                          ],
                        ),

                      ],
                    );
                  },
                ),

                SizedBox(height: 30),
              ]),
            ),

            ...sections,
          ],
        ),
      ),
    );
  }
}
