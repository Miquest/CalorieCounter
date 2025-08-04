import 'package:caloriecounter/components/mealSection.dart';
import 'package:caloriecounter/components/progress_arc.dart';
import 'package:caloriecounter/generated/l10n.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(15, 20, 15, 0),
        child: CustomScrollView(
          slivers: [
            SliverList(
              delegate: SliverChildListDelegate([
                SizedBox(height: 70),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ProgressArc(
                      icon: Icon(Icons.fastfood, size: 40),
                      progress: 0.8,
                      size: 150,
                    ),

                    SizedBox(
                      height: 40,
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ProgressArc(
                          icon: Icon(Icons.directions_walk, size: 30),
                          progress: 0.6,
                          size: 70,
                        ),

                        ProgressArc(
                          icon: Icon(Icons.face, size: 30),
                          progress: 0.7,
                          size: 70,
                        ),

                        ProgressArc(
                          icon: Icon(Icons.breakfast_dining, size: 30),
                          progress: 0.95,
                          size: 70,
                        ),
                      ],
                    ),
                  ],
                ),

                SizedBox(height: 30),

                Divider(),

                SizedBox(height: 30),
              ]),
            ),

            MealSection(sectionTitle: S.of(context).breakfast),
            MealSection(sectionTitle: S.of(context).lunch),
            MealSection(sectionTitle: S.of(context).dinner),
          ],
        ),
      ),
    );
  }
}
