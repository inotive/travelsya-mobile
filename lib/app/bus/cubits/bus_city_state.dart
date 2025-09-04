import 'package:equatable/equatable.dart';
import 'package:travelsya/app/bus/models/bus_model.dart';

abstract class BusCityState extends Equatable {
  const BusCityState();

  @override
  List<Object?> get props => [];
}

class BusCityInitial extends BusCityState {}

class BusCityLoading extends BusCityState {}

class BusCityLoaded extends BusCityState {
  final List<BusCityModel> cities;

  const BusCityLoaded(this.cities);

  @override
  List<Object?> get props => [cities];
}

class BusCityFailed extends BusCityState {
  final String message;

  const BusCityFailed(this.message);

  @override
  List<Object?> get props => [message];
}
