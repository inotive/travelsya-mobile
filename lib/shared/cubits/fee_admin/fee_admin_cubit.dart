import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travelsya/shared/api/api_return_value.dart';
import 'package:travelsya/shared/cubits/fee_admin/fee_admin_repository.dart';
import 'package:travelsya/shared/cubits/fee_admin/fee_admin_state.dart';

class FeeAdminCubit extends Cubit<FeeAdminState> {
  FeeAdminCubit() : super(FeeAdminInitial());

  fetchFeeAdmin(BuildContext context) {
    emit(FeeAdminLoading());
    FeeAdminRepository.fetchFeeAdmin(context).then((value) {
      if (value.status == RequestStatus.successRequest) {
        emit(FeeAdminLoaded(value.data));
      } else {
        emit(FeeAdminFailed());
      }
    });
  }
}
