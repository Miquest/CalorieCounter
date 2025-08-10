import 'package:caloriecounter/baseScaffold.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:caloriecounter/generated/l10n.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await dotenv.load(fileName: ".env");

  await Hive.openBox("settings");

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calorie Counter',
      themeMode: ThemeMode.dark,
      supportedLocales: [Locale("en"), Locale("de")],
      localizationsDelegates: [
        S.delegate
      ],
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.dark,
        ),
        textTheme: GoogleFonts.outfitTextTheme().apply(bodyColor: Colors.white),
      ),
      home: BaseScaffold(),
    );
  }
}
