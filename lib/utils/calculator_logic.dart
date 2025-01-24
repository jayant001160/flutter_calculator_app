class CalculatorLogic {
  static String evaluateExpression(String expression) {
    try {
      // Remove invalid characters from the input expression
      expression = expression.replaceAll(RegExp(r'[^0-9+\-*/.]'), '');

      // Evaluate the basic arithmetic expression
      double result = _evaluateBasicExpression(expression);
      return result.toString();
    } catch (e) {
      return 'Invalid Input';
    }
  }

  static double _evaluateBasicExpression(String expression) {
    try {
      // Use a lightweight evaluator for basic arithmetic expressions
      return _safeEval(expression);
    } catch (e) {
      throw Exception('Invalid Arithmetic Expression');
    }
  }

  static double _safeEval(String expression) {
    // Placeholder for evaluating the expression
    // Replace this with a more robust parser for complex cases if needed
    try {
      final tokens = _tokenize(expression);
      return _evaluateTokens(tokens);
    } catch (e) {
      throw Exception('Evaluation Error');
    }
  }

  static List<String> _tokenize(String expression) {
    final List<String> tokens = [];
    final buffer = StringBuffer();

    for (int i = 0; i < expression.length; i++) {
      final char = expression[i];

      if ('0123456789.'.contains(char)) {
        // Accumulate numeric characters
        buffer.write(char);
      } else if ('+-*/'.contains(char)) {
        // Push the accumulated number and the operator
        if (buffer.isNotEmpty) {
          tokens.add(buffer.toString());
          buffer.clear();
        }
        tokens.add(char);
      }
    }

    // Add the last accumulated number
    if (buffer.isNotEmpty) {
      tokens.add(buffer.toString());
    }

    return tokens;
  }

  static double _evaluateTokens(List<String> tokens) {
    // Simple left-to-right evaluation (does not consider operator precedence)
    double result = double.parse(tokens[0]);

    for (int i = 1; i < tokens.length; i += 2) {
      final operator = tokens[i];
      final operand = double.parse(tokens[i + 1]);

      switch (operator) {
        case '+':
          result += operand;
          break;
        case '-':
          result -= operand;
          break;
        case '*':
          result *= operand;
          break;
        case '/':
          if (operand == 0) throw Exception('Division by zero');
          result /= operand;
          break;
        default:
          throw Exception('Invalid operator');
      }
    }

    return result;
  }
}
