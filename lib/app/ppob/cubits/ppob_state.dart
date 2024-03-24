import 'package:equatable/equatable.dart';
import 'package:travelsya/app/ppob/models/ppob_model.dart';
import 'package:travelsya/shared/api/api_return_value.dart';

abstract class PPOBState extends Equatable {
  const PPOBState();

  @override
  List<Object> get props => [];
}

class PPOBInitial extends PPOBState {}

class PPOBLoading extends PPOBState {}

class PPOBFailed extends PPOBState {
  final ApiReturnValue data;

  const PPOBFailed(this.data);

  @override
  List<Object> get props => [data];
}

class PPOBLoaded extends PPOBState {
  final PPOBGroup data;

  const PPOBLoaded(this.data);

  @override
  List<Object> get props => [data];
}

class PajakPPOBLoaded extends PPOBState {
  final List<PPOBModel> data;

  const PajakPPOBLoaded(this.data);

  @override
  List<Object> get props => [data];
}
