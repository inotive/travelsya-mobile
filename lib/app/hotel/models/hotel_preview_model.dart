import 'package:travelsya/shared/api/api_connection.dart';

class HotelPreview {
  late int? id;
  late String name;
  late String? image;
  late String location;
  late double avgRating;
  late int ratingCount;
  late double? price;
  late double? sellingPrice;

  HotelPreview.fromJson(Map<String, dynamic> jsonMap) {
    id = jsonMap['id'];
    name = jsonMap['name'];
    image = jsonMap['image'] == null
        ? null
        : jsonMap['image'].toString() == '-'
            ? null
            : jsonMap['image'].toString().contains('http')
                ? jsonMap['image']
                : "${baseUrl}storage/${jsonMap['image']}";
    location = jsonMap['location'];
    avgRating = double.parse(jsonMap['avg_rating'].toString());
    ratingCount = double.parse(jsonMap['rating_count'].toString()).toInt();
    price = double.parse(
        jsonMap['price'] == null ? '0' : jsonMap['price'].toString());
    sellingPrice = double.parse(jsonMap['sellingprice'] == null
        ? '0'
        : jsonMap['sellingprice'].toString());
  }
}
