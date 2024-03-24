import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:travelsya/app/hostel/cubits/hostel_cubit.dart';
import 'package:travelsya/app/hostel/cubits/hostel_state.dart';
import 'package:travelsya/app/hostel/widgets/duration_picker_widget.dart';
import 'package:travelsya/app/hostel/widgets/hostel_city_picker.dart';
import 'package:travelsya/shared/widgets/date_picker_single.dart';
import 'package:travelsya/shared/widgets/yes_or_no_dialog.dart';

class HostelFilterCubit extends Cubit<HostelState> {
  HostelFilterCubit() : super(HostelInitial());

  onInit() {
    emit(HostelSearchFilter(
        furnishType: 'Semua',
        propertyType: 'Semua',
        roomType: 'Semua',
        selectedCity: '',
        selectedDuration: 'Bulanan',
        startDate: DateTime.now(),
        totalDuration: 1));
  }

  // onRoomCountChanged(BuildContext context) async {
  //   HotelState state = this.state;

  //   if (state is HotelSearchFilter) {
  //     HotelSearchFilter data = state;

  //     int? result = await showDialog(
  //         context: context,
  //         builder: (context) {
  //           return CountPickerWidget(
  //             title: 'Jumlah Kamar',
  //             initialValue: data.roomCount,
  //           );
  //         });

  //     if (result != null) {
  //       data.roomCount = result;

  //       if ((result * 3) < data.guessCount) {
  //         data.guessCount = result * 3;
  //       }
  //       emit(HotelLoading());
  //       emit(data);
  //     }
  //   }
  // }

  // onGuessChanged(BuildContext context) async {
  //   HotelState state = this.state;
  //   if (state is HotelSearchFilter) {
  //     HotelSearchFilter data = state;

  //     int? result = await showDialog(
  //         context: context,
  //         builder: (context) {
  //           return CountPickerWidget(
  //             title: 'Jumlah Tamu',
  //             initialValue: data.guessCount,
  //           );
  //         });

  //     if (result != null) {
  //       data.guessCount = result;
  //       int recommentGuessRoom = data.guessCount ~/ 3;
  //       int peopleLeft = (result) - (recommentGuessRoom * 3);
  //       if (peopleLeft > 0) {
  //         recommentGuessRoom = recommentGuessRoom + 1;
  //       }

  //       if (data.roomCount < recommentGuessRoom) {
  //         data.roomCount = recommentGuessRoom;
  //       }

  //       emit(HotelLoading());
  //       emit(data);
  //     }
  //   }
  // }

  // onDateTap(BuildContext context) async {
  //   HotelState state = this.state;
  //   if (state is HotelSearchFilter) {
  //     HotelSearchFilter data = state;

  //     PickerDateRange? result = await showDialog(
  //         context: context,
  //         builder: (context) {
  //           return MultiDatePicker(
  //             minDate: DateTime.now(),
  //             selectedDate: data.selectedTime,
  //           );
  //         });

  //     if (result != null) {
  //       data.selectedTime = result;
  //       emit(HotelLoading());
  //       emit(data);
  //     }
  //   }
  // }

  onRemoveLocation() {
    HostelState state = this.state;
    if (state is HostelSearchFilter) {
      HostelSearchFilter data = state;
      data.selectedCity = '';
      emit(HostelLoading());
      emit(data);
    }
  }

  onLocationTap(BuildContext context, {required HostelCubit hotelCubit}) async {
    HostelState state = this.state;
    if (state is HostelSearchFilter) {
      HostelSearchFilter data = state;

      String? selected = await showModalBottomSheet(
          context: context,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          constraints: BoxConstraints(maxHeight: 90.0.h),
          isScrollControlled: true,
          builder: (context) {
            return HostelCityPicker(
              dataCubit: hotelCubit,
            );
          });

      if (selected != null) {
        data.selectedCity = selected;
        emit(HostelLoading());
        emit(data);
      }
    }
  }

  onDurationPicker(
    BuildContext context,
  ) async {
    HostelState state = this.state;
    if (state is HostelSearchFilter) {
      HostelSearchFilter data = state;
      int? selected = await showDialog(
          context: context,
          builder: (context) {
            return HostelDurationPickerWidget(currentData: data.totalDuration);
          });

      if (selected != null) {
        data.totalDuration = selected;
        emit(HostelLoading());
        emit(data);
      }
    }
  }

  onDurationTypePicker(
    BuildContext context,
  ) async {
    HostelState state = this.state;
    if (state is HostelSearchFilter) {
      HostelSearchFilter data = state;
      List<String> dataTypeDuration = ['Bulanan', 'Tahunan'];
      int? selected = await modalBottomSheet(context,
          data: dataTypeDuration, title: 'Tipe Durasi');

      if (selected != null) {
        data.selectedDuration = dataTypeDuration[selected];
        emit(HostelLoading());
        emit(data);
      }
    }
  }

  onPropertyTypePicker(BuildContext context) async {
    HostelState state = this.state;
    if (state is HostelSearchFilter) {
      HostelSearchFilter data = state;
      List<String> dataTypeDuration = [
        'Semua',
        'Apartemen',
        'Rumah',
        'Villa',
        'Residance'
      ];
      int? selected = await modalBottomSheet(context,
          data: dataTypeDuration, title: 'Tipe Properti');

      if (selected != null) {
        data.propertyType = dataTypeDuration[selected];
        emit(HostelLoading());
        emit(data);
      }
    }
  }

  onRoomTypePicker(BuildContext context) async {
    HostelState state = this.state;
    if (state is HostelSearchFilter) {
      HostelSearchFilter data = state;
      List<String> dataTypeDuration = ['Semua', 'Studio', '1BR', '2BR', '3BR+'];
      int? selected = await modalBottomSheet(context,
          data: dataTypeDuration, title: 'Tipe Room');

      if (selected != null) {
        data.roomType = dataTypeDuration[selected];
        emit(HostelLoading());
        emit(data);
      }
    }
  }

  onStartDatePicker(BuildContext context) async {
    HostelState state = this.state;
    if (state is HostelSearchFilter) {
      HostelSearchFilter data = state;

      DateTime? selected = await showDialog(
          context: context,
          builder: (context) {
            return DateSinglePicker(
              minDate: DateTime.now(),
              selectedDate: data.startDate,
            );
          });

      if (selected != null) {
        data.startDate = selected;
        emit(HostelLoading());
        emit(data);
      }
    }
  }

  onFurnishPicker(BuildContext context) async {
    HostelState state = this.state;
    if (state is HostelSearchFilter) {
      HostelSearchFilter data = state;
      List<String> dataTypeDuration = [
        'Semua',
        'Full Furnished',
        'Non Furnished'
      ];
      int? selected = await modalBottomSheet(context,
          data: dataTypeDuration, title: 'Tipe Furnish');

      if (selected != null) {
        data.furnishType = dataTypeDuration[selected];
        emit(HostelLoading());
        emit(data);
      }
    }
  }
}
