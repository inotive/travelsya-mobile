import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stacked/stacked.dart';
import 'package:travelsya/app/hostel/cubits/hostel_cubit.dart';
import 'package:travelsya/app/hotel/cubits/hotel_cubit.dart';
import 'package:travelsya/app/hotel/cubits/hotel_filter_cubit.dart';
import 'package:travelsya/app/hotel/cubits/hotel_state.dart';
import 'package:travelsya/app/hotel/pages/hotel_list_page/hotel_list_page.dart';

class HotelVM extends BaseViewModel {
  HostelCubit hostelCubit = HostelCubit();
  HotelCubit hostelCubitSearch = HotelCubit();
  HotelCubit locationHotelCubit = HotelCubit();
  HotelCubit hotelByLocationCubit = HotelCubit();

  String selectedCity = '';

  initCityHotel(BuildContext context, String city) {
    selectedCity = city;
    hotelByLocationCubit.fetchHotelData(context, location: city);

    notifyListeners();
  }

  onInit(BuildContext context) {
    BlocProvider.of<HotelFilterCubit>(context).onInit();
    locationHotelCubit.fetchHotelAvailableCity(context, onDataReady: (data) {
      initCityHotel(context, data[0]);
    });
    hostelCubitSearch.fetchPopulerHotel(context);
  }

  onChangeIndexCity(BuildContext context, String value) {
    selectedCity = value;
    hotelByLocationCubit.fetchHotelData(context, location: value);
    notifyListeners();
  }

  onRoomCountChanged(BuildContext context) async {
    BlocProvider.of<HotelFilterCubit>(context).onRoomCountChanged(context);
  }

  onGuessChanged(BuildContext context) async {
    BlocProvider.of<HotelFilterCubit>(context).onGuessChanged(context);
  }

  onDateTap(BuildContext context) async {
    BlocProvider.of<HotelFilterCubit>(context).onDateTap(context);
  }

  onLocationPickerRemove(BuildContext context) {
    BlocProvider.of<HotelFilterCubit>(context).onRemoveLocation();
  }

  onLocationPicker(BuildContext context) async {
    HotelState state = locationHotelCubit.state;
    if (state is HotelInitial) {
      locationHotelCubit.fetchHotelAvailableCity(context);
    }

    BlocProvider.of<HotelFilterCubit>(context)
        .onLocationTap(context, hotelCubit: locationHotelCubit);
  }

  onSearchHotel(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (_) => const HotelListPage()));
  }
}
