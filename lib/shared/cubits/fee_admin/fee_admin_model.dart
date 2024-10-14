class FeeAdmin {
  late int id;
  late int serviceId;
  late int value;
  late int isPercent;
  late String serviceName;

  FeeAdmin.fromJson(Map<String, dynamic> jsonMap) {
    id = jsonMap['id'];
    serviceId = jsonMap['service_id'];
    value = jsonMap['value'];
    isPercent = jsonMap['percent'];
    serviceName = jsonMap['service']['name'];
  }
}
