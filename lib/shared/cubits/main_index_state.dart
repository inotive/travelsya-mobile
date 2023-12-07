import 'package:equatable/equatable.dart';

abstract class MainIndexState extends Equatable {
  const MainIndexState();

  @override
  List<Object> get props => [];
}

class MainIndexInitial extends MainIndexState {}

class MainIndexLoading extends MainIndexState {}

class MainIndexLoaded extends MainIndexState {
  final int data;

  const MainIndexLoaded(this.data);

  @override
  List<Object> get props => [data];
}
