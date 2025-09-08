import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travelsya/app/hotel/cubits/hotel_state.dart';
import 'package:travelsya/app/hotel/repository/hotel_repository.dart';
import 'package:travelsya/shared/api/api_return_value.dart';
import 'package:travelsya/shared/widgets/city_picker_bottomsheet.dart';

class HotelCityCubit extends Cubit<HotelState> {
  HotelCityCubit() : super(HotelInitial());

  fetchHotelAvailableCity(BuildContext context,
      {Function(List<String>)? onDataReady,
      CityPickerType type = CityPickerType.hotel}) {
    emit(HotelLoading());
    HotelRepository.fetchCityAvailable(context, type: type).then((value) {
      print(
          "DEBUG HotelCityCubit => status: ${value.status}, data: ${value.data}");
      if (value.status == RequestStatus.successRequest) {
        if (onDataReady != null) {
          onDataReady(value.data);
        }
        emit(ListHotelCityLoaded(value.data));
      } else {
        emit(HotelFailed(value));
      }
    });
  }

  fetchHotelByLocation(BuildContext context, String city) {
    emit(HotelLoading());
    HotelRepository.fetchListHotel(context, city: city).then((value) {
      if (value.status == RequestStatus.successRequest) {
        emit(PreviewHotelListLoaded(value.data));
      } else {
        emit(HotelFailed(value));
      }
    });
  }
}
