import 'package:flutter_bloc/flutter_bloc.dart';

class QuantityCubit extends Cubit<int> {
  QuantityCubit({int initialValue = 0}) : super(initialValue);

  void increment() => emit(state + 1);

  void decrement() {
    if (state > 0) {
      emit(state - 1);
    }
  }

  void reset() => emit(0);
}

class QuantityManagerCubit extends Cubit<Map<String, int>> {
  QuantityManagerCubit() : super({});

  void updateQty(String packageId, int qty) {
    final newState = Map<String, int>.from(state);
    if (qty > 0) {
      newState[packageId] = qty;
    } else {
      newState.remove(packageId);
    }
    emit(newState);
  }

  int getQty(String packageId) => state[packageId] ?? 0;
}
