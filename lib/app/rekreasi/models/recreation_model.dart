class RecreationCategoryModel {
  late int id;
  late String name;

  RecreationCategoryModel.fromJson(Map<String, dynamic> jsonMap) {
    id = jsonMap['id'] ?? 0;
    name = jsonMap['name'] ?? '';
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
    name = jsonMap['name'] ?? '';
    image = jsonMap['image'] ?? '';
    location = jsonMap['location'] ?? '';
    price = double.tryParse(jsonMap['price']?.toString() ?? '') ?? 0.0;
    ratingCount = jsonMap['rating_count'] ?? 0;
    avgRating = double.tryParse(jsonMap['avg_rating']?.toString() ?? '') ?? 0.0;
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
  late double? latitude;
  late double? longitude;
  late double? avgRating;
  late int ratingCount;
  List<String> images = [];
  List<RecreationPackageModel> package = [];
  List<RecreationCommentModel> comment = [];

  RecreationDetailModel.fromJson(Map<String, dynamic> jsonMap) {
    id = jsonMap['recreation_id'] ?? 0;
    service = jsonMap['service'] ?? '';
    category = jsonMap['category'] ?? '';
    user = jsonMap['user'] ?? '';
    name = jsonMap['name'] ?? '';
    description = jsonMap['description'];
    openTime = jsonMap['buka'] ?? '';
    closeTime = jsonMap['tutup'] ?? '';
    city = jsonMap['city'] ?? '';
    address = jsonMap['address'] ?? '';
    latitude = double.tryParse(jsonMap['latitude']?.toString() ?? '');
    longitude = double.tryParse(jsonMap['longitude']?.toString() ?? '');
    avgRating = double.tryParse(jsonMap['avg_rating']?.toString() ?? '');
    ratingCount = jsonMap['rating_count'] ?? 0;

    if (jsonMap['images'] != null) {
      for (var img in jsonMap['images']) {
        images.add(img.toString());
      }
    }
    if (jsonMap['packages'] != null) {
      for (var pkg in jsonMap['packages']) {
        package.add(RecreationPackageModel.fromJson(pkg));
      }
    }
    if (jsonMap['comments'] != null) {
      for (var cmt in jsonMap['comments']) {
        comment.add(RecreationCommentModel.fromJson(cmt));
      }
    }
  }
}

class RecreationCommentModel {
  late int id;
  late int rate;
  late String comment;
  late String? createdAt;

  RecreationCommentModel.fromJson(Map<String, dynamic> jsonMap) {
    id = jsonMap['id'] ?? 0;
    rate = int.tryParse(jsonMap['rate']?.toString() ?? '') ?? 0;
    comment = jsonMap['comment'] ?? '';
    createdAt = jsonMap['created_at'];
  }
}

class RecreationPackageModel {
  late int id;
  late int? recreationId;
  late int? categoryRecreationId;
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
    id = jsonMap['id'] ?? 0;
    recreationId = int.tryParse(jsonMap['recreation_id']?.toString() ?? '');
    categoryRecreationId = int.tryParse(jsonMap['category_recreation_id']?.toString() ?? '');
    name = jsonMap['name'] ?? '';
    rule = jsonMap['rules'] ?? '';
    description = jsonMap['description'] ?? '';
    duration = jsonMap['duration'] ?? '';
    expiredDate = int.tryParse(jsonMap['expiry_date']?.toString() ?? '') ?? 0;
    expiredType = jsonMap['expiry_type'] ?? '';
    unitType = jsonMap['unit_price'] ?? '';
    price = double.tryParse(jsonMap['price']?.toString() ?? '') ?? 0.0;
    isActive = int.tryParse(jsonMap['is_active']?.toString() ?? '') ?? 0;
    isRefundable = int.tryParse(jsonMap['is_refundable']?.toString() ?? '') ?? 0;
    isRescheduleable = int.tryParse(jsonMap['is_reschedule']?.toString() ?? '') ?? 0;
  }
}
