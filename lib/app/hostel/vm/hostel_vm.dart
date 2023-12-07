import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stacked/stacked.dart';
import 'package:travelsya/app/hostel/cubits/hostel_cubit.dart';
import 'package:travelsya/app/hostel/cubits/hostel_filter_cubit.dart';
import 'package:travelsya/app/hostel/cubits/hostel_state.dart';

class HostelListVM extends BaseViewModel {
  HostelCubit hostelCubit = HostelCubit();

  onInit(BuildContext context) {
    HostelState state = BlocProvider.of<HostelFilterCubit>(context).state;
    if (state is HostelSearchFilter) {
      hostelCubit.fetchHostelData(context, filter: state);
    }
  }
}
