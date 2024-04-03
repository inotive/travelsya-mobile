import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travelsya/app/homepage/cubits/ads_state.dart';
import 'package:travelsya/app/homepage/repository/ads_repository.dart';
import 'package:travelsya/shared/api/api_return_value.dart';

class AdsCubit extends Cubit<AdsState> {
  AdsCubit() : super(AdsInitial());

  fetchAdsData(BuildContext context) {
    emit(AdsLoading());
    AdsRepository.fetchAds(context).then((value) {
      if (value.status == RequestStatus.successRequest) {
        emit(AdsLoaded(value.data));
      } else {
        emit(AdsFailed(value));
      }
    });
  }
}
