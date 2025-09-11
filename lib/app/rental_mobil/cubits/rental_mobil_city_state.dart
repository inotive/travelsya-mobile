import 'package:equatable/equatable.dart';
import 'package:travelsya/app/rental_mobil/models/rental_mobil_model.dart';

abstract class RentalMobilCityState extends Equatable {
  const RentalMobilCityState();

  @override
  List<Object?> get props => [];
}

class RentalMobilCityInitial extends RentalMobilCityState {}

class RentalMobilCityLoading extends RentalMobilCityState {}

class RentalMobilCityLoaded extends RentalMobilCityState {
  final List<RentalMobilCityModel> cities;

  const RentalMobilCityLoaded(this.cities);

  @override
  List<Object?> get props => [cities];
}

class RentalMobilCityFailed extends RentalMobilCityState {
  final String message;

  const RentalMobilCityFailed(this.message);

  @override
  List<Object?> get props => [message];
}
