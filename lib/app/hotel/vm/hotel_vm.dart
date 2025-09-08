import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stacked/stacked.dart';
import 'package:travelsya/app/hotel/cubits/hotel_by_location_cubit.dart';
import 'package:travelsya/app/hotel/cubits/hotel_city_cubit.dart';
import 'package:travelsya/app/hotel/cubits/hotel_cubit.dart';
import 'package:travelsya/app/hotel/cubits/hotel_filter_cubit.dart';
import 'package:travelsya/app/hotel/cubits/hotel_populer_cubit.dart';
import 'package:travelsya/app/hotel/pages/hotel_list_page/hotel_list_page.dart';

class HotelVM extends BaseViewModel {
  final HotelCubit hotelCubit;
  final HotelPopulerCubit hotelCubitSearch;
  final HotelCityCubit locationHotelCubit;
  final HotelByLocationCubit hotelByLocationCubit;

  String selectedCity = '';

  HotelVM(BuildContext context)
      : hotelCubit = BlocProvider.of<HotelCubit>(context),
        hotelCubitSearch = BlocProvider.of<HotelPopulerCubit>(context),
        locationHotelCubit = BlocProvider.of<HotelCityCubit>(context),
        hotelByLocationCubit = BlocProvider.of<HotelByLocationCubit>(context) {
    onInit(context);
  }

  void onInit(BuildContext context) {
    BlocProvider.of<HotelFilterCubit>(context).onInit();

    locationHotelCubit.fetchHotelAvailableCity(context, onDataReady: (data) {
      if (data.isNotEmpty) {
        initCityHotel(context, data[0]);
      }
    });

    hotelCubitSearch.fetchPopulerHotel(context);
  }

  void initCityHotel(BuildContext context, String city) {
    selectedCity = city;
    hotelByLocationCubit.fetchHotelByLocation(context, city);
    notifyListeners();
  }

  void onChangeIndexCity(BuildContext context, String value) {
    selectedCity = value;
    hotelByLocationCubit.fetchHotelByLocation(context, value);
    notifyListeners();
  }

  void onRoomCountChanged(BuildContext context) async {
    BlocProvider.of<HotelFilterCubit>(context).onRoomCountChanged(context);
  }

  void onGuessChanged(BuildContext context) async {
    BlocProvider.of<HotelFilterCubit>(context).onGuessChanged(context);
  }

  void onDateTap(BuildContext context) async {
    BlocProvider.of<HotelFilterCubit>(context).onDateTap(context);
  }

  void onLocationPickerRemove(BuildContext context) {
    BlocProvider.of<HotelFilterCubit>(context).onRemoveLocation();
  }

  void onSearchHotel(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const HotelListPage()),
    );
  }
}
