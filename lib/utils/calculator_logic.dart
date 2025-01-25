class CalculatorLogic {
  static String evaluateExpression(String expression) {
    try {
      // Remove invalid characters from the input expression
      expression = expression.replaceAll(RegExp(r'[^0-9+\-*/.\s]'), '').trim();

      // Evaluate the basic arithmetic expression
      double result = _evaluateBasicExpression(expression);

      // Check if the result has a fractional part
      if (result % 1 == 0) {
        // Return as integer if there's no fractional part
        return result.toInt().toString();
      } else {
        // Return as double with up to 4 decimal places, trimmed
        return result
            .toStringAsFixed(4)
            .replaceAll(RegExp(r'0+$'), '')
            .replaceAll(RegExp(r'\.$'), '');
      }
    } catch (e) {
      return 'Invalid Input';
    }
  }

  static double _evaluateBasicExpression(String expression) {
    try {
      // Tokenize and evaluate the expression considering operator precedence
      final tokens = _tokenize(expression);
      return _evaluateTokensWithPrecedence(tokens);
    } catch (e) {
      throw Exception('Invalid Arithmetic Expression');
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
      } else if (char.trim().isEmpty) {
        // Skip spaces
        continue;
      } else {
        throw Exception('Unexpected character in expression: $char');
      }
    }

    // Add the last accumulated number
    if (buffer.isNotEmpty) {
      tokens.add(buffer.toString());
    }

    return tokens;
  }

  static double _evaluateTokensWithPrecedence(List<String> tokens) {
    // Apply operator precedence using a two-pass algorithm
    // 1. Handle multiplication and division first
    final List<String> intermediateTokens = [];
    double current = double.parse(tokens[0]);

    for (int i = 1; i < tokens.length; i += 2) {
      final operator = tokens[i];
      final operand = double.parse(tokens[i + 1]);

      if (operator == '*' || operator == '/') {
        if (operator == '*') {
          current *= operand;
        } else {
          if (operand == 0) throw Exception('Division by zero');
          current /= operand;
        }
      } else {
        intermediateTokens.add(current.toString());
        intermediateTokens.add(operator);
        current = operand;
      }
    }

    // Push the last calculated value
    intermediateTokens.add(current.toString());

    // 2. Handle addition and subtraction
    double result = double.parse(intermediateTokens[0]);
    for (int i = 1; i < intermediateTokens.length; i += 2) {
      final operator = intermediateTokens[i];
      final operand = double.parse(intermediateTokens[i + 1]);

      if (operator == '+') {
        result += operand;
      } else if (operator == '-') {
        result -= operand;
      } else {
        throw Exception('Unexpected operator: $operator');
      }
    }

    return result;
  }
}
