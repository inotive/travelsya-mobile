import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travelsya/app/bus/cubits/bus_city_state.dart';
import 'package:travelsya/app/bus/models/bus_model.dart';
import 'package:travelsya/app/bus/services/bus_service.dart';
import 'package:travelsya/shared/api/api_return_value.dart';

class BusCityCubit extends Cubit<BusCityState> {
  BusCityCubit() : super(BusCityInitial());

  Future<void> fetchCities(BuildContext context) async {
    emit(BusCityLoading());
    final response = await BusService.getCities(context);

    if (response.status == RequestStatus.successRequest) {
      final cities = response.data as List<BusCityModel>;
      emit(BusCityLoaded(cities));
    } else {
      emit(BusCityFailed(response.data ?? "Gagal memuat kota"));
    }
  }
}
