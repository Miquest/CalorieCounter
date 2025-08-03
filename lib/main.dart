import 'package:flutter/material.dart';
import 'baseApplication.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  runApp(const CalorieCounter());
}

class CalorieCounter extends StatelessWidget {
  const CalorieCounter({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calorie Counter',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        textTheme: GoogleFonts.outfitTextTheme(),
      ),
      home: const BaseApplication(),
    );
  }
}

