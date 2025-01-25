import 'package:flutter/material.dart';
import '../widgets/calculator_button.dart';
import '../utils/calculator_logic.dart';

class CalculatorScreen extends StatefulWidget {
  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String input = '';
  String result = '0';

  void onButtonPressed(String value) {
    setState(() {
      if (value == 'C') {
        input = '';
        result = '0';
      } else if (value == '=') {
        try {
          result = CalculatorLogic.evaluateExpression(input);
        } catch (e) {
          result = 'Error';
        }
      } else {
        input += value;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            // Calculate button size dynamically
            double buttonWidth =
                constraints.maxWidth / 4 - 16; // 4 columns, 8px margin
            double buttonHeight = constraints.maxHeight / 4 - 16;
        
            return Column(
              children: [
                // Display Area
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(20),
                    alignment: Alignment.bottomRight,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          input,
                          style: TextStyle(fontSize: 24, color: Colors.white),
                        ),
                        Text(
                          result,
                          style: TextStyle(
                            fontSize: 36,
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // Divider(color: Colors.white),
                // Button Grid
                SizedBox(
                  height: constraints.maxHeight * 0.5,
                  // Reserve 60% height for buttons
                  child: GridView.count(
                    childAspectRatio: 1.2,
                    crossAxisCount: 4,
                    // 4 columns
                    shrinkWrap: true,
                    padding: EdgeInsets.symmetric(vertical: 2, horizontal: 2),
                    children: [
                      // First row of buttons
                      ...['7', '8', '9', '/'].map(
                        (e) => CalculatorButton(
                          label: e,
                          onPressed: onButtonPressed,
                          width: buttonWidth,
                          height: buttonHeight,
                        ),
                      ),
                      // Second row of buttons
                      ...['4', '5', '6', '*'].map(
                        (e) => CalculatorButton(
                          label: e,
                          onPressed: onButtonPressed,
                          width: buttonWidth,
                          height: buttonHeight,
                        ),
                      ),
                      // Third row of buttons
                      ...['1', '2', '3', '-'].map(
                        (e) => CalculatorButton(
                          label: e,
                          onPressed: onButtonPressed,
                          width: buttonWidth,
                          height: buttonHeight,
                        ),
                      ),
                      // Fourth row of buttons
                      ...['C', '0', '=', '+'].map(
                        (e) => CalculatorButton(
                          label: e,
                          onPressed: onButtonPressed,
                          width: buttonWidth,
                          height: buttonHeight,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
