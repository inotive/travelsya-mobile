import 'package:equatable/equatable.dart';
import 'package:travelsya/app/auth/model/user_model.dart';
import 'package:travelsya/shared/api/api_return_value.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthFailed extends AuthState {
  final ApiReturnValue data;

  const AuthFailed(this.data);

  @override
  List<Object> get props => [data];
}

class AuthLoaded extends AuthState {
  final UserModel data;

  const AuthLoaded(this.data);

  @override
  List<Object> get props => [data];
}
