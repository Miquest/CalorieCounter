import 'package:flutter/material.dart';
import 'package:caloriecounter/generated/l10n.dart';
import 'package:google_fonts/google_fonts.dart';

class History extends StatefulWidget {
  const History({super.key});

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.fromLTRB(15, 20, 15, 0),
        child: ListView(
          children: [
            Text(
              S.of(context).history,
              style: TextStyle(
                fontFamily: GoogleFonts.permanentMarker().fontFamily,
                fontSize: 50,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
