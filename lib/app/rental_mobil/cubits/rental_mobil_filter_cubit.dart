import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travelsya/app/rental_mobil/cubits/rental_mobil_filter_state.dart';
import 'package:travelsya/app/rental_mobil/models/rental_mobil_fitler_model.dart';
import 'package:travelsya/shared/widgets/city_picker_bottomsheet.dart';
import 'package:travelsya/shared/widgets/date_picker_single.dart';
import 'package:travelsya/shared/widgets/yes_or_no_dialog.dart';

class RentalMobilFilterCubit extends Cubit<RentalMobilFilterState> {
  RentalMobilFilterCubit() : super(RentalMObilFilterInitial());

  onResetData() {
    onLoadDataFilter(RentalMobilFitlerModel(
        selectedDate: DateTime.now(), selectedTime: TimeOfDay.now()));
  }

  onLoadDataFilter(RentalMobilFitlerModel data) {
    emit(RentalMobilFilterLoadLoading());
    emit(RentalMobilFilterLoaded(data));
  }

  onPickCity(BuildContext context) async {
    RentalMobilFilterState stateFilter = state;
    if (stateFilter is RentalMobilFilterLoaded) {
      RentalMobilFitlerModel dataFinal = stateFilter.data;

      String? result = await showCityPicker(context);

      if (result != null) {
        dataFinal.selectedLocation = result;
        onLoadDataFilter(dataFinal);
      }
    }
  }

  onPickDuration(BuildContext context) async {
    RentalMobilFilterState stateFilter = state;
    if (stateFilter is RentalMobilFilterLoaded) {
      RentalMobilFitlerModel dataFinal = stateFilter.data;

      int? result = await modalBottomSheet(context,
          data: [
            '1 Hari',
            '2 Hari',
            '3 Hari',
            '4 Hari',
            '5 Hari',
            '6 Hari',
            '7 Hari'
          ],
          title: 'Durasi Penyewaan');
      if (result != null) {
        dataFinal.duration = result + 1;
        onLoadDataFilter(dataFinal);
      }
    }
  }

  onPickDate(BuildContext context) async {
    RentalMobilFilterState stateFilter = state;
    if (stateFilter is RentalMobilFilterLoaded) {
      RentalMobilFitlerModel dataFinal = stateFilter.data;

      DateTime? selected = await showDialog(
          context: context,
          builder: (context) {
            return DateSinglePicker(
              minDate: DateTime.now(),
              selectedDate: dataFinal.selectedDate,
            );
          });

      if (selected != null) {
        dataFinal.selectedDate = selected;
        onLoadDataFilter(dataFinal);
      }
    }
  }

  onPickHour(BuildContext context) async {
    RentalMobilFilterState stateFilter = state;
    if (stateFilter is RentalMobilFilterLoaded) {
      RentalMobilFitlerModel dataFinal = stateFilter.data;

      TimeOfDay? selected = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );

      if (selected != null) {
        dataFinal.selectedTime = selected;
        onLoadDataFilter(dataFinal);
      }
    }
  }

  onChangeDriverStatus(bool value) {
    RentalMobilFilterState stateFilter = state;
    if (stateFilter is RentalMobilFilterLoaded) {
      RentalMobilFitlerModel dataFinal = stateFilter.data;
      dataFinal.isWithDriver = value;
      onLoadDataFilter(dataFinal);
    }
  }

  onChangeTranmision(BuildContext context, int data) async {
    RentalMobilFilterState stateFilter = state;
    if (stateFilter is RentalMobilFilterLoaded) {
      RentalMobilFitlerModel dataFinal = stateFilter.data;

      dataFinal.tranmition = data;

      onLoadDataFilter(dataFinal);
    }
  }

  onPickTransmision(BuildContext context) async {
    RentalMobilFilterState stateFilter = state;
    if (stateFilter is RentalMobilFilterLoaded) {
      RentalMobilFitlerModel dataFinal = stateFilter.data;

      int? result = await modalBottomSheet(context,
          data: ['Semua', 'Manual', 'Automatic'],
          title: 'Pilih Tipe Transmisi Mobil');

      if (result != null) {
        dataFinal.tranmition = result;
        onLoadDataFilter(dataFinal);
      }
    }
  }
}
