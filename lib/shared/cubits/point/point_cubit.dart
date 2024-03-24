import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travelsya/shared/api/api_return_value.dart';
import 'package:travelsya/shared/cubits/point/point_repository.dart';
import 'package:travelsya/shared/cubits/point/point_state.dart';

class PointCubit extends Cubit<PointState> {
  PointCubit() : super(PointInitial());

  fetchPoint(BuildContext context) {
    emit(PointLoading());
    PointRepository.pointFetch(context).then((value) {
      if (value.status == RequestStatus.successRequest) {
        emit(PointLoaded(value.data));
      } else {
        emit(PointFailed());
      }
    });
  }
}
