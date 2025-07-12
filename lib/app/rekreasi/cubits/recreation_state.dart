import 'package:equatable/equatable.dart';
import 'package:travelsya/app/rekreasi/models/recreation_model.dart';
import 'package:travelsya/shared/api/api_return_value.dart';

abstract class RecreationState extends Equatable {
  const RecreationState();

  @override
  List<Object> get props => [];
}

class RecreationInitial extends RecreationState {}

class RecreationLoading extends RecreationState {}

class RecreationFailed extends RecreationState {
  final ApiReturnValue data;

  const RecreationFailed(this.data);

  @override
  List<Object> get props => [data];
}

class RecreationCategoryLoaded extends RecreationState {
  final List<RecreationCategoryModel> data;

  const RecreationCategoryLoaded(this.data);

  @override
  List<Object> get props => [data];
}

class RecreationPreviewListLoaded extends RecreationState {
  final List<RecreationPreviewModel> data;

  const RecreationPreviewListLoaded(this.data);

  @override
  List<Object> get props => [data];
}

class RecreationDetailLoaded extends RecreationState {
  final RecreationDetailModel data;

  const RecreationDetailLoaded(this.data);

  @override
  List<Object> get props => [data];
}
