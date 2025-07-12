import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stacked/stacked.dart';
import 'package:travelsya/app/bus/cubits/bus_cubit.dart';
import 'package:travelsya/app/bus/cubits/bus_filter_cubit.dart';
import 'package:travelsya/app/bus/cubits/bus_filter_state.dart';
import 'package:travelsya/app/bus/models/bus_model.dart';
import 'package:travelsya/app/bus/pages/bus_checkout_page.dart';
import 'package:travelsya/shared/function/need_login_function.dart';

class BusDetailVM extends BaseViewModel {
  BusDataModel? goData;
  BusDataModel? backData;

  BusCubit busSearchCubit = BusCubit();

  onTapDetail(BuildContext context, BusDataModel data) {
    BusFilterState state = BlocProvider.of<BusFilterCubit>(context).state;
    if (state is BusFilterLoaded) {
      if (state.data.isWayBack) {
        if (goData == null) {
          goData = data;
          notifyListeners();
        } else {
          needLoginFeature(context, () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => BusCheckoutPage(
                          goData: goData!,
                          backData: data,
                        )));
          });
        }
      } else {
        needLoginFeature(context, () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => BusCheckoutPage(
                        goData: data,
                        backData: null,
                      )));
        });
      }
    }
  }
}
