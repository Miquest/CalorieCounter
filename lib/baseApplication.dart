import 'package:caloriecounter/home/home.dart';
import 'package:flutter/material.dart';

class BaseApplication extends StatefulWidget {
  const BaseApplication({super.key});

  @override
  State<BaseApplication> createState() => _BaseApplicationState();
}

class _BaseApplicationState extends State<BaseApplication> {
  final List<Widget> _screens = [Home(), Placeholder(), Placeholder()];

  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        destinations: [
          NavigationDestination(
            icon: Icon(Icons.home),
            selectedIcon: Icon(Icons.home_outlined),
            label: "Home",
          ),
          NavigationDestination(icon: Icon(Icons.search), label: "Search"),
          NavigationDestination(
            icon: Icon(Icons.settings),
            selectedIcon: Icon(Icons.settings_outlined),
            label: "Settings",
          ),
        ],
      ),
    );
  }
}
