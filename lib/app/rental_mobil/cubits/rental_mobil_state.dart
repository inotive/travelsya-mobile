import 'package:equatable/equatable.dart';
import 'package:travelsya/app/rental_mobil/models/rental_mobil_model.dart';
import 'package:travelsya/shared/api/api_return_value.dart';

abstract class RentalMobilState extends Equatable {
  const RentalMobilState();

  @override
  List<Object> get props => [];
}

class RentalMobilInitial extends RentalMobilState {}

class RentalMobilLoading extends RentalMobilState {}

class RentalMobilFailed extends RentalMobilState {
  final ApiReturnValue data;

  const RentalMobilFailed(this.data);

  @override
  List<Object> get props => [data];
}

class RentalMobilSearchLoaded extends RentalMobilState {
  final List<RentalMobilModel> data;

  const RentalMobilSearchLoaded(this.data);

  @override
  List<Object> get props => [data];
}
