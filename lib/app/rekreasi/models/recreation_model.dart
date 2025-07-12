class RecreationCategoryModel {
  late int id;
  late String name;

  RecreationCategoryModel.fromJson(Map<String, dynamic> jsonMap) {
    id = jsonMap['id'];
    name = jsonMap['name'];
  }
}

class RecreationPreviewModel {
  late int? id;
  late String name;
  late String image;
  late String location;
  late double price;
  late int ratingCount;
  late double avgRating;

  RecreationPreviewModel.fromJson(Map<String, dynamic> jsonMap) {
    id = jsonMap['id'];
    name = jsonMap['name'];
    image = jsonMap['image'];
    location = jsonMap['location'];
    price = double.parse(jsonMap['price'].toString());
    ratingCount = jsonMap['rating_count'];
    avgRating = double.parse(jsonMap['avg_rating'].toString());
  }
}

class RecreationDetailModel {
  late int id;
  late String service;
  late String category;
  late String user;
  late String name;
  late String? description;
  late String openTime;
  late String closeTime;
  late String city;
  late String address;
  late double latitude;
  late double longitude;
  late int ratingCount;
  late double avgRating;
  List<String> images = [];
  List<RecreationPackageModel> package = [];
  List<RecreationCommentModel> comment = [];

  RecreationDetailModel.fromJson(Map<String, dynamic> jsonMap) {
    id = jsonMap['recreation_id'];
    service = jsonMap['service'];
    category = jsonMap['category'];
    user = jsonMap['user'];
    name = jsonMap['name'];
    description = jsonMap['description'];
    openTime = jsonMap['buka'];
    closeTime = jsonMap['tutup'];
    city = jsonMap['city'];
    address = jsonMap['address'];
    latitude = double.parse(jsonMap['latitude'].toString());
    longitude = double.parse(jsonMap['longitude'].toString());
    avgRating = double.parse(jsonMap['avg_rating'].toString());
    ratingCount = jsonMap['rating_count'];
    for (var i = 0; i < jsonMap['images'].length; i++) {
      images.add(jsonMap['images'][i]);
    }
    for (var i = 0; i < jsonMap['packages'].length; i++) {
      package.add(RecreationPackageModel.fromJson(jsonMap['packages'][i]));
    }
    for (var i = 0; i < jsonMap['comments'].length; i++) {
      comment.add(RecreationCommentModel.fromJson(jsonMap['comments'][i]));
    }
  }
}

class RecreationCommentModel {
  late int id;
  late int rate;
  late String comment;
  late String? createdAt;

  RecreationCommentModel.fromJson(Map<String, dynamic> jsonMap) {
    id = jsonMap['id'];
    rate = int.parse(jsonMap['rate'].toString());
    comment = jsonMap['comment'];
    createdAt = jsonMap['created_at'];
  }
}

class RecreationPackageModel {
  late int id;
  late int recreationId;
  late int categoryRecreationId;
  late String name;
  late String rule;
  late String description;
  late String duration;
  late int expiredDate;
  late String expiredType;
  late String unitType;
  late double price;
  late int isActive;
  late int isRefundable;
  late int isRescheduleable;

  RecreationPackageModel.fromJson(Map<String, dynamic> jsonMap) {
    id = jsonMap['id'];
    recreationId = int.parse(jsonMap['recreation_id'].toString());
    categoryRecreationId = int.parse(jsonMap['category_recreation_id']);
    name = jsonMap['name'];
    rule = jsonMap['rules'];
    description = jsonMap['description'];
    duration = jsonMap['duration'];
    expiredDate = int.parse(jsonMap['expiry_date'].toString());
    expiredType = jsonMap['expiry_type'];
    unitType = jsonMap['unit_price'];
    price = double.parse(jsonMap['price'].toString());
    isActive = int.parse(jsonMap['is_active'].toString());
    isRefundable = int.parse(jsonMap['is_refundable'].toString());
    isRescheduleable = int.parse(jsonMap['is_reschedule']);
  }
}
