import 'package:equatable/equatable.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:travelsya/app/hotel/models/hotel_detail_model.dart';
import 'package:travelsya/app/hotel/models/hotel_preview_model.dart';
import 'package:travelsya/app/hotel/models/hotel_room_model.dart';
import 'package:travelsya/shared/api/api_return_value.dart';

abstract class HotelState extends Equatable {
  const HotelState();

  @override
  List<Object> get props => [];
}

class HotelInitial extends HotelState {}

class HotelLoading extends HotelState {}

class HotelFailed extends HotelState {
  final ApiReturnValue data;

  const HotelFailed(this.data);

  @override
  List<Object> get props => [data];
}

class PreviewHotelListLoaded extends HotelState {
  final List<HotelPreview> data;

  const PreviewHotelListLoaded(this.data);

  @override
  List<Object> get props => [data];
}

class HotelDetailLoaded extends HotelState {
  final HotelDetailModel data;

  const HotelDetailLoaded(this.data);

  @override
  List<Object> get props => [data];
}

class HotelRoomDetailLoaded extends HotelState {
  final HotelRoomDetail data;

  const HotelRoomDetailLoaded(this.data);

  @override
  List<Object> get props => [data];
}

class ListHotelCityLoaded extends HotelState {
  final List<String> data;

  const ListHotelCityLoaded(this.data);

  @override
  List<Object> get props => [data];
}

// ignore: must_be_immutable
class HotelSearchFilter extends HotelState {
  PickerDateRange selectedTime;
  String selectedLocation;
  int roomCount;
  int guessCount;

  HotelSearchFilter(
      {required this.selectedTime,
      required this.selectedLocation,
      required this.roomCount,
      required this.guessCount});

  @override
  List<Object> get props =>
      [selectedTime, selectedLocation, roomCount, guessCount];
}
