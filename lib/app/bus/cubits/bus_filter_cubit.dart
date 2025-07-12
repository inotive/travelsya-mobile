import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travelsya/app/bus/cubits/bus_filter_state.dart';
import 'package:travelsya/app/bus/models/bus_filter_model.dart';
import 'package:travelsya/shared/function/show_snackbar.dart';
import 'package:travelsya/shared/widgets/city_picker_bottomsheet.dart';
import 'package:travelsya/shared/widgets/date_picker_single.dart';
import 'package:travelsya/shared/widgets/yes_or_no_dialog.dart';

class BusFilterCubit extends Cubit<BusFilterState> {
  BusFilterCubit() : super(BusFilterInitial());

  onResetData() {
    onLoadDataFilter(BusFilterModel(
      selectedDateGo: DateTime.now(),
    ));
  }

  onLoadDataFilter(BusFilterModel data) {
    emit(BustFilterLoading());
    emit(BusFilterLoaded(data));
  }

  onPickCity(BuildContext context,
      {bool isOrigin = true,
      CityPickerType type = CityPickerType.hotel}) async {
    BusFilterState stateFilter = state;
    if (stateFilter is BusFilterLoaded) {
      BusFilterModel dataFinal = stateFilter.data;

      String? result = await showCityPicker(context, type: CityPickerType.bus);

      if (result != null) {
        if (isOrigin) {
          dataFinal.selectedCityOrigin = result;
        } else {
          dataFinal.selectedCityDestination = result;
        }
        onLoadDataFilter(dataFinal);
      }
    }
  }

  onPickPassanger(BuildContext context) async {
    BusFilterState stateFilter = state;
    if (stateFilter is BusFilterLoaded) {
      BusFilterModel dataFinal = stateFilter.data;

      int? result = await modalBottomSheet(context,
          data: [
            '1',
            '2',
            '3',
            '4',
            '5',
            '6',
            '7',
            '8',
          ],
          title: 'Jumlah Penumpang');
      if (result != null) {
        dataFinal.totalPassanger = result + 1;
        onLoadDataFilter(dataFinal);
      }
    }
  }

  onPickDate(BuildContext context, {bool isStartDate = true}) async {
    BusFilterState stateFilter = state;
    if (stateFilter is BusFilterLoaded) {
      BusFilterModel dataFinal = stateFilter.data;

      DateTime? selected = await showDialog(
          context: context,
          builder: (context) {
            return DateSinglePicker(
              minDate: isStartDate ? DateTime.now() : dataFinal.selectedDateGo,
              selectedDate: isStartDate
                  ? dataFinal.selectedDateGo
                  : dataFinal.selectedDateBack,
            );
          });

      if (selected != null) {
        if (isStartDate) {
          dataFinal.selectedDateGo = selected;
        } else {
          dataFinal.selectedDateBack = selected;
        }

        onLoadDataFilter(dataFinal);
      }
    }
  }

  onChangeWaybackStatus(bool value) {
    BusFilterState stateFilter = state;
    if (stateFilter is BusFilterLoaded) {
      BusFilterModel dataFinal = stateFilter.data;
      dataFinal.isWayBack = value;
      onLoadDataFilter(dataFinal);
    }
  }

  onSearch(BuildContext context, {required Function onSuccess}) {
    BusFilterState stateFilter = state;
    if (stateFilter is BusFilterLoaded) {
      String? validation;

      if (stateFilter.data.isWayBack) {
        if (stateFilter.data.selectedDateBack == null) {
          validation = 'Mohon mengisi tanggal kepulangan';
        }
      }

      if (stateFilter.data.selectedCityOrigin == null) {
        validation = 'Mohon mengisi kota tujuan';
      }

      if (stateFilter.data.selectedCityOrigin == null) {
        validation = 'Mohon mengisi kota asal';
      }

      if (validation == null) {
        onSuccess();
      } else {
        showSnackbar(context, data: validation, colors: Colors.orange);
      }
    }
  }
}
