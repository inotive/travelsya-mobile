import 'package:travelsya/shared/api/api_connection.dart';

class HotelRoomDetail {
  late int roomSize;
  late int maxGuest;
  String? desc;
  List<String> images = [];
  List<dynamic> roomFacilities = [];

  HotelRoomDetail.fromJson(Map<String, dynamic> jsonMap) {
    roomSize = jsonMap['room_size'];
    maxGuest = jsonMap['max_guest'];
    desc = jsonMap['description'];
    roomFacilities = jsonMap['room_facilities'];
    for (var i = 0; i < jsonMap['room_images'].length; i++) {
      if (jsonMap['room_images'][i].toString().contains('http')) {
        images.add(jsonMap['room_images'][i]['image']);
      } else {
        images.add('${baseUrl}storage/${jsonMap['room_images'][i]['image']}');
      }
    }
  }
}
