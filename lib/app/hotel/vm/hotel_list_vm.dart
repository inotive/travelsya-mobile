import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stacked/stacked.dart';
import 'package:travelsya/app/hotel/cubits/hotel_cubit.dart';
import 'package:travelsya/app/hotel/cubits/hotel_filter_cubit.dart';
import 'package:travelsya/app/hotel/cubits/hotel_state.dart';

class HotelListVM extends BaseViewModel {
  HotelCubit hotelCubit = HotelCubit();

  onInit(BuildContext context) {
    HotelState state = BlocProvider.of<HotelFilterCubit>(context).state;
    if (state is HotelSearchFilter) {
      hotelCubit.fetchHotelData(context, location: state.selectedLocation);
    }
  }
}
