import 'package:flutter/material.dart';
import 'package:travelsya/app/rental_mobil/models/rental_mobil_model.dart';

class RentalMobilFitlerModel {
  String? selectedLocation;
  late DateTime selectedDate;
  late TimeOfDay selectedTime;
  int duration = 1;
  int tranmition = 0;
  bool isWithDriver = false;

  List<RentalMobilCityModel>? allCities;

  RentalMobilFitlerModel(
      {this.selectedLocation,
      required this.selectedDate,
      required this.selectedTime,
      this.isWithDriver = false,
      this.duration = 1,
      this.tranmition = 0,
      this.allCities});
}
