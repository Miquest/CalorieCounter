import 'package:caloriecounter/components/foodDataLoader.dart';
import 'package:caloriecounter/components/mealSection.dart';
import 'package:caloriecounter/components/progress_arc.dart';
import 'package:caloriecounter/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late FoodDataLoader loader;
  final box = Hive.box("settings");

  List<String> sectionTags = ["breakfast", "lunch", "dinner", "snacks"];
  List<Widget> sections = [];

  @override
  void initState() {
    loader = FoodDataLoader(context: context, date: DateTime.now());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    loader.loadFromStorage();

    sections = [];
    for (String section in sectionTags) {
      sections.add(MealSection(sectionTag: section, date: DateTime.now()));
    }

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(15, 20, 15, 0),
        child: CustomScrollView(
          slivers: [
            SliverList(
              delegate: SliverChildListDelegate([
                SizedBox(height: 70),

                ListenableBuilder(
                  listenable: loader,
                  builder: (context, child) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          spacing: 20,
                          children: [
                            ProgressArc(
                              progress:
                                  (loader.nutrimentStats["calories"] ?? 0) /
                                  box.get("calorieIntake", defaultValue: 2000),
                              size: 150,
                              fontSize: 30,
                              value: (loader.nutrimentStats["calories"] ?? 0)
                                  .toString(),
                              unit: "kcal",
                            ),
                          ],
                        ),

                        SizedBox(height: 40),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Column(
                              spacing: 15,
                              children: [
                                ProgressArc(
                                  value: (loader.nutrimentStats["protein"] ?? 0)
                                      .toString(),
                                  unit: "g",
                                  fontSize: 20,
                                  progress:
                                      (loader.nutrimentStats["protein"] ?? 0) /
                                      box.get(
                                        "proteinIntake",
                                        defaultValue: 50,
                                      ),
                                  size: 70,
                                ),

                                Text(S.of(context).protein),
                              ],
                            ),

                            Column(
                              spacing: 15,
                              children: [
                                ProgressArc(
                                  value: (loader.nutrimentStats["carbs"] ?? 0)
                                      .toString(),
                                  unit: "g",
                                  fontSize: 20,
                                  progress:
                                      (loader.nutrimentStats["carbs"] ?? 0) /
                                      box.get("carbIntake", defaultValue: 300),
                                  size: 70,
                                ),

                                Text(S.of(context).carbs),
                              ],
                            ),

                            Column(
                              spacing: 15,
                              children: [
                                ProgressArc(
                                  value: (loader.nutrimentStats["fat"] ?? 0)
                                      .toString(),
                                  unit: "g",
                                  fontSize: 20,
                                  progress:
                                      (loader.nutrimentStats["fat"] ?? 0) /
                                      box.get("fatIntake", defaultValue: 70),
                                  size: 70,
                                ),

                                Text(S.of(context).fat),
                              ],
                            ),
                          ],
                        ),
                      ],
                    );
                  },
                ),

                SizedBox(height: 30),

                Divider(),

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
