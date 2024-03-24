import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travelsya/shared/cubits/main_index_state.dart';

class MainIndexCubit extends Cubit<MainIndexState> {
  MainIndexCubit() : super(const MainIndexLoaded(0));

  changeIndex(int value) {
    emit(MainIndexLoading());
    emit(MainIndexLoaded(value));
  }
}
