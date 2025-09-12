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
    } catch (e) {
      facilities = [];
    }

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
  late String desc;
  late double price;
  late double sellingPrice;
  late String bedType;
  late int roomSize;
  late int maxExtBed;
  late int extBedPrice;
  late int totalRoom;
  late String guest;
  late int roomLeft;
  List<String> images = [];

  HostelRoom.fromJson(Map<String, dynamic> jsonMap) {
    id = jsonMap['id'] ?? 0;
    name = jsonMap['name'] ?? '-';
    desc = jsonMap['description'] ?? '';
    price = double.tryParse(jsonMap['price']?.toString() ?? '0') ?? 0;
    sellingPrice =
        double.tryParse(jsonMap['sellingprice']?.toString() ?? '0') ?? 0;
    guest = jsonMap['guest']?.toString() ?? '0';
    bedType = jsonMap['bed_type'] ?? '-';
    roomSize = int.tryParse(jsonMap['roomsize']?.toString() ?? '0') ?? 0;
    roomLeft = int.tryParse(jsonMap['room_left']?.toString() ?? '0') ?? 0;
    maxExtBed = int.tryParse(jsonMap['maxextrabed']?.toString() ?? '0') ?? 0;
    extBedPrice =
        int.tryParse(jsonMap['extrabed_price']?.toString() ?? '0') ?? 0;
    totalRoom = int.tryParse(jsonMap['totalroom']?.toString() ?? '0') ?? 0;

    try {
      if (jsonMap['hostel_room_image'] != null) {
        for (var img in jsonMap['hostel_room_image']) {
          final raw = img['image']?.toString();
          if (raw != null && raw.isNotEmpty && raw != '-') {
            final imageUrlTemp = raw.contains('https') ? raw : "$baseUrl$raw";
            images.add(imageUrlTemp);
          }
        }
      }
    } catch (e) {
      images = [];
    }
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
    comment = jsonMap['comment'] ?? '-';
    try {
      userId = jsonMap['user_id'];
    } catch (e) {
      userId = jsonMap['users_id'];
    }
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
