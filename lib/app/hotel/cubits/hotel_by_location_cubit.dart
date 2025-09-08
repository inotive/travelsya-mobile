import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travelsya/app/hotel/cubits/hotel_state.dart';
import 'package:travelsya/app/hotel/repository/hotel_repository.dart';
import 'package:travelsya/shared/api/api_return_value.dart';

class HotelByLocationCubit extends Cubit<HotelState> {
  HotelByLocationCubit() : super(HotelInitial());

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
