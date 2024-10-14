class AdsModel {
  late int id;
  String? url;
  late String image;
  late int isActive;

  AdsModel.fromJson(Map<String, dynamic> jsonMap) {
    id = jsonMap['id'];
    url = jsonMap['url'] == '-'
        ? null
        : jsonMap['url'].isEmpty
            ? null
            : jsonMap['url'];
    image = jsonMap['image'];
    isActive = jsonMap['is_active'];
  }
}
