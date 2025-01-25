class CalculatorLogic {
  /// Evaluates a mathematical expression with enhanced error handling
  static String evaluateExpression(String expression) {
    if (expression == null || expression.trim().isEmpty) {
      return 'Invalid Input';
    }

    try {
      // Preprocess the expression
      expression = _preprocessExpression(expression);

      // Validate the expression
      if (!_isValidExpression(expression)) {
        return 'Invalid Input';
      }

      // Evaluate the basic arithmetic expression
      double result = _evaluateBasicExpression(expression);

      // Format the result
      return _formatResult(result);
    } catch (e) {
      return 'Invalid Input';
    }
  }

  /// Preprocesses the input expression
  static String _preprocessExpression(String expression) {
    // Remove whitespace
    expression = expression.replaceAll(RegExp(r'\s+'), '');

    // Handle consecutive operators
    expression = expression.replaceAll(RegExp(r'(\+\+|--)'), '+');
    expression = expression.replaceAll(RegExp(r'(\+-|-\+)'), '-');

    // Normalize negative number representations
    expression = expression.replaceAllMapped(
      RegExp(r'(^|[+\-*/(])-\d+'),
          (match) {
        return '${match.group(1)}0${match.group(0)!.substring(match.group(1)!.length)}';
      },
    );


    // Remove invalid characters, keeping only valid arithmetic characters
    expression = expression.replaceAll(RegExp(r'[^0-9+\-*/.,()]'), '');

    return expression;
  }

  /// Validates the expression structure
  static bool _isValidExpression(String expression) {
    // Check for balanced parentheses
    if (!_areParenthesesBalanced(expression)) return false;

    // Check for valid character sequence
    final validSequenceRegex = RegExp(r'^[+-]?(\d+\.?\d*([+\-*/][+-]?\d+\.?\d*)*)?$');
    return validSequenceRegex.hasMatch(expression);
  }

  /// Checks if parentheses are balanced
  static bool _areParenthesesBalanced(String expression) {
    int openCount = 0;
    for (var char in expression.split('')) {
      if (char == '(') openCount++;
      if (char == ')') openCount--;
      if (openCount < 0) return false;
    }
    return openCount == 0;
  }

  /// Evaluates the basic arithmetic expression
  static double _evaluateBasicExpression(String expression) {
    try {
      // Tokenize and evaluate the expression considering operator precedence
      final tokens = _tokenize(expression);
      return _evaluateTokensWithPrecedence(tokens);
    } catch (e) {
      throw Exception('Invalid Arithmetic Expression');
    }
  }

  /// Tokenizes the expression into numbers and operators
  static List<String> _tokenize(String expression) {
    final List<String> tokens = [];
    final buffer = StringBuffer();
    bool lastWasOperator = true;

    for (int i = 0; i < expression.length; i++) {
      final char = expression[i];

      if ('0123456789.'.contains(char)) {
        // Accumulate numeric characters
        buffer.write(char);
        lastWasOperator = false;
      } else if ('+-*/()'.contains(char)) {
        // Handle signs for negative numbers
        if (lastWasOperator && char == '-') {
          buffer.write(char);
          lastWasOperator = false;
          continue;
        }

        // Push the accumulated number and the operator
        if (buffer.isNotEmpty) {
          tokens.add(buffer.toString());
          buffer.clear();
        }
        tokens.add(char);
        lastWasOperator = true;
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

  /// Evaluates tokens with operator precedence
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

  /// Formats the result with appropriate decimal precision
  static String _formatResult(double result) {
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
  }
}
