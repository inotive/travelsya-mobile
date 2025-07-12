import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travelsya/app/bus/cubits/bus_filter_cubit.dart';
import 'package:travelsya/app/bus/cubits/bus_filter_state.dart';
import 'package:travelsya/app/bus/cubits/bus_state.dart';
import 'package:travelsya/app/bus/services/bus_service.dart';
import 'package:travelsya/shared/api/api_return_value.dart';

class BusCubit extends Cubit<BusState> {
  BusCubit() : super(BusInitial());

  searchRentalMobil(BuildContext context) {
    BusFilterState state = BlocProvider.of<BusFilterCubit>(context).state;

    if (state is BusFilterLoaded) {
      emit(BusLoading());
      BusService.searchBus(context, filter: state.data).then((value) {
        if (value.status == RequestStatus.successRequest) {
          emit(BusSearchLoaded(value.data[0], value.data[1]));
        } else {
          emit(BusFailed(value));
        }
      });
    }
  }
}
