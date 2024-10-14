import 'package:travelsya/shared/api/api_connection.dart';

class HostelPreviewModel {
  late int id;
  late String name;
  late String? image;
  late String? location;
  late double ratingAvg;
  late int ratingCount;
  late double sellingPrice;
  late String propertyType;
  late String rentCategory;
  late String roomType;
  late String furnishType;

  HostelPreviewModel.fromJson(Map<String, dynamic> jsonMap) {
    id = jsonMap['id'];
    name = jsonMap['name'];
    image = jsonMap['image'] == null
        ? null
        : jsonMap['image'].toString() == '-'
            ? null
            : jsonMap['image'].toString().contains('http')
                ? jsonMap['image']
                : "${baseUrl}storage/media/hostel/${jsonMap['image']}";
    location = jsonMap['location'];
    try {
      ratingAvg = double.parse(jsonMap['avg_rating'].toString());
    } catch (e) {
      ratingAvg = double.parse(jsonMap['rating_avg'].toString());
    }
    ratingCount = jsonMap['rating_count'];
    sellingPrice = double.parse(jsonMap['sellingprice'] == null
        ? '0'
        : jsonMap['sellingprice'].toString());
    propertyType = jsonMap['property_type'] == null
        ? '-'
        : jsonMap['property_type'].toString() == '-'
            ? '-'
            : jsonMap['property_type'];
    rentCategory = jsonMap['rent_category'];
    roomType = jsonMap['room_type'] ?? '-';
    furnishType = jsonMap['furnish_type'] ?? '-';
  }
}

class HostelModel {
  late int id;
  late int serviceId;
  late String name;
  late String? desc;
  late String? city;
  late String? address;
  late List<dynamic> facilities = [];
  late String? latitude;
  late String? longitude;
  late String? category;
  late String checkIn;
  late String checkOut;
  late int isActive;
  List<dynamic> rating = [];
  List<String> images = [];
  // List<HostelRoom> room = [];

  HostelModel.fromJson(Map<String, dynamic> jsonMap) {
    id = jsonMap['id'];
    serviceId = jsonMap['service_id'];
    name = jsonMap['name'];
    desc = jsonMap['description'];
    city = jsonMap['city'];
    address = jsonMap['address'];
    facilities = jsonMap['facilities'];
    latitude = jsonMap['lat'].toString();
    longitude = jsonMap['lon'].toString();
    category = jsonMap['category'];
    checkIn = jsonMap['checkin'];
    checkOut = jsonMap['checkout'];
    isActive = jsonMap['is_active'];

    rating = jsonMap['rating'] ?? [];
    for (var i = 0; i < jsonMap['hostel_image'].length; i++) {
      images.add(jsonMap['hostel_image'][i]['image']);
    }

    for (var i = 0; i < jsonMap['hostel_room'].length; i++) {
      // room.add(HostelRoom.fromJson(jsonMap['hostel_room'][i]));
    }
  }
}

class GuestModel {
  late String type;
  late String number;
  late String name;

  GuestModel({required this.type, required this.number, required this.name});
}
