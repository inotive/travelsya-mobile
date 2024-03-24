class UserModel {
  late String token;
  late String name;
  late String email;
  String? image;
  late int id;
  late String? phone;
  late double point;

  Map<String, dynamic> toJson() => {
        'user': {
          'name': name,
          'email': email,
          'id': id,
          'image': image,
          'phone': phone,
          'point': point
        },
        'access_token': token
      };

  UserModel.fromJsonWithToken(Map<String, dynamic> jsonMap, String tokenParam) {
    token = tokenParam;
    name = jsonMap['name'];
    image = jsonMap['image'] == null
        ? null
        : jsonMap['image'].toString().contains('travelsya.com')
            ? jsonMap['image'].toString().split('/').last
            : jsonMap['image'];
    email = jsonMap['email'];
    phone = jsonMap['phone'];
    id = jsonMap['id'];
    point = jsonMap['point'] == null
        ? 0
        : double.parse(jsonMap['point'].toString());
  }

  UserModel.fromJson(Map<String, dynamic> jsonMap) {
    token = jsonMap['access_token'];
    name = jsonMap['user']['name'];
    image = jsonMap['user']['image'] == null
        ? null
        : jsonMap['user']['image'].toString().contains('travelsya.com')
            ? jsonMap['user']['image'].toString().split('/').last
            : jsonMap['user']['image'];
    email = jsonMap['user']['email'];
    phone = jsonMap['user']['phone'];
    id = jsonMap['user']['id'];
    point = jsonMap['user']['point'] == null
        ? 0
        : double.parse(jsonMap['user']['point'].toString());
  }
}
