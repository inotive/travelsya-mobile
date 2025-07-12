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
