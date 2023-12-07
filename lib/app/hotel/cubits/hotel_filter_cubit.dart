import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:travelsya/app/hostel/widgets/count_picker_widget.dart';
import 'package:travelsya/app/hotel/cubits/hotel_cubit.dart';
import 'package:travelsya/app/hotel/cubits/hotel_state.dart';
import 'package:travelsya/app/hotel/widgets/hotel_city_picker.dart';
import 'package:travelsya/shared/widgets/multi_date_picker.dart';

class HotelFilterCubit extends Cubit<HotelState> {
  HotelFilterCubit() : super(HotelInitial());

  onInit() {
    emit(HotelSearchFilter(
        selectedTime: PickerDateRange(
            DateTime.now(), DateTime.now().add(const Duration(days: 1))),
        selectedLocation: '',
        roomCount: 1,
        guessCount: 1));
  }

  onRoomCountChanged(BuildContext context) async {
    HotelState state = this.state;

    if (state is HotelSearchFilter) {
      HotelSearchFilter data = state;

      int? result = await showDialog(
          context: context,
          builder: (context) {
            return CountPickerWidget(
              title: 'Jumlah Kamar',
              initialValue: data.roomCount,
            );
          });

      if (result != null) {
        data.roomCount = result;

        if ((result * 3) < data.guessCount) {
          data.guessCount = result * 3;
        }
        emit(HotelLoading());
        emit(data);
      }
    }
  }

  onGuessChanged(BuildContext context) async {
    HotelState state = this.state;
    if (state is HotelSearchFilter) {
      HotelSearchFilter data = state;

      int? result = await showDialog(
          context: context,
          builder: (context) {
            return CountPickerWidget(
              title: 'Jumlah Tamu',
              initialValue: data.guessCount,
            );
          });

      if (result != null) {
        data.guessCount = result;
        int recommentGuessRoom = data.guessCount ~/ 3;
        int peopleLeft = (result) - (recommentGuessRoom * 3);
        if (peopleLeft > 0) {
          recommentGuessRoom = recommentGuessRoom + 1;
        }

        if (data.roomCount < recommentGuessRoom) {
          data.roomCount = recommentGuessRoom;
        }

        emit(HotelLoading());
        emit(data);
      }
    }
  }

  onDateTap(BuildContext context) async {
    HotelState state = this.state;
    if (state is HotelSearchFilter) {
      HotelSearchFilter data = state;

      PickerDateRange? result = await showDialog(
          context: context,
          builder: (context) {
            return MultiDatePicker(
              minDate: DateTime.now(),
              selectedDate: data.selectedTime,
            );
          });

      if (result != null) {
        data.selectedTime = result;
        emit(HotelLoading());
        emit(data);
      }
    }
  }

  onRemoveLocation() {
    HotelState state = this.state;
    if (state is HotelSearchFilter) {
      HotelSearchFilter data = state;
      data.selectedLocation = '';
      emit(HotelLoading());
      emit(data);
    }
  }

  onLocationTap(BuildContext context, {required HotelCubit hotelCubit}) async {
    HotelState state = this.state;
    if (state is HotelSearchFilter) {
      HotelSearchFilter data = state;

      String? selected = await showModalBottomSheet(
          context: context,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          constraints: BoxConstraints(maxHeight: 90.0.h),
          isScrollControlled: true,
          builder: (context) {
            return HotelCityPicker(
              dataCubit: hotelCubit,
            );
          });

      if (selected != null) {
        data.selectedLocation = selected;
        emit(HotelLoading());
        emit(data);
      }
    }
  }
}
