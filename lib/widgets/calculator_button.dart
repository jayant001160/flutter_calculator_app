import 'package:flutter/material.dart';

class CalculatorButton extends StatelessWidget {
  final String label;
  final Function(String) onPressed;
  final double width;
  final double height;

  CalculatorButton({
    required this.label,
    required this.onPressed,
    this.width = 60,
    this.height = 60,
  });

  LinearGradient _getButtonGradient(String label) {
    if ('0123456789'.contains(label)) {
      return LinearGradient(
        colors: [Colors.blueGrey[700]!, Colors.blueGrey[900]!],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );
    } else if ('+-*/='.contains(label)) {
      return LinearGradient(
        colors: [Colors.orange[600]!, Colors.orange[800]!],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      );
    } else {
      return LinearGradient(
        colors: [Colors.blueGrey[600]!, Colors.blueGrey[800]!],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onPressed(label),
      child: Container(
        margin: EdgeInsets.all(4),
        decoration: BoxDecoration(
          gradient: _getButtonGradient(label), // Use gradient for decoration
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(fontSize: 36, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
