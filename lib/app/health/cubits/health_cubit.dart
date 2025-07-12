import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travelsya/app/health/cubits/health_state.dart';
import 'package:travelsya/app/health/services/health_service.dart';
import 'package:travelsya/shared/api/api_return_value.dart';

class HealthCubit extends Cubit<HealthState> {
  HealthCubit() : super(HealthInitial());

  searchClinic(BuildContext context, {String? city, bool isHealth = true}) {
    emit(HealthLoading());
    HealthService.healthSearch(context, city: city, isHealth: isHealth)
        .then((value) {
      if (value.status == RequestStatus.successRequest) {
        emit(HealthSearchLoaded(value.data));
      } else {
        emit(HealthFailed(value));
      }
    });
  }

  fetchDetailClinic(BuildContext context, {required String id}) {
    emit(HealthLoading());
    HealthService.clinicDetail(context, id: id).then((value) {
      if (value.status == RequestStatus.successRequest) {
        emit(HealthDetailLoaded(value.data));
      } else {
        emit(HealthFailed(value));
      }
    });
  }

  fetchHealthBeautyHome(
    BuildContext context,
  ) {
    emit(HealthLoading());
    HealthService.healthBeautyHome(
      context,
    ).then((value) {
      if (value.status == RequestStatus.successRequest) {
        emit(HealthBeautyHomeLoaded(value.data[0], value.data[1]));
      } else {
        emit(HealthFailed(value));
      }
    });
  }

  fetchHealthCategory(BuildContext context, {bool isHealth = true}) {
    emit(HealthLoading());
    HealthService.healthHome(context, isHealth: isHealth).then((value) {
      if (value.status == RequestStatus.successRequest) {
        emit(HealthHomeLoaded(value.data[0], value.data[1]));
      } else {
        emit(HealthFailed(value));
      }
    });
  }
}
