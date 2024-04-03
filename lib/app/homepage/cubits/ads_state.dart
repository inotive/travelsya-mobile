import 'package:equatable/equatable.dart';
import 'package:travelsya/app/homepage/models/ads_model.dart';
import 'package:travelsya/shared/api/api_return_value.dart';

abstract class AdsState extends Equatable {
  const AdsState();

  @override
  List<Object> get props => [];
}

class AdsInitial extends AdsState {}

class AdsLoading extends AdsState {}

class AdsFailed extends AdsState {
  final ApiReturnValue data;

  const AdsFailed(this.data);

  @override
  List<Object> get props => [data];
}

class AdsLoaded extends AdsState {
  final List<AdsModel> data;

  const AdsLoaded(this.data);

  @override
  List<Object> get props => [data];
}
