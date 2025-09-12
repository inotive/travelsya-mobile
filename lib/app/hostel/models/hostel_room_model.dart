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
    roomSize = int.tryParse(jsonMap['room_size']?.toString() ?? '0') ?? 0;
    totalBed = int.tryParse(jsonMap['total_bed_room']?.toString() ?? '0') ?? 0;
    totalBath =
        int.tryParse(jsonMap['total_bath_room']?.toString() ?? '0') ?? 0;
    maxGuest = jsonMap['max_guest']?.toString() ?? '0';
    desc = jsonMap['description'];

    roomFacilities = (jsonMap['room_facilities'] ?? []) as List;

    images = [];
    if (jsonMap['room_images'] != null) {
      for (var img in jsonMap['room_images']) {
        final raw = img['image']?.toString();
        if (raw != null && raw.isNotEmpty) {
          if (raw.contains('http')) {
            images.add(raw);
          } else {
            images.add('${baseUrl}storage/$raw');
          }
        }
      }
    }
  }
}
