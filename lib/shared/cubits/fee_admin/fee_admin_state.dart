import 'package:equatable/equatable.dart';
import 'package:travelsya/shared/cubits/fee_admin/fee_admin_model.dart';

abstract class FeeAdminState extends Equatable {
  const FeeAdminState();

  @override
  List<Object> get props => [];
}

class FeeAdminInitial extends FeeAdminState {}

class FeeAdminLoading extends FeeAdminState {}

class FeeAdminFailed extends FeeAdminState {}

class FeeAdminLoaded extends FeeAdminState {
  final List<FeeAdmin> data;

  const FeeAdminLoaded(this.data);

  @override
  List<Object> get props => [data];
}
