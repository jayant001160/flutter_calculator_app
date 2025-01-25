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

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: () => onPressed(label),
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 6, horizontal: 2),
        width: isWide ? screenWidth * 0.23 : screenWidth * 0.11,
        // Adjust for wide buttons
        height: screenHeight * 0.085,
        decoration: BoxDecoration(
            color: isAccent
                ? Colors.black
                : isOperator
                    ? Colors.orange
                    : Colors.grey[850],
            // shape: label=='='?BoxShape.rectangle: BoxShape.circle,
            borderRadius: BorderRadius.all(Radius.circular(16))),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.bold,
              color: isAccent ? Colors.white : Colors.white70,
            ),
          ),
        ),
      ),
    );
  }
}
