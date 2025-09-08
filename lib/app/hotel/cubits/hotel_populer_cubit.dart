import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travelsya/app/hotel/cubits/hotel_state.dart';
import 'package:travelsya/app/hotel/repository/hotel_repository.dart';
import 'package:travelsya/shared/api/api_return_value.dart';

class HotelPopulerCubit extends Cubit<HotelState> {
  HotelPopulerCubit() : super(HotelInitial());

  fetchPopulerHotel(BuildContext context) {
    emit(HotelLoading());
    HotelRepository.fetchPopulerHotel(context).then((value) {
      if (value.status == RequestStatus.successRequest) {
        emit(PreviewHotelListLoaded(value.data));
      } else {
        emit(HotelFailed(value));
      }
    });
  }
}
