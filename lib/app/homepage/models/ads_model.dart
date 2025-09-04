import 'package:travelsya/shared/api/api_connection.dart';

class AdsModel {
  late int id;
  String? url;
  late String image;
  late int isActive;

  AdsModel.fromJson(Map<String, dynamic> jsonMap) {
    id = jsonMap['id'];
    url = jsonMap['url'] == '-' || (jsonMap['url'] as String).isEmpty
        ? null
        : jsonMap['url'];

    final rawImage = jsonMap['image'];
    if (rawImage.toString().startsWith('http')) {
      image = rawImage;
    } else if (rawImage.toString().startsWith('media/')) {
      image = '$baseUrl/public/$rawImage';
    } else {
      image = '$baseUrl/public/media/ads/$rawImage';
    }

    isActive = int.tryParse(jsonMap['is_active'].toString()) ?? 0;
  }
}
