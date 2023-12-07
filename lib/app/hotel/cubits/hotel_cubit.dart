import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travelsya/app/hotel/cubits/hotel_state.dart';
import 'package:travelsya/app/hotel/repository/hotel_repository.dart';
import 'package:travelsya/shared/api/api_return_value.dart';

class HotelCubit extends Cubit<HotelState> {
  HotelCubit() : super(HotelInitial());

  fetchDetailHotel(BuildContext context, {required String id}) {
    emit(HotelLoading());
    HotelRepository.fetchDetailHotel(context, id: id).then((value) {
      if (value.status == RequestStatus.successRequest) {
        emit(HotelDetailLoaded(value.data));
      } else {
        emit(HotelFailed(value));
      }
    });
  }

  fetchDetailRoom(BuildContext context, {required String id}) {
    emit(HotelLoading());
    HotelRepository.fetchDetailHotelRoom(context, id: id).then((value) {
      if (value.status == RequestStatus.successRequest) {
        emit(HotelRoomDetailLoaded(value.data));
      } else {
        emit(HotelFailed(value));
      }
    });
  }

  fetchHotelData(BuildContext context,
      {String name = '',
      String location = '',
      String? startDate,
      String? room,
      String? guest,
      String? endDate}) {
    emit(HotelLoading());
    HotelRepository.fetchListHotel(context,
            city: location, endDate: endDate, startDate: startDate)
        .then((value) {
      if (value.status == RequestStatus.successRequest) {
        emit(PreviewHotelListLoaded(value.data));
      } else {
        emit(HotelFailed(value));
      }
    });
  }

  fetchPopulerHotel(BuildContext context) {
    emit(HotelLoading());
    HotelRepository.fetchPopulerHotel(
      context,
    ).then((value) {
      if (value.status == RequestStatus.successRequest) {
        emit(PreviewHotelListLoaded(value.data));
      } else {
        emit(HotelFailed(value));
      }
    });
  }

  fetchHotelAvailableCity(BuildContext context,
      {Function(List<String>)? onDataReady}) {
    emit(HotelLoading());
    HotelRepository.fetchCityAvailable(context).then((value) {
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
}
