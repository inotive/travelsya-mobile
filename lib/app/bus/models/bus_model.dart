class BusDataModel {
  late int id;
  late String bussinessName;
  late String kelas;
  late String departurePoint;
  late String departureTime;
  late String arrivalPoint;
  late String arrivalTime;
  late double price;
  late int availableTicket;

  BusDataModel.fromJson(Map<String, dynamic> jsonMap) {
    id = jsonMap['id'];
    bussinessName = jsonMap['business_name'];
    kelas = jsonMap['class'];
    departurePoint = jsonMap['departure_point'];
    departureTime = jsonMap['departure_time'];
    arrivalPoint = jsonMap['arrival_point'];
    arrivalTime = jsonMap['arrival_time'];
    price = double.parse(jsonMap['price'].toString());
    availableTicket = jsonMap['available_tickets'];
  }
}
