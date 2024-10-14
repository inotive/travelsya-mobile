import 'package:equatable/equatable.dart';
import 'package:travelsya/shared/cubits/point/point_model.dart';

abstract class PointState extends Equatable {
  const PointState();

  @override
  List<Object> get props => [];
}

class PointInitial extends PointState {}

class PointLoading extends PointState {}

class PointFailed extends PointState {}

class PointLoaded extends PointState {
  final PointModel data;

  const PointLoaded(this.data);

  @override
  List<Object> get props => [data];
}
