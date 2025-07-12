import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stacked/stacked.dart';
import 'package:travelsya/app/rental_mobil/cubits/rental_mobil_cubit.dart';
import 'package:travelsya/app/rental_mobil/cubits/rental_mobil_filter_cubit.dart';

class RentalMobilSearchVM extends BaseViewModel {
  RentalMobilCubit rentalCubit = RentalMobilCubit();

  List<String> dataTransmisi = ['Semua', 'Manual', 'Automatic'];
  int selectedIndexFilter = 0;

  onChangeIndexFilter(BuildContext context, int value) {
    selectedIndexFilter = value;

    BlocProvider.of<RentalMobilFilterCubit>(context)
        .onChangeTranmision(context, value);
    rentalCubit.searchRentalMobil(context);

    notifyListeners();
  }
}
