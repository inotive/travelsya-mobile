import 'package:equatable/equatable.dart';
import 'package:travelsya/app/bus/models/bus_model.dart';
import 'package:travelsya/shared/api/api_return_value.dart';

abstract class BusState extends Equatable {
  const BusState();

  @override
  List<Object> get props => [];
}

class BusInitial extends BusState {}

class BusLoading extends BusState {}

class BusFailed extends BusState {
  final ApiReturnValue data;

  const BusFailed(this.data);

  @override
  List<Object> get props => [data];
}

class BusSearchLoaded extends BusState {
  final List<BusDataModel> dataGo;
  final List<BusDataModel> dataBack;

  const BusSearchLoaded(this.dataGo, this.dataBack);

  @override
  List<Object> get props => [dataGo, dataBack];
}
