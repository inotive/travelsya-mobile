class RecreationCategoryModel {
  final int id;
  final String name;

  RecreationCategoryModel({
    required this.id,
    required this.name,
  });

  factory RecreationCategoryModel.fromJson(Map<String, dynamic> json) {
    return RecreationCategoryModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
    );
  }
}

class RecreationPreviewModel {
  final int id;
  final String name;
  final String image;
  final String location;
  final double price;
  final int ratingCount;
  final double avgRating;

  RecreationPreviewModel({
    required this.id,
    required this.name,
    required this.image,
    required this.location,
    required this.price,
    required this.ratingCount,
    required this.avgRating,
  });

  factory RecreationPreviewModel.fromJson(Map<String, dynamic> json) {
    return RecreationPreviewModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      location: json['location'] ?? '',
      price: double.tryParse(json['price']?.toString() ?? '') ?? 0.0,
      ratingCount: json['rating_count'] ?? 0,
      avgRating: double.tryParse(json['avg_rating']?.toString() ?? '') ?? 0.0,
      image: (json['image'] != null && json['image'].toString().isNotEmpty)
          ? json['image']
          : (json['images'] != null && json['images'].isNotEmpty
              ? json['images'][0].toString()
              : ''),
    );
  }
}

class RecreationDetailModel {
  final int id;
  final String service;
  final String category;
  final String user;
  final String name;
  final String description;
  final String openTime;
  final String closeTime;
  final String city;
  final String address;
  final double? latitude;
  final double? longitude;
  final double avgRating;
  final int ratingCount;

  final List<String> images;
  final List<RecreationPackageModel> packages;
  final List<RecreationCommentModel> comments;

  RecreationDetailModel({
    required this.id,
    required this.service,
    required this.category,
    required this.user,
    required this.name,
    required this.description,
    required this.openTime,
    required this.closeTime,
    required this.city,
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.avgRating,
    required this.ratingCount,
    required this.images,
    required this.packages,
    required this.comments,
  });

  factory RecreationDetailModel.fromJson(Map<String, dynamic> json) {
    return RecreationDetailModel(
      id: json['recreation_id'] ?? 0,
      service: json['service'] ?? '',
      category: json['category'] ?? '',
      user: json['user'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      openTime: json['buka'] ?? '',
      closeTime: json['tutup'] ?? '',
      city: json['city'] ?? '',
      address: json['address'] ?? '',
      latitude: double.tryParse(json['latitude']?.toString() ?? ''),
      longitude: double.tryParse(json['longitude']?.toString() ?? ''),
      avgRating: double.tryParse(json['avg_rating']?.toString() ?? '') ?? 0.0,
      ratingCount: json['rating_count'] ?? 0,
      images: (json['images'] != null)
          ? List<String>.from(json['images'].map((e) => e.toString()))
          : [],
      packages: (json['packages'] != null)
          ? List<RecreationPackageModel>.from(
              json['packages'].map((e) => RecreationPackageModel.fromJson(e)))
          : [],
      comments: (json['comments'] != null)
          ? List<RecreationCommentModel>.from(
              json['comments'].map((e) => RecreationCommentModel.fromJson(e)))
          : [],
    );
  }
}

class RecreationCommentModel {
  final int id;
  final int rate;
  final String comment;
  final String? createdAt;
  final RecreationUserModel? user;

  RecreationCommentModel({
    required this.id,
    required this.rate,
    required this.comment,
    this.createdAt,
    this.user,
  });

  factory RecreationCommentModel.fromJson(Map<String, dynamic> json) {
    return RecreationCommentModel(
      id: json['id'] ?? 0,
      rate: int.tryParse(json['rate']?.toString() ?? '') ?? 0,
      comment: json['comment'] ?? '',
      createdAt: json['created_at'],
      user: json['user'] != null
          ? RecreationUserModel.fromJson(json['user'])
          : null,
    );
  }
}

class RecreationUserModel {
  final int id;
  final String name;
  final String? image;

  RecreationUserModel({
    required this.id,
    required this.name,
    this.image,
  });

  factory RecreationUserModel.fromJson(Map<String, dynamic> json) {
    return RecreationUserModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      image: json['image'],
    );
  }
}

class RecreationPackageModel {
  final int id;
  final int? recreationId;
  final int? categoryRecreationId;
  final String name;
  final String rule;
  final String description;
  final String duration;
  final int expiredDate;
  final String expiredType;
  final String unitType;
  final double price;
  final int isActive;
  final int isRefundable;
  final int isRescheduleable;

  RecreationPackageModel({
    required this.id,
    this.recreationId,
    this.categoryRecreationId,
    required this.name,
    required this.rule,
    required this.description,
    required this.duration,
    required this.expiredDate,
    required this.expiredType,
    required this.unitType,
    required this.price,
    required this.isActive,
    required this.isRefundable,
    required this.isRescheduleable,
  });

  factory RecreationPackageModel.fromJson(Map<String, dynamic> json) {
    return RecreationPackageModel(
      id: json['id'] ?? 0,
      recreationId: int.tryParse(json['recreation_id']?.toString() ?? ''),
      categoryRecreationId:
          int.tryParse(json['category_recreation_id']?.toString() ?? ''),
      name: json['name'] ?? '',
      rule: json['rules'] ?? '',
      description: json['description'] ?? '',
      duration: json['duration'] ?? '',
      expiredDate: int.tryParse(json['expiry_date']?.toString() ?? '') ?? 0,
      expiredType: json['expiry_type'] ?? '',
      unitType: json['unit_price'] ?? '',
      price: double.tryParse(json['price']?.toString() ?? '') ?? 0.0,
      isActive: int.tryParse(json['is_active']?.toString() ?? '') ?? 0,
      isRefundable: int.tryParse(json['is_refundable']?.toString() ?? '') ?? 0,
      isRescheduleable:
          int.tryParse(json['is_reschedule']?.toString() ?? '') ?? 0,
    );
  }
}
