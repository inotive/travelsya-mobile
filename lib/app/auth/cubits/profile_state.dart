import 'package:equatable/equatable.dart';
import 'package:travelsya/app/auth/model/profile_model.dart';
import 'package:travelsya/shared/api/api_return_value.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileFailed extends ProfileState {
  final ApiReturnValue data;

  const ProfileFailed(this.data);

  @override
  List<Object> get props => [data];
}

class ProfileLoaded extends ProfileState {
  final ProfileModel data;

  const ProfileLoaded(this.data);

  @override
  List<Object> get props => [data];
}
