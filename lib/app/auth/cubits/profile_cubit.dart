import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travelsya/app/auth/cubits/profile_state.dart';
import 'package:travelsya/app/auth/repository/auth_repository.dart';
import 'package:travelsya/shared/api/api_return_value.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());

  fetchProfile(BuildContext context) {
    emit(ProfileLoading());
    AuthRepository.fetchProfile(context).then((value) {
      if (value.status == RequestStatus.successRequest) {
        emit(ProfileLoaded(value.data));
      } else {
        emit(ProfileFailed(value));
      }
    });
  }
}
