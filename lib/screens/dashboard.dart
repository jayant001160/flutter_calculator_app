import 'package:flutter/material.dart';
import 'settings_screen.dart';
import 'calculator_screen.dart';
import 'about_screen.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int _selectedIndex = 0;

  // List of pages to display in the dashboard
  final List<Widget> _pages = [
    CalculatorScreen(), // Default page
    SettingsScreen(),
    AboutScreen(),
  ];

  // Drawer menu items
  final List<String> _menuItems = [
    'Calculator',
    'Settings',
    'About',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        title: Text(_menuItems[_selectedIndex], style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.black87,
        iconTheme: IconThemeData(
          color: Colors.white, // Set the color of the Drawer icon here
        ),
      ),
      drawer: Drawer(
        child: ListView.builder(
          itemCount: _menuItems.length,
          itemBuilder: (context, index) {
            return ListTile(
              leading: Icon(
                index == 0
                    ? Icons.calculate
                    : index == 1
                    ? Icons.settings
                    : Icons.info,
              ),
              title: Text(_menuItems[index]),
              selected: _selectedIndex == index,
              onTap: () {
                setState(() {
                  _selectedIndex = index;
                });
                Navigator.pop(context); // Close the drawer
              },
            );
          },
        ),
      ),
      body: _pages[_selectedIndex],
    );
  }
}
