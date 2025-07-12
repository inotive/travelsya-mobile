import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travelsya/app/rental_mobil/cubits/rental_mobil_filter_cubit.dart';
import 'package:travelsya/app/rental_mobil/cubits/rental_mobil_filter_state.dart';
import 'package:travelsya/app/rental_mobil/cubits/rental_mobil_state.dart';
import 'package:travelsya/app/rental_mobil/services/rental_mobil_service.dart';
import 'package:travelsya/shared/api/api_return_value.dart';

class RentalMobilCubit extends Cubit<RentalMobilState> {
  RentalMobilCubit() : super(RentalMobilInitial());

  searchRentalMobil(BuildContext context) {
    RentalMobilFilterState state =
        BlocProvider.of<RentalMobilFilterCubit>(context).state;

    if (state is RentalMobilFilterLoaded) {
      emit(RentalMobilLoading());
      RentalMobilService.searchRentalMobil(context, filter: state.data)
          .then((value) {
        if (value.status == RequestStatus.successRequest) {
          emit(RentalMobilSearchLoaded(value.data));
        } else {
          emit(RentalMobilFailed(value));
        }
      });
    }
  }
}
