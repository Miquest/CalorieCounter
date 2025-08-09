import 'package:caloriecounter/components/foodDataLoader.dart';
import 'package:caloriecounter/components/mealSection.dart';
import 'package:caloriecounter/components/progress_arc.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late FoodDataLoader loader;

  List<String> sectionTags = ["breakfast", "lunch", "dinner", "snacks"];
  List<Widget> sections = [];

  @override
  void initState() {
    loader = FoodDataLoader(context: context, date: DateTime.now());

    for (String section in sectionTags) {
      sections.add(MealSection(sectionTag: section, date: DateTime.now()));
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    loader.loadFromStorage();

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
                                  loader.nutrimentStats["calories"]! / 2000,
                              size: 150,
                              fontSize: 30,
                              value: (loader.nutrimentStats["calories"] ?? 0).toString(),
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
                                  value: "15",
                                  unit: "g",
                                  fontSize: 20,
                                  progress: 0.7,
                                  size: 70,
                                ),

                                Text("Protein"),
                              ],
                            ),

                            Column(
                              spacing: 15,
                              children: [
                                ProgressArc(
                                  value: "30",
                                  unit: "g",
                                  fontSize: 20,
                                  progress: 0.4,
                                  size: 70,
                                ),

                                Text("Carbs"),
                              ],
                            ),

                            Column(
                              spacing: 15,
                              children: [
                                ProgressArc(
                                  value: "20",
                                  unit: "g",
                                  fontSize: 20,
                                  progress: 0.2,
                                  size: 70,
                                ),

                                Text("Fat"),
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
