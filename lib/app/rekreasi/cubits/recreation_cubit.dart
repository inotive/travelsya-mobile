import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travelsya/app/rekreasi/cubits/recreation_state.dart';
import 'package:travelsya/app/rekreasi/models/recreation_model.dart';
import 'package:travelsya/app/rekreasi/services/recreation_service.dart';
import 'package:travelsya/shared/api/api_return_value.dart';

class RecreationCubit extends Cubit<RecreationState> {
  RecreationCubit() : super(RecreationInitial());

  onLoadSearchRecreation(BuildContext context, {String? city, String? name}) {
    emit(RecreationLoading());
    RecreationService.recreationSearch(context,
            city: city ?? '', name: name ?? '')
        .then((value) {
      if (value.status == RequestStatus.successRequest) {
        emit(RecreationPreviewListLoaded(value.data));
      } else {
        emit(RecreationFailed(value));
      }
    });
  }

  onLoadDetailRecreation(BuildContext context, {required String id}) {
    emit(RecreationLoading());
    RecreationService.recreationDetail(context, id: id).then((value) {
      if (value.status == RequestStatus.successRequest) {
        emit(RecreationDetailLoaded(value.data));
      } else {
        emit(RecreationFailed(value));
      }
    });
  }

  onLoadRecreationPreviewByCategory(BuildContext context,
      {required String id}) {
    emit(RecreationLoading());
    RecreationService.recreationByCategory(context, id: id).then((value) {
      if (value.status == RequestStatus.successRequest) {
        emit(RecreationPreviewListLoaded(value.data));
      } else {
        emit(RecreationFailed(value));
      }
    });
  }

  fetchRecreationCategory(BuildContext context,
      {Function(List<RecreationCategoryModel> data)? onDataReady}) {
    emit(RecreationLoading());
    RecreationService.recreationCategory(
      context,
    ).then((value) {
      if (value.status == RequestStatus.successRequest) {
        if (onDataReady != null) {
          onDataReady(value.data);
        }
        emit(RecreationCategoryLoaded(value.data));
      } else {
        emit(RecreationFailed(value));
      }
    });
  }

  fetchRecreationAvailableCity(
    BuildContext context, {
    void Function(List<RecreationCityModel>)? onDataReady,
  }) {
    emit(RecreationLoading());
    RecreationService.fetchCityAvailable(context).then((value) {
      if (value.status == RequestStatus.successRequest) {
        final data = value.data as List<RecreationCityModel>;
        if (onDataReady != null) {
          onDataReady(data);
        }
        emit(ListRecreationCityLoaded(data));
      } else {
        emit(RecreationFailed(value));
      }
    }).catchError((e) {
      emit(RecreationFailed(
          ApiReturnValue(data: e.toString(), status: RequestStatus.failed)));
    });
  }
}
