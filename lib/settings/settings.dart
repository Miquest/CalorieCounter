import 'package:caloriecounter/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/adapters.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final Box box = Hive.box("settings");
  late bool vegetarianMode;
  late bool veganMode;

  late int calorieIntake;
  late int fatIntake;
  late int proteinIntake;
  late int carbIntake;

  void _loadSettings() {
    vegetarianMode = box.get("vegetarianMode", defaultValue: false);
    veganMode = box.get("veganMode", defaultValue: false);

    calorieIntake = box.get("calorieIntake", defaultValue: 2000);
    fatIntake = box.get("fatIntake", defaultValue: 70);
    proteinIntake = box.get("proteinIntake", defaultValue: 50);
    carbIntake = box.get("carbIntake", defaultValue: 300);
  }

  void _saveSettings() {
    box.put("vegetarianMode", vegetarianMode);
    box.put("veganMode", veganMode);

    box.put("calorieIntake", calorieIntake);
    box.put("fatIntake", fatIntake);
    box.put("proteinIntake", proteinIntake);
    box.put("carbIntake", carbIntake);
  }

  @override
  void initState() {
    _loadSettings();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.fromLTRB(15, 20, 15, 0),
        child: ListView(
          children: [
            Text(
              S.of(context).settings,
              style: TextStyle(
                fontFamily: GoogleFonts.permanentMarker().fontFamily,
                fontSize: 50,
              ),
            ),

            SizedBox(height: 20),

            Text(
              S.of(context).intakeGoals,
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
              ),
            ),

            SizedBox(height: 15),

            ListTile(
              title: Text(S.of(context).calorieIntakeKcal),
              trailing: SizedBox(
                width: 100,
                child: TextField(
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                  controller: TextEditingController(
                    text: calorieIntake.toString(),
                  ),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  onChanged: (value) {
                    calorieIntake = int.parse(value);
                    _saveSettings();
                  },
                ),
              ),
            ),

            SizedBox(height: 10),

            ListTile(
              title: Text(S.of(context).fatIntakeG),
              trailing: SizedBox(
                width: 100,
                child: TextField(
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                  controller: TextEditingController(text: fatIntake.toString()),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  onChanged: (value) {
                    fatIntake = int.parse(value);
                    _saveSettings();
                  },
                ),
              ),
            ),

            SizedBox(height: 10),

            ListTile(
              title: Text(S.of(context).carbIntakeG),
              trailing: SizedBox(
                width: 100,
                child: TextField(
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                  controller: TextEditingController(
                    text: carbIntake.toString(),
                  ),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  onChanged: (value) {
                    carbIntake = int.parse(value);
                    _saveSettings();
                  },
                ),
              ),
            ),

            SizedBox(height: 10),

            ListTile(
              title: Text(S.of(context).proteinIntakeG),
              trailing: SizedBox(
                width: 100,
                child: TextField(
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                  controller: TextEditingController(
                    text: proteinIntake.toString(),
                  ),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  onChanged: (value) {
                    proteinIntake = int.parse(value);
                    _saveSettings();
                  },
                ),
              ),
            ),

            SizedBox(height: 20),

            Text(
              S.of(context).preferences,
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
              ),
            ),

            SizedBox(height: 15),

            SwitchListTile(
              value: vegetarianMode,
              title: Text(S.of(context).vegetarianMode),
              activeColor: Colors.green,
              thumbIcon: WidgetStatePropertyAll(
                Icon(
                  Icons.energy_savings_leaf_outlined,
                  color: vegetarianMode ? Colors.black : Colors.white,
                ),
              ),
              onChanged: (value) {
                setState(() {
                  vegetarianMode = value;
                });
                _saveSettings();
              },
            ),

            SwitchListTile(
              value: veganMode,
              title: Text(S.of(context).veganMode),
              activeColor: Colors.greenAccent,
              thumbIcon: WidgetStatePropertyAll(
                Icon(
                  Icons.energy_savings_leaf,
                  color: veganMode ? Colors.black : Colors.white,
                ),
              ),
              onChanged: (value) {
                setState(() {
                  veganMode = value;
                });
                _saveSettings();
              },
            ),

            /*
            ListTile(
              title: Text(S.of(context).exportData),
              subtitle: Text(
                S.of(context).exportDataSubtitle,
              ),
              trailing: Icon(Icons.keyboard_arrow_right),
            ),
            */
            Divider(),

            ListTile(
              title: Text(S.of(context).licenses),
              trailing: Icon(Icons.keyboard_arrow_right),
              onTap: () {
                showLicensePage(context: context);
              },
            ),

            SizedBox(height: 20),

            TextButton(
              onPressed: () async {
                await Hive.deleteBoxFromDisk("settings");
                await Hive.deleteBoxFromDisk("logbook");

                await Hive.openBox("settings");
                await Hive.openBox("logbook");
                setState(() {});
              },
              child: Text(
                S.of(context).resetApp,
                style: TextStyle(color: Colors.redAccent),
              ),
            ),

            SizedBox(height: 10),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.copyright),
                SizedBox(width: 5),
                Text("Mika Schreiber"),
              ],
            ),

            SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
}
