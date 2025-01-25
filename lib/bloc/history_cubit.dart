import 'package:bloc/bloc.dart';

class HistoryCubit extends Cubit<List<String>> {
  HistoryCubit() : super([]);

  // Add a new calculation to the history
  void addCalculation(String calculation) {
    if (state.isEmpty || state.last != calculation) {
      final updatedHistory = List<String>.from(state)..add(calculation);
      emit(updatedHistory);
    }
  }

  // Clear the history
  void clearHistory() {
    emit([]);
  }
}
