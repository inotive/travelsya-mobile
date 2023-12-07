class UserModel {
  late String token;
  late String name;
  late String email;
  late int id;
  late String? phone;
  late int point;

  Map<String, dynamic> toJson() => {
        'user': {
          'name': name,
          'email': email,
          'id': id,
          'phone': phone,
          'point': point
        },
        'access_token': token
      };

  UserModel.fromJsonWithToken(Map<String, dynamic> jsonMap, String tokenParam) {
    token = tokenParam;
    name = jsonMap['name'];
    email = jsonMap['email'];
    phone = jsonMap['phone'];
    id = jsonMap['id'];
    point = jsonMap['point'] ?? 0;
  }

  UserModel.fromJson(Map<String, dynamic> jsonMap) {
    token = jsonMap['access_token'];
    name = jsonMap['user']['name'];
    email = jsonMap['user']['email'];
    phone = jsonMap['user']['phone'];
    id = jsonMap['user']['id'];
    point = jsonMap['user']['point'] ?? 0;
  }
}
