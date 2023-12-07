import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travelsya/app/ppob/cubits/ppob_state.dart';
import 'package:travelsya/app/ppob/repository/ppob_repository.dart';
import 'package:travelsya/shared/api/api_return_value.dart';

class PPOBCubit extends Cubit<PPOBState> {
  PPOBCubit() : super(PPOBInitial());

  fetchPPOBData(BuildContext context) {
    emit(PPOBLoading());
    PPOBRepository.fetchPPOBData(context).then((value) {
      if (value.status == RequestStatus.successRequest) {
        emit(PPOBLoaded(value.data));
      } else {
        emit(PPOBFailed(value));
      }
    });
  }
}
