import 'package:equatable/equatable.dart';
import 'package:travelsya/app/health/models/health_model.dart';
import 'package:travelsya/shared/api/api_return_value.dart';

abstract class HealthState extends Equatable {
  const HealthState();

  @override
  List<Object> get props => [];
}

class HealthInitial extends HealthState {}

class HealthLoading extends HealthState {}

class HealthFailed extends HealthState {
  final ApiReturnValue data;

  const HealthFailed(this.data);

  @override
  List<Object> get props => [data];
}

class HealthHomeLoaded extends HealthState {
  final List<HealthCategoryModel> category;
  final List<HealthPreviewModel> specialDeal;

  const HealthHomeLoaded(this.category, this.specialDeal);

  @override
  List<Object> get props => [category, specialDeal];
}

class HealthBeautyHomeLoaded extends HealthState {
  final List<HealthPreviewModel> health;
  final List<HealthPreviewModel> beauty;

  const HealthBeautyHomeLoaded(this.health, this.beauty);

  @override
  List<Object> get props => [health, beauty];
}

class HealthDetailLoaded extends HealthState {
  final HealthDetailModel data;

  const HealthDetailLoaded(
    this.data,
  );

  @override
  List<Object> get props => [
        data,
      ];
}

class HealthSearchLoaded extends HealthState {
  final List<HealthPreviewModel> data;

  const HealthSearchLoaded(
    this.data,
  );

  @override
  List<Object> get props => [
        data,
      ];
}
