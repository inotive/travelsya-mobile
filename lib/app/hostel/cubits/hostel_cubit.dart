import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travelsya/app/hostel/cubits/hostel_state.dart';
import 'package:travelsya/app/hostel/repository/hostel_repository.dart';
import 'package:travelsya/shared/api/api_return_value.dart';

class HostelCubit extends Cubit<HostelState> {
  HostelCubit() : super(HostelInitial());

  fetchDetailRoom(BuildContext context, {required String id}) {
    emit(HostelLoading());
    HostelRepository.fetchDetailHotelRoom(context, id: id).then((value) {
      if (value.status == RequestStatus.successRequest) {
        emit(HostelDetailRoomLoaded(value.data));
      } else {
        emit(HostelFailed(value));
      }
    });
  }

  fetchDetailHostel(BuildContext context,
      {required String id, required String durationType}) {
    emit(HostelLoading());
    HostelRepository.fetchDetailHostel(context,
            id: id, durationType: durationType)
        .then((value) {
      if (value.status == RequestStatus.successRequest) {
        emit(DetailHostelLoaded(value.data));
      } else {
        emit(HostelFailed(value));
      }
    });
  }

  fetchHostelData(BuildContext context, {required HostelSearchFilter filter}) {
    emit(HostelLoading());
    HostelRepository.fetchListHostel(context, filter: filter).then((value) {
      if (value.status == RequestStatus.successRequest) {
        emit(ListPreviewHostelLoaded(value.data));
      } else {
        emit(HostelFailed(value));
      }
    });
  }

  fetchPopulerHostel(BuildContext context) {
    emit(HostelLoading());
    HostelRepository.fetchPopulerHostel(
      context,
    ).then((value) {
      if (value.status == RequestStatus.successRequest) {
        emit(ListPreviewHostelLoaded(value.data));
      } else {
        emit(HostelFailed(value));
      }
    });
  }

  fetchHostelAvailableCity(BuildContext context) {
    emit(HostelLoading());
    HostelRepository.fetchCityAvailable(context).then((value) {
      if (value.status == RequestStatus.successRequest) {
        emit(ListHostelCityLoaded(value.data));
      } else {
        emit(HostelFailed(value));
      }
    });
  }
}
