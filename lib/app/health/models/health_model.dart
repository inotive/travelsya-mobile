class HealthCategoryModel {
  late int id;
  late String name;

  HealthCategoryModel.fromJson(Map<String, dynamic> jsonMap) {
    id = jsonMap['id'];
    name = jsonMap['name'];
  }
}

class HealthPreviewModel {
  late int id;
  late String name;
  late String image;
  late String location;
  late String category;
  late double unitPrice;
  late double price;
  late int ratingCount;
  late double ratingAvg;

  HealthPreviewModel.fromJson(Map<String, dynamic> jsonMap) {
    id = jsonMap['id'];
    name = jsonMap['name'];
    image = jsonMap['image'];
    location = jsonMap['location'];
    category = jsonMap['category'];
    unitPrice = double.parse(jsonMap['unit_price'].toString());
    price = double.parse(jsonMap['price'].toString());
    ratingCount = jsonMap['rating_count'];
    ratingAvg = double.parse(jsonMap['avg_rating'].toString());
  }
}

class HealthDetailModel {
  late int id;
  late String category;
  late String user;
  late String name;
  late String? description;
  late String? highlight;
  late String? openTime;
  late String? closeTime;
  late String city;
  late String? address;
  late double? latitude;
  late double? longitude;
  List<String> images = [];
  late String mainImage;
  late int ratingCount;
  late double avgRating;

  List<HealthPackageModel> package = [];
  List<HealthCommentModel> comment = [];
  List<HealthPreviewModel> maybeLike = [];

  HealthDetailModel.fromJson(
      Map<String, dynamic> jsonMap, List<dynamic> jsonMapLike) {
    id = jsonMap['clinic_id'];
    category = jsonMap['category'];
    user = jsonMap['user'];
    name = jsonMap['name'];
    description = jsonMap['description'];
    highlight = jsonMap['highlight'];
    openTime = jsonMap['buka'];
    closeTime = jsonMap['tutup'];
    city = jsonMap['city'];
    address = jsonMap['address'];
    latitude = jsonMap['latitude'];
    longitude = jsonMap['longitude'];

    for (var i = 0; i < jsonMap['images'].length; i++) {
      images.add(jsonMap['images'][i]);
    }

    mainImage = jsonMap['main_image'];

    for (var i = 0; i < jsonMap['packages'].length; i++) {
      package.add(HealthPackageModel.fromJson(jsonMap['packages'][i]));
    }

    ratingCount = jsonMap['rating_count'];
    avgRating = double.parse(jsonMap['avg_rating'].toString());
    for (var i = 0; i < jsonMap['comments'].length; i++) {
      comment.add(HealthCommentModel.fromJson(jsonMap['comments'][i]));
    }

    for (var i = 0; i < jsonMapLike.length; i++) {
      maybeLike.add(HealthPreviewModel.fromJson(jsonMapLike[i]));
    }
  }
}

class HealthCommentModel {
  late int id;
  late int transactionId;
  late int clinicId;
  late int clinicPackageId;
  late int userId;
  late int rate;
  late String comment;
  String? createdAt;

  HealthCommentModel.fromJson(Map<String, dynamic> jsonMap) {
    id = jsonMap['id'];
    transactionId = int.parse(jsonMap['transaction_id']);
    clinicId = int.parse(jsonMap['clinic_id']);
    clinicPackageId = int.parse(jsonMap['clinic_package_id']);
    userId = int.parse(jsonMap['user_id']);
    rate = int.parse(jsonMap['rate']);
    comment = jsonMap['comment'];
    createdAt = jsonMap['created_at'];
  }
}

class HealthPackageModel {
  late int id;
  late String clinicId;
  late String categoriesId;
  late String name;
  late String rules;
  late String description;
  late int duration;
  late int expiredDate;
  late double unitPirce;
  late double price;
  late int isActive;

  HealthPackageModel.fromJson(Map<String, dynamic> jsonMap) {
    id = jsonMap['id'];
    clinicId = jsonMap['clinic_id'].toString();
    categoriesId = jsonMap['categories_services_id'].toString();
    name = jsonMap['name'];
    rules = jsonMap['rules'];
    description = jsonMap['description'];
    duration = int.parse(jsonMap['duration'].toString());
    expiredDate = int.parse(jsonMap['expiry_date'].toString());
    unitPirce = double.parse(jsonMap['unit_price'].toString());
    price = double.parse(jsonMap['price'].toString());
    isActive = int.parse(jsonMap['is_active'].toString());
  }
}
