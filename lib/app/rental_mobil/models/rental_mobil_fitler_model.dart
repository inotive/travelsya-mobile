import 'package:flutter/material.dart';

class RentalMobilFitlerModel {
  String? selectedLocation;
  late DateTime selectedDate;
  late TimeOfDay selectedTime;
  int duration = 1;
  int tranmition = 0;
  bool isWithDriver = false;

  RentalMobilFitlerModel(
      {this.selectedLocation,
      required this.selectedDate,
      required this.selectedTime,
      this.isWithDriver = false,
      this.duration = 1,
      this.tranmition = 0});
}
