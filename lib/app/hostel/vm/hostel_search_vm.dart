import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';
import 'package:travelsya/app/hostel/cubits/hostel_cubit.dart';
import 'package:travelsya/app/hostel/cubits/hostel_filter_cubit.dart';
import 'package:travelsya/app/hostel/cubits/hostel_state.dart';
import 'package:travelsya/app/hostel/pages/hostel_list_page/hostel_list_page.dart';
import 'package:travelsya/shared/function/date_to_readable_function.dart';

class HostelSearchVM extends BaseViewModel {
  HostelCubit hostelCubit = HostelCubit();
  HostelCubit hostelPopularCubit = HostelCubit();
  HostelCubit locationHostelCubit = HostelCubit();

  onInit(BuildContext context) {
    BlocProvider.of<HostelFilterCubit>(context).onInit();
    hostelPopularCubit.fetchPopulerHostel(context);
  }

  String getEndSewa(
    BuildContext context,
  ) {
    HostelState state = BlocProvider.of<HostelFilterCubit>(context).state;
    if (state is HostelSearchFilter) {
      DateTime currentDate = state.startDate;

      if (state.selectedDuration == 'Bulanan') {
        int finalMonth = currentDate.month;
        finalMonth = finalMonth + state.totalDuration;
        currentDate = DateTime((currentDate.year + (finalMonth ~/ 12)),
            finalMonth % 12, currentDate.day);
      } else if (state.selectedDuration == 'Harian') {
        currentDate = currentDate.add(Duration(days: state.totalDuration));
      } else {
        int finalYear = currentDate.year;
        finalYear = finalYear + state.totalDuration;
        currentDate = DateTime(finalYear, currentDate.month, currentDate.day);
      }

      return dateToReadable(DateFormat('yyyy-MM-dd').format(currentDate));
    } else {
      return '';
    }
  }

  // onRoomCountChanged(BuildContext context) async {
  //   BlocProvider.of<HotelFilterCubit>(context).onRoomCountChanged(context);
  // }

  // onGuessChanged(BuildContext context) async {
  //   BlocProvider.of<HotelFilterCubit>(context).onGuessChanged(context);
  // }

  // onDateTap(BuildContext context) async {
  //   BlocProvider.of<HotelFilterCubit>(context).onDateTap(context);
  // }

  onLocationPickerRemove(BuildContext context) {
    BlocProvider.of<HostelFilterCubit>(context).onRemoveLocation();
  }

  onLocationPicker(BuildContext context) async {
    HostelState state = locationHostelCubit.state;
    if (state is HostelInitial) {
      locationHostelCubit.fetchHostelAvailableCity(context);
    }

    BlocProvider.of<HostelFilterCubit>(context)
        .onLocationTap(context, hotelCubit: locationHostelCubit);
  }

  onDurationTotalPicker(BuildContext context) async {
    BlocProvider.of<HostelFilterCubit>(context).onDurationPicker(
      context,
    );
  }

  onDurationTypePicker(BuildContext context) async {
    BlocProvider.of<HostelFilterCubit>(context).onDurationTypePicker(
      context,
    );
  }

  onPropertyTypePicker(BuildContext context) async {
    BlocProvider.of<HostelFilterCubit>(context).onPropertyTypePicker(
      context,
    );
  }

  onRoomTypePicker(BuildContext context) async {
    BlocProvider.of<HostelFilterCubit>(context).onRoomTypePicker(
      context,
    );
  }

  onFurnishPicker(BuildContext context) async {
    BlocProvider.of<HostelFilterCubit>(context).onFurnishPicker(
      context,
    );
  }

  onStartDatePicker(BuildContext context) async {
    BlocProvider.of<HostelFilterCubit>(context).onStartDatePicker(
      context,
    );
  }

  onSearchHostel(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (_) => const HostelListPage()));
  }

  // onSearchHotel(BuildContext context) {
  //   Navigator.push(
  //       context, MaterialPageRoute(builder: (_) => const HotelListPage()));
  // }
}
