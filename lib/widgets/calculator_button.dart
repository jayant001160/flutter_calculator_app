import 'package:flutter/material.dart';

class CalculatorButton extends StatelessWidget {
  final String label;
  final Function(String) onPressed;
  final bool isOperator;
  final bool isAccent;
  final bool isWide;

  const CalculatorButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.isOperator = false,
    this.isAccent = false,
    this.isWide = false,
  });

  // Method to determine the gradient based on button type
  LinearGradient _getButtonGradient() {
    if (isAccent) {
      return LinearGradient(
        colors: [Colors.black, Colors.black87],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      );
    } else if (isOperator) {
      return LinearGradient(
        colors: [Colors.orange.shade400, Colors.orange.shade700],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      );
    } else {
      return LinearGradient(
        colors: [Colors.grey.shade800, Colors.grey.shade900],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () => onPressed(label),
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 6, horizontal: 2),
        width: isWide ? screenWidth * 0.23 : screenWidth * 0.22, // Adjust for wide buttons
        height: screenHeight * 0.085,
        decoration: BoxDecoration(
          gradient: _getButtonGradient(), // Use gradient for the button
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
