class RentalMobilModel {
  late int brandId;
  late String brand;
  late int seats;
  late double price;
  late String transmision;
  late String image;
  List<VendorRentalModel> data = [];

  RentalMobilModel.fromJson(
      Map<String, dynamic> jsonMap, Map<String, dynamic> dataVendor) {
    brandId = jsonMap['brand_id'];
    brand = jsonMap['brand'];
    seats = int.parse(jsonMap['seats'].toString());
    price = double.parse(jsonMap['price'].toString());
    transmision = jsonMap['transmission'];
    // transmision =
    //     (jsonMap['transmission'] ?? '').toString().trim().toLowerCase();

    image = jsonMap['image'];
    try {
      List<dynamic> dataRaw = dataVendor[brand];
      for (var i = 0; i < dataRaw.length; i++) {
        data.add(VendorRentalModel.fromJson(dataRaw[i]));
      }
    } catch (e) {
      data = [];
    }
  }
}

class VendorRentalModel {
  late int idCar;
  late String name;
  late double price;

  VendorRentalModel.fromJson(Map<String, dynamic> jsonMap) {
    idCar = jsonMap['id_car'];
    name = jsonMap['business_name'];
    price = double.parse(jsonMap['price'].toString());
  }
}

class VendorRentalDetailModel {
  final int id;
  final String businessName;
  final String carModel;
  final String carBrand;
  final String categoryRent;
  final int chairs;
  final String transmisi;
  final List<String> images;
  final double price;
  final String pickupLocation;
  final String description;
  final String? rentalPolicy;

  VendorRentalDetailModel.fromJson(Map<String, dynamic> json)
      : id = json['id'] ?? 0,
        businessName = json['business_name'] ?? '',
        carModel = json['car_model'] ?? '',
        carBrand = json['car_brand'] ?? '',
        categoryRent = json['category_rent'] ?? '',
        chairs = json['chairs'] ?? 0,
        transmisi = json['transmisi'] ?? '',
        images =
            json['images'] != null ? List<String>.from(json['images']) : [],
        price = double.parse(json['price'].toString()),
        pickupLocation = json['pickup_location'] ?? '',
        description = json['description'] ?? '',
        rentalPolicy = json['rental_policy'];
}

class RentalMobilCityModel {
  final String name;

  RentalMobilCityModel({required this.name});

  factory RentalMobilCityModel.fromJson(dynamic json) {
    return RentalMobilCityModel(name: json.toString());
  }
}
