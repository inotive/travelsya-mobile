import 'package:travelsya/shared/api/api_connection.dart';

class HostelDetailModel {
  late int id;
  late String name;
  late String category;
  late String? image;
  late String checkIn;
  late String checkOut;
  late String location;
  late String? address;
  late String? latitude;
  late String? longitude;
  late double avgRating;
  late int ratingCount;
  List<String> images = [];
  List<HostelRoom> room = [];
  List<dynamic> facilities = [];
  List<HostelReview> reviews = [];

  HostelDetailModel.fromJson(Map<String, dynamic> jsonMap) {
    id = jsonMap['id'];
    name = jsonMap['name'];
    category = jsonMap['category'];
    image = jsonMap['image'];
    checkIn = jsonMap['checkin'];
    checkOut = jsonMap['checkout'];
    location = jsonMap['location'];
    address = jsonMap['address'];
    latitude = jsonMap['lat'].toString() == '-' ? null : jsonMap['lat'];
    longitude = jsonMap['lon'].toString() == '-' ? null : jsonMap['lon'];
    avgRating = double.parse(jsonMap['avg_rating'].toString());
    ratingCount = jsonMap['rating_count'];
    room = List.generate(jsonMap['hostel_rooms'].length, (index) {
      return HostelRoom.fromJson(jsonMap['hostel_rooms'][index]);
    });
    try {
      Map<String, dynamic> jsonMapFacilities = jsonMap['hostel_facilities'];

      jsonMapFacilities.forEach((key, value) {
        facilities.add(jsonMapFacilities[key]);
      });
    } catch (e) {}

    reviews = List.generate(jsonMap['hostel_reviews'].length, (index) {
      return HostelReview.fromJson(jsonMap['hostel_reviews'][index]);
    });

    for (var index = 0; index < jsonMap['hostel_image'].length; index++) {
      String? imageTemp = image = jsonMap['image'] == null
          ? null
          : jsonMap['hostel_image'][index]['image'].toString() == '-'
              ? null
              : jsonMap['hostel_image'][index]['image']
                      .toString()
                      .contains('http')
                  ? jsonMap['hostel_image'][index]['image']
                  : "${baseUrl}storage/media/hostel/${jsonMap['hostel_image'][index]['image']}";

      if (imageTemp != null) {
        images.add(imageTemp);
      }
    }
  }
}

class HostelRoom {
  late int id;
  late String name;
  late String? desc;
  late double price;
  late double sellingPrice;
  late String bedType;
  late int roomSize;
  late int maxExtBed;
  late int extBedPrice;
  late int totalRoom;
  late String guest;
  List<String> images = [];

  HostelRoom.fromJson(Map<String, dynamic> jsonMap) {
    id = jsonMap['id'];
    name = jsonMap['name'];
    desc = jsonMap['description'] ?? '';
    price = double.parse(
        jsonMap['price'] == null ? '0' : jsonMap['price'].toString());
    sellingPrice = double.parse(jsonMap['sellingprice'] == null
        ? '0'
        : jsonMap['sellingprice'].toString());
    guest = jsonMap['guest'] ?? '0';
    bedType = jsonMap['bed_type'] ?? '-';
    roomSize = jsonMap['roomsize'];
    maxExtBed = jsonMap['maxextrabed'] ?? 0;
    extBedPrice = jsonMap['maxextrabed'] ?? 0;
    totalRoom = jsonMap['totalroom'];
    try {
      for (var i = 0; i < jsonMap['hostel_room_image'].length; i++) {
        String imageUrlTemp = jsonMap['hostel_room_image'][i]['image'] == null
            ? null
            : jsonMap['hostel_room_image'][i]['image'].toString() == '-'
                ? null
                : jsonMap['hostel_room_image'][i]['image']
                        .toString()
                        .contains('https')
                    ? jsonMap['hostel_room_image'][i]['image']
                    : "$baseUrl${jsonMap['hostel_room_image'][i]['image']}";
        images.add(imageUrlTemp);
      }
    } catch (e) {}
  }
}

class HostelReview {
  late int rate;
  late String comment;
  late int userId;
  String? username;
  String? createdAt;

  HostelReview.fromJson(Map<String, dynamic> jsonMap) {
    rate = jsonMap['rate'];
    comment = jsonMap['comment'];
    userId = jsonMap['user_id'];
    username = jsonMap['user_name'];
    createdAt = jsonMap['created_at'];
  }
}

class HostelRules {
  late int id;
  late String name;
  late String desc;

  HostelRules.fromJson(Map<String, dynamic> jsonMap) {
    id = jsonMap['id'];
    name = jsonMap['name'];
    desc = jsonMap['description'];
  }
}
