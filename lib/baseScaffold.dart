import 'package:caloriecounter/home/home.dart';
import 'package:caloriecounter/history/history.dart';
import 'package:caloriecounter/settings/settings.dart';
import 'package:flutter/material.dart';
import 'package:caloriecounter/generated/l10n.dart';
import 'package:caloriecounter/add_entry/addEntry.dart';

class BaseScaffold extends StatefulWidget {
  const BaseScaffold({super.key});

  @override
  State<BaseScaffold> createState() => _BaseScaffoldState();
}

class _BaseScaffoldState extends State<BaseScaffold> {
  int _pageIndex = 0;

  final List<Widget> _pages = [Home(), History(), Settings()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_pageIndex],
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => AddEntry())
          );
        },
        child: Icon(Icons.fastfood),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _pageIndex,
        onDestinationSelected: (index) {
          setState(() {
            _pageIndex = index;
          });
        },
        destinations: [
          NavigationDestination(icon: Icon(Icons.home), label: S.of(context).home),
          NavigationDestination(icon: Icon(Icons.timelapse), label: S.of(context).history),
          NavigationDestination(icon: Icon(Icons.settings), label: S.of(context).settings),
        ],
      ),
    );
  }
}
