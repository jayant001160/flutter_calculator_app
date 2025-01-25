import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../widgets/calculator_button.dart';
import '../utils/calculator_logic.dart';
import '../bloc/history_cubit.dart'; // Assuming you have a dedicated BLoC folder for state management

class CalculatorScreen extends StatefulWidget {
  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String input = '';
  String result = '0';

  void onButtonPressed(String value, BuildContext context) {
    if (value == 'C') {
      // Add the calculation to history if there's a result
      if (input.isNotEmpty && result != '0') {
        context.read<HistoryCubit>().addCalculation('$input = $result');
      } else if (input.isNotEmpty && result == '0') {
        context.read<HistoryCubit>().addCalculation(input);
      }
      setState(() {
        input = '';
        result = '0';
      });
    } else if (value == '=') {
      try {
        String evaluatedResult = CalculatorLogic.evaluateExpression(input);
        setState(() {
          result = evaluatedResult;
        });
        // Add the calculation to history
        if (input.isNotEmpty) {
          context.read<HistoryCubit>().addCalculation('$input = $result');
        }
      } catch (e) {
        setState(() {
          result = 'Error';
        });
      }
    } else if ((value == '+' || value == '-' || value == '*' || value == '/') &&
        result != '0') {
      setState(() {
        input = result;
        input += value;
        result = '0';
      });
    } else {
      setState(() {
        input += value;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black87,
        body: LayoutBuilder(
          builder: (context, constraints) {
            double buttonWidth = constraints.maxWidth / 4 - 16;
            double buttonHeight = constraints.maxHeight / 4 - 16;

            return Column(
              children: [
                // History Area
                Expanded(
                  flex: 2,
                  child: BlocBuilder<HistoryCubit, List<String>>(
                    builder: (context, history) {
                      return Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.black87,
                              Colors.blueGrey.shade800,
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                          // borderRadius: BorderRadius.vertical(bottom: Radius.circular(8)),
                        ),
                        child: ListView.builder(
                          reverse: true,
                          itemCount: history.length,
                          itemBuilder: (context, index) {
                            // Access items in reverse order
                            final reversedIndex = history.length - 1 - index;
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 4.0),
                              child: Text(
                                history[reversedIndex],
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
                ),
                // SizedBox(
                //   height: constraints.maxHeight * 0.005,
                // ),
                // Display Area
                Expanded(
                  flex: 1,
                  child: Container(
                    padding: EdgeInsets.all(20),
                    alignment: Alignment.bottomRight,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.blueGrey.shade800,
                          Colors.black87,
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                      // borderRadius:
                      //     BorderRadius.vertical(top: Radius.circular(8)),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          input,
                          style: TextStyle(
                            fontSize: 24,
                            color: Colors.white70,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                        Text(
                          result,
                          style: TextStyle(
                            fontSize: 36,
                            fontWeight: FontWeight.bold,
                            color: Colors.greenAccent.shade400,
                            shadows: [
                              Shadow(
                                blurRadius: 10,
                                color: Colors.greenAccent.shade700,
                                offset: Offset(2, 2),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Button Grid
                SizedBox(
                  height: constraints.maxHeight * 0.45,
                  child: GridView.count(
                    childAspectRatio: 1.2,
                    crossAxisCount: 4,
                    padding: EdgeInsets.symmetric(vertical: 2, horizontal: 2),
                    children: [
                      ...['7', '8', '9', '/'].map(
                        (e) => CalculatorButton(
                          label: e,
                          onPressed: (val) => onButtonPressed(val, context),
                          width: buttonWidth,
                          height: buttonHeight,
                        ),
                      ),
                      ...['4', '5', '6', '*'].map(
                        (e) => CalculatorButton(
                          label: e,
                          onPressed: (val) => onButtonPressed(val, context),
                          width: buttonWidth,
                          height: buttonHeight,
                        ),
                      ),
                      ...['1', '2', '3', '-'].map(
                        (e) => CalculatorButton(
                          label: e,
                          onPressed: (val) => onButtonPressed(val, context),
                          width: buttonWidth,
                          height: buttonHeight,
                        ),
                      ),
                      ...['C', '0', '=', '+'].map(
                        (e) => CalculatorButton(
                          label: e,
                          onPressed: (val) => onButtonPressed(val, context),
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
