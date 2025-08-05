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
  late bool encryptData;
  late bool vegetarianMode;
  late bool veganMode;

  void _loadSettings() {
    encryptData = box.get("encryptData", defaultValue: false);
    vegetarianMode = box.get("vegetarianMode", defaultValue: false);
    veganMode = box.get("veganMode", defaultValue: false);
  }

  void _saveSettings() {
    box.put("encryptData", encryptData);
    box.put("vegetarianMode", vegetarianMode);
    box.put("veganMode", veganMode);
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

            SwitchListTile(
              value: encryptData,
              title: Text(S.of(context).encryptData),
              subtitle: Text(S.of(context).encryptDataSubtitle),
              onChanged: (value) {
                setState(() {
                  encryptData = value;
                });
                _saveSettings();
              },
            ),

            SwitchListTile(
              value: vegetarianMode,
              title: Text(S.of(context).vegetarianMode),
              activeColor: Colors.green,
              thumbIcon: WidgetStatePropertyAll(
                Icon(Icons.energy_savings_leaf_outlined, color:  vegetarianMode ? Colors.black : Colors.white,),
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

            ListTile(
              title: Text(S.of(context).exportData),
              subtitle: Text(
                S.of(context).exportDataSubtitle,
              ),
              trailing: Icon(Icons.keyboard_arrow_right),
            ),

            ListTile(
              title: Text(S.of(context).licenses),
              trailing: Icon(Icons.keyboard_arrow_right),
              onTap: () {
                showLicensePage(context: context);
              },
            ),

            SizedBox(height: 20),

            TextButton(
              onPressed: () {},
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
          ],
        ),
      ),
    );
  }
}
