import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travelsya/app/rental_mobil/cubits/rental_mobil_city_state.dart';
import 'package:travelsya/app/rental_mobil/models/rental_mobil_model.dart';
import 'package:travelsya/app/rental_mobil/services/rental_mobil_service.dart';
import 'package:travelsya/shared/api/api_return_value.dart';

class RentalMobilCityCubit extends Cubit<RentalMobilCityState> {
  RentalMobilCityCubit() : super(RentalMobilCityInitial());

  Future<void> fetchCities(BuildContext context) async {
    emit(RentalMobilCityLoading());
    final response = await RentalMobilService.getCities(context);

    if (response.status == RequestStatus.successRequest) {
      final cities = response.data as List<RentalMobilCityModel>;
      emit(RentalMobilCityLoaded(cities));
    } else {
      emit(RentalMobilCityFailed(response.data ?? "Gagal memuat kota"));
    }
  }
}
