import 'package:equatable/equatable.dart';
import 'package:travelsya/app/rental_mobil/models/rental_mobil_fitler_model.dart';

abstract class RentalMobilFilterState extends Equatable {
  const RentalMobilFilterState();

  @override
  List<Object> get props => [];
}

class RentalMobilFilterLoadLoading extends RentalMobilFilterState {}

class RentalMObilFilterInitial extends RentalMobilFilterState {}

class RentalMobilFilterLoaded extends RentalMobilFilterState {
  final RentalMobilFitlerModel data;

  const RentalMobilFilterLoaded(this.data);

  @override
  List<Object> get props => [data];
}
