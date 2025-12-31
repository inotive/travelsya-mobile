// class HealthCategoryModel {
//   final int id;
//   final String name;

//   HealthCategoryModel.fromJson(Map<String, dynamic> jsonMap)
//       : id = jsonMap['id'] ?? 0,
//         name = jsonMap['name'] ?? '';
// }

class HealthCategoryModel {
  final int id;
  final String name;

  HealthCategoryModel({
    required this.id,
    required this.name,
  });

  factory HealthCategoryModel.fromJson(dynamic json) {
    if (json is String) {
      return HealthCategoryModel(
        id: 0,
        name: json,
      );
    }

    if (json is Map<String, dynamic>) {
      return HealthCategoryModel(
        id: json['id'] ?? 0,
        name: json['name'] ?? '',
      );
    }

    // fallback aman
    return HealthCategoryModel(id: 0, name: '');
  }
}

class HealthPreviewModel {
  final int id;
  final String name;
  final String image;
  final String location;
  final String category;
  final double unitPrice;
  final double price;
  final int ratingCount;
  final double ratingAvg;

  HealthPreviewModel.fromJson(Map<String, dynamic> jsonMap)
      : id = jsonMap['id'] ?? 0,
        name = jsonMap['name'] ?? '',
        image = jsonMap['image'] ?? '',
        location = jsonMap['location'] ?? '',
        category = jsonMap['category'] ?? '',
        unitPrice =
            double.tryParse(jsonMap['unit_price']?.toString() ?? '') ?? 0,
        price = double.tryParse(jsonMap['price']?.toString() ?? '') ?? 0,
        ratingCount = jsonMap['rating_count'] ?? 0,
        ratingAvg =
            double.tryParse(jsonMap['avg_rating']?.toString() ?? '') ?? 0;
}

class HealthDetailModel {
  final int id;
  final String category;
  final String user;
  final String name;
  final String? description;
  final String? highlight;
  final String? openTime;
  final String? closeTime;
  final String city;
  final String? address;
  final double? latitude;
  final double? longitude;
  final List<String> images;
  final String mainImage;
  final int ratingCount;
  final double avgRating;

  final List<HealthPackageModel> packages;
  final List<HealthCommentModel> comments;
  final List<HealthPreviewModel> maybeLike;

  HealthDetailModel({
    required this.id,
    required this.category,
    required this.user,
    required this.name,
    this.description,
    this.highlight,
    this.openTime,
    this.closeTime,
    required this.city,
    this.address,
    this.latitude,
    this.longitude,
    required this.images,
    required this.mainImage,
    required this.ratingCount,
    required this.avgRating,
    required this.packages,
    required this.comments,
    required this.maybeLike,
  });

  factory HealthDetailModel.fromJson(
      Map<String, dynamic> jsonMap, List<dynamic> jsonMapLike) {
    return HealthDetailModel(
      id: jsonMap['clinic_id'] ?? 0,
      category: jsonMap['category'] ?? '',
      user: jsonMap['user'] ?? '',
      name: jsonMap['name'] ?? '',
      description: jsonMap['description'],
      highlight: jsonMap['highlight'],
      openTime: jsonMap['buka'],
      closeTime: jsonMap['tutup'],
      city: jsonMap['city'] ?? '',
      address: jsonMap['address'],
      latitude: double.tryParse(jsonMap['latitude']?.toString() ?? ''),
      longitude: double.tryParse(jsonMap['longitude']?.toString() ?? ''),
      images: List<String>.from(jsonMap['images'] ?? []),
      mainImage: jsonMap['main_image'] ?? '',
      ratingCount: jsonMap['rating_count'] ?? 0,
      avgRating: double.tryParse(jsonMap['avg_rating']?.toString() ?? '') ?? 0,
      packages: (jsonMap['packages'] as List? ?? [])
          .map((e) => HealthPackageModel.fromJson(e))
          .toList(),
      comments: (jsonMap['comments'] as List? ?? [])
          .map((e) => HealthCommentModel.fromJson(e))
          .toList(),
      maybeLike:
          (jsonMapLike).map((e) => HealthPreviewModel.fromJson(e)).toList(),
    );
  }
}

class HealthCommentModel {
  final int id;
  final int transactionId;
  final int clinicId;
  final int clinicPackageId;
  final int userId;
  final int rate;
  final String? comment;
  final String? createdAt;

  HealthCommentModel.fromJson(Map<String, dynamic> jsonMap)
      : id = jsonMap['id'] ?? 0,
        transactionId =
            int.tryParse(jsonMap['transaction_id']?.toString() ?? '') ?? 0,
        clinicId = int.tryParse(jsonMap['clinic_id']?.toString() ?? '') ?? 0,
        clinicPackageId =
            int.tryParse(jsonMap['clinic_package_id']?.toString() ?? '') ?? 0,
        userId = int.tryParse(jsonMap['user_id']?.toString() ?? '') ?? 0,
        rate = int.tryParse(jsonMap['rate']?.toString() ?? '') ?? 0,
        comment = jsonMap['comment']?.toString(),
        createdAt = jsonMap['created_at'];
}

class HealthPackageModel {
  final int id;
  final String clinicId;
  final String categoriesId;
  final String name;
  final String rules;
  final String description;
  final int duration;
  final int expiredDate;
  final double unitPrice;
  final double price;
  final int isActive;

  HealthPackageModel.fromJson(Map<String, dynamic> jsonMap)
      : id = jsonMap['id'] ?? 0,
        clinicId = jsonMap['clinic_id']?.toString() ?? '',
        categoriesId = jsonMap['categories_services_id']?.toString() ?? '',
        name = jsonMap['name'] ?? '',
        rules = jsonMap['rules'] ?? '',
        description = jsonMap['description'] ?? '',
        duration = int.tryParse(jsonMap['duration']?.toString() ?? '') ?? 0,
        expiredDate =
            int.tryParse(jsonMap['expiry_date']?.toString() ?? '') ?? 0,
        unitPrice =
            double.tryParse(jsonMap['unit_price']?.toString() ?? '') ?? 0,
        price = double.tryParse(jsonMap['price']?.toString() ?? '') ?? 0,
        isActive = (jsonMap['is_active'] is bool)
            ? (jsonMap['is_active'] ? 1 : 0)
            : int.tryParse(jsonMap['is_active']?.toString() ?? '') ?? 0;
}

class HealthCityModel {
  final String name;

  HealthCityModel({required this.name});

  factory HealthCityModel.fromJson(dynamic json) {
    return HealthCityModel(name: json.toString());
  }
}
