import 'package:equatable/equatable.dart';

abstract class HealthFilterState extends Equatable {
  const HealthFilterState();

  @override
  List<Object> get props => [];
}

class HealthFilterStatetFilterLoading extends HealthFilterState {}

class HealthFilterStateFilterInitial extends HealthFilterState {}

class HealthFilterStateFilterLoaded extends HealthFilterState {
  final  data;

  const HealthFilterStateFilterLoaded(this.data);

  @override
  List<Object> get props => [data];
}
