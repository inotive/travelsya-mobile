import 'package:equatable/equatable.dart';
import 'package:travelsya/app/bus/models/bus_filter_model.dart';

abstract class BusFilterState extends Equatable {
  const BusFilterState();

  @override
  List<Object> get props => [];
}

class BustFilterLoading extends BusFilterState {}

class BusFilterInitial extends BusFilterState {}

class BusFilterLoaded extends BusFilterState {
  final BusFilterModel data;

  const BusFilterLoaded(this.data);

  @override
  List<Object> get props => [data];
}
