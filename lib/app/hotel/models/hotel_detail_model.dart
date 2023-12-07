import 'package:travelsya/shared/api/api_connection.dart';

class HotelDetailModel {
  late String name;
  late String? image;
  late String checkIn;
  late String checkOut;
  late String location;
  late double avgRating;
  late int ratingCount;
  List<String> images = [];
  List<HotelRoom> room = [];
  List<HotelFacilites> facilities = [];
  List<HotelReview> reviews = [];
  List<HotelRules> rules = [];
  late double? lat;
  late double? lon;
  late String? address;

  HotelDetailModel.fromJson(Map<String, dynamic> jsonMap) {
    name = jsonMap['name'];
    image = jsonMap['image'];
    checkIn = jsonMap['checkin'];
    checkOut = jsonMap['checkout'];
    location = jsonMap['location'];
    avgRating = double.parse(jsonMap['avg_rating'].toString());
    ratingCount = jsonMap['rating_count'];
    lat = jsonMap['lat'] == null ? null : double.parse(jsonMap['lat']);
    lon = jsonMap['lon'] == null ? null : double.parse(jsonMap['lon']);
    address = jsonMap['address'];

    room = List.generate(jsonMap['hotel_rooms'].length, (index) {
      return HotelRoom.fromJson(jsonMap['hotel_rooms'][index]);
    });

    //facilities
    for (var i = 0; i < jsonMap['hotel_facilities'].length; i++) {
      bool isDuplicate = false;
      for (var j = 0; j < facilities.length; j++) {
        if (facilities[j].name == jsonMap['hotel_facilities'][i]['name']) {
          isDuplicate = true;
        }
      }

      if (!isDuplicate) {
        facilities.add(HotelFacilites.fromJson(jsonMap['hotel_facilities'][i]));
      }
    }

    reviews = List.generate(jsonMap['hotel_reviews'].length, (index) {
      return HotelReview.fromJson(jsonMap['hotel_reviews'][index]);
    });
    rules = List.generate(jsonMap['hotel_rules'].length, (index) {
      return HotelRules.fromJson(jsonMap['hotel_rules'][index]);
    });

    for (var index = 0; index < jsonMap['hotel_image'].length; index++) {
      String? imageTemp = jsonMap['hotel_image'][index]['image'] == null
          ? null
          : jsonMap['hotel_image'][index]['image'].toString() == '-'
              ? null
              : jsonMap['hotel_image'][index]['image']
                      .toString()
                      .contains('http')
                  ? jsonMap['hotel_image'][index]['image']
                  : "${baseUrl}storage/${jsonMap['hotel_image'][index]['image']}";
      if (imageTemp != null) {
        images.add(imageTemp);
      }
    }
  }
}

class HotelFacilites {
  late int id;
  late String name;
  late String image;

  HotelFacilites.fromJson(Map<String, dynamic> jsonMap) {
    id = jsonMap['id'];
    name = jsonMap['name'];
    image = "$baseUrl${jsonMap['image']}";
  }
}

class HotelReview {
  late int rate;
  late String comment;
  late int userId;
  String? username;

  String? createdAt;

  HotelReview.fromJson(Map<String, dynamic> jsonMap) {
    rate = jsonMap['rate'];
    comment = jsonMap['comment'];
    username = jsonMap['user_name'];
    userId = jsonMap['user_id'];
    createdAt = jsonMap['created_at'];
  }
}

class HotelRules {
  late int id;
  late String desc;

  HotelRules.fromJson(Map<String, dynamic> jsonMap) {
    id = jsonMap['id'];
    desc = jsonMap['description'];
  }
}

class HotelRoom {
  late int id;
  late String name;
  late String desc;
  late double price;
  late double sellingPrice;
  //facilites
  late String bedType;
  late int roomSize;
  late int maxExtBed;
  late int totalRoom;
  late int guest;
  List<String> images = [];
  late bool isActive;

  HotelRoom.fromJson(Map<String, dynamic> jsonMap) {
    id = jsonMap['id'];
    name = jsonMap['name'];
    desc = jsonMap['description'] ?? '';
    price = double.parse(jsonMap['price'].toString());
    sellingPrice = double.parse(jsonMap['sellingprice'].toString());
    //facilities
    bedType = jsonMap['bed_type'] ?? '-';
    roomSize = jsonMap['roomsize'];
    maxExtBed = jsonMap['maxextrabed'] ?? 0;
    totalRoom = jsonMap['totalroom'];
    guest = jsonMap['guest'];
    for (var i = 0; i < jsonMap['hotel_room_image'].length; i++) {
      if (jsonMap['hotel_room_image'][i].toString().contains('http')) {
        images.add(jsonMap['hotel_room_image'][i]['image']);
      } else {
        images.add(
            '${baseUrl}storage/${jsonMap['hotel_room_image'][i]['image']}');
      }
    }
  }
}
