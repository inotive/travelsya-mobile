import 'package:travelsya/shared/api/api_connection.dart';

class HostelRoomDetail {
  late int roomSize;
  late int totalBed;
  late int totalBath;
  late String maxGuest;
  String? desc;
  List<String> images = [];
  List<dynamic> roomFacilities = [];

  HostelRoomDetail.fromJson(Map<String, dynamic> jsonMap) {
    roomSize = jsonMap['room_size'];
    maxGuest = jsonMap['max_guest'].toString();
    totalBed = jsonMap['total_bed_room'];
    totalBath = jsonMap['total_bath_room'];
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
