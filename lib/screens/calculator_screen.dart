import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../widgets/calculator_button.dart';
import '../utils/calculator_logic.dart';
import '../bloc/history_cubit.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String input = '';
  String result = '0';

  void onButtonPressed(String value, BuildContext context) {
    if (value == 'AC') {
      setState(() {
        input = '';
        result = '0';
      });
    } else if (value == '⌫') {
      setState(() {
        input = input.isNotEmpty ? input.substring(0, input.length - 1) : '';
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
    } else {
      setState(() {
        input += value;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      body: LayoutBuilder(
        builder: (context, constraints) {
          double buttonWidth = constraints.maxWidth / 4 - 16;
          double buttonHeight = constraints.maxHeight / 6 - 16;

          return Column(
            children: [
              // History Area
              Expanded(
                flex: 4,
                child: BlocBuilder<HistoryCubit, List<String>>(
                  builder: (context, history) {
                    return Container(
                      padding: EdgeInsets.symmetric(vertical: 0, horizontal: 8),
                      // color: Colors.amber,
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
                        padding: EdgeInsets.zero,
                        reverse: true,
                        itemCount: history.length,
                        itemBuilder: (context, index) {
                          // Access items in reverse order
                          final reversedIndex = history.length - 1 - index;
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 0.0),
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
              // Display Area
              Expanded(
                flex: 3,
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 0, horizontal: 16),
                  alignment: Alignment.bottomRight,
                  // color: Colors.pink,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.blueGrey.shade800,
                        Colors.black87,
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        input,
                        style: TextStyle(
                          fontSize: 32,
                          color: Colors.white70,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                      Text(
                        result,
                        style: TextStyle(
                          fontSize: 48,
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
              Expanded(
                flex: 10,
                child: Column(
                  children: [
                    // First row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        CalculatorButton(
                            label: 'AC',
                            onPressed: (val) => onButtonPressed(val, context),
                            isAccent: true),
                        CalculatorButton(
                          label: '%',
                          onPressed: (val) => onButtonPressed(val, context),
                          isOperator: true,
                        ),
                        CalculatorButton(
                            label: '÷',
                            onPressed: (val) => onButtonPressed(val, context),
                            isOperator: true),
                        CalculatorButton(
                          label: '⌫',
                          onPressed: (val) => onButtonPressed(val, context),
                          isOperator: true,
                        ),
                      ],
                    ),
                    // SizedBox(height: 10),
                    // Second row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ...['7', '8', '9', '×'].map(
                          (e) => CalculatorButton(
                            label: e,
                            onPressed: (val) => onButtonPressed(val, context),
                            isOperator: '×÷-+'.contains(e),
                          ),
                        ),
                      ],
                    ),
                    // SizedBox(height: 10),
                    // Third row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ...['4', '5', '6', '-'].map(
                          (e) => CalculatorButton(
                            label: e,
                            onPressed: (val) => onButtonPressed(val, context),
                            isOperator: '×÷-+'.contains(e),
                          ),
                        ),
                      ],
                    ),
                    // SizedBox(height: 10),
                    // Fourth row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ...['1', '2', '3', '+'].map(
                          (e) => CalculatorButton(
                            label: e,
                            onPressed: (val) => onButtonPressed(val, context),
                            isOperator: '×÷-+'.contains(e),
                          ),
                        ),
                      ],
                    ),
                    // SizedBox(height: 10),
                    // Fifth row (last row with wide '=' button)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                            child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            CalculatorButton(
                                label: '0',
                                onPressed: (val) =>
                                    onButtonPressed(val, context)),
                            CalculatorButton(
                                label: '.',
                                onPressed: (val) =>
                                    onButtonPressed(val, context)),
                          ],
                        )),
                        Expanded(
                          child: CalculatorButton(
                            label: '=',
                            onPressed: (val) => onButtonPressed(val, context),
                            isOperator: true,
                            isWide: true,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
