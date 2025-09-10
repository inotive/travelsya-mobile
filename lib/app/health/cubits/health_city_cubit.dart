import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travelsya/app/health/cubits/health_state.dart';
import 'package:travelsya/app/health/models/health_model.dart';
import 'package:travelsya/app/health/services/health_service.dart';
import 'package:travelsya/shared/api/api_return_value.dart';
import 'package:travelsya/shared/widgets/city_picker_bottomsheet.dart';

class HealthCityCubit extends Cubit<HealthCityState> {
  HealthCityCubit() : super(HealthCityInitial());

  Future<void> fetchCities(
    BuildContext context, {
    Function(List<HealthCityModel>)? onDataReady,
    CityPickerType type = CityPickerType.health,
  }) async {
    emit(HealthCityLoading());

    final value = await HealthService.getCities(context, type: type);
    print("DEBUG => status: ${value.status}, data: ${value.data}");

    if (value.status == RequestStatus.successRequest) {
      final List<HealthCityModel> cities =
          (value.data as List).map((e) => HealthCityModel.fromJson(e)).toList();

      if (onDataReady != null) {
        onDataReady(cities);
      }
      emit(HealthCityLoaded(cities));
    } else {
      emit(const HealthCityFailed('Gagal memuat health'));
    }
  }
}
