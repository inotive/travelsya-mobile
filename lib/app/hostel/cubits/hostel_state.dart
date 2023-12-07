import 'package:equatable/equatable.dart';
import 'package:travelsya/app/hostel/models/hostel_detail_model.dart';
import 'package:travelsya/app/hostel/models/hostel_model.dart';
import 'package:travelsya/app/hostel/models/hostel_room_model.dart';
import 'package:travelsya/shared/api/api_return_value.dart';

abstract class HostelState extends Equatable {
  const HostelState();

  @override
  List<Object> get props => [];
}

class HostelInitial extends HostelState {}

class HostelLoading extends HostelState {}

class HostelFailed extends HostelState {
  final ApiReturnValue data;

  const HostelFailed(this.data);

  @override
  List<Object> get props => [data];
}

class HostelDetailRoomLoaded extends HostelState {
  final HostelRoomDetail data;

  const HostelDetailRoomLoaded(this.data);

  @override
  List<Object> get props => [data];
}

class ListHostelLoaded extends HostelState {
  final List<HostelModel> data;

  const ListHostelLoaded(this.data);

  @override
  List<Object> get props => [data];
}

class ListPreviewHostelLoaded extends HostelState {
  final List<HostelPreviewModel> data;

  const ListPreviewHostelLoaded(this.data);

  @override
  List<Object> get props => [data];
}

class DetailHostelLoaded extends HostelState {
  final HostelDetailModel data;

  const DetailHostelLoaded(this.data);

  @override
  List<Object> get props => [data];
}

class ListHostelCityLoaded extends HostelState {
  final List<String> data;

  const ListHostelCityLoaded(this.data);

  @override
  List<Object> get props => [data];
}

// ignore: must_be_immutable
class HostelSearchFilter extends HostelState {
  String selectedCity;
  DateTime startDate;
  String selectedDuration;
  int totalDuration;
  String propertyType;
  String roomType;
  String furnishType;

  HostelSearchFilter(
      {required this.selectedCity,
      required this.startDate,
      required this.selectedDuration,
      required this.totalDuration,
      required this.propertyType,
      required this.roomType,
      required this.furnishType});

  @override
  List<Object> get props => [
        selectedCity,
        startDate,
        selectedDuration,
        propertyType,
        roomType,
        furnishType
      ];
}
