import 'package:flutter/material.dart';
import 'screens/calculator_screen.dart';

void main() {
  runApp(AdvancedCalculator());
}

class AdvancedCalculator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Advanced Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.grey[900],
        textTheme: TextTheme(bodyMedium: TextStyle(color: Colors.white)),
      ),
      home: CalculatorScreen(),
    );
  }
}
