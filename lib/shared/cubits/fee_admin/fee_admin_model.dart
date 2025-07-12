class FeeAdmin {
  late int id;
  late String serviceId;
  late double value;
  late int isPercent;
  late String serviceName;

  FeeAdmin.fromJson(Map<String, dynamic> jsonMap) {
    id = jsonMap['id'];
    serviceId = jsonMap['service_id'].toString();
    value = double.parse(jsonMap['value'].toString());
    isPercent = int.parse(jsonMap['percent'].toString());
    serviceName = jsonMap['service']['name'];
  }
}
