class OrderList {
  late int id;
  late String noInv;
  late String? reqId;
  late String link;
  late String service;
  late String payment;
  late String paymentMethod;
  late String paymentChannel;
  late String status;
  late double total;
  late String createdAt;
  Map<String, dynamic>? detailTransaction;

  OrderList.fromJsonPoint(Map<String, dynamic> jsonMap) {
    id = jsonMap['id'];
    noInv = jsonMap['no_inv'];
    reqId = jsonMap['req_id'];
    link = jsonMap['link'];
    service = jsonMap['service'];
    payment = jsonMap['payment'];
    paymentMethod = jsonMap['payment_method'] ?? '-';
    paymentChannel = jsonMap['payment_channel'] ?? '-';
    status = jsonMap['status'];
    total = double.parse(jsonMap['total'].toString());
    createdAt = jsonMap['created_at'];
    detailTransaction = jsonMap['detail_transactions'];
  }

  OrderList.fromJson(Map<String, dynamic> jsonMap) {
    id = jsonMap['id'];
    noInv = jsonMap['no_inv'];
    reqId = jsonMap['req_id'];
    link = jsonMap['link'];
    service = jsonMap['service'];
    payment = jsonMap['payment'];
    paymentMethod = jsonMap['payment_method'] ?? '-';
    paymentChannel = jsonMap['payment_channel'] ?? '-';
    status = jsonMap['status'];
    total = double.parse(jsonMap['total'].toString());
    createdAt = jsonMap['created_at'];
    try {
      detailTransaction = jsonMap['detail_transactions'];
    } catch (e) {
      try {
        detailTransaction = jsonMap['detail_transactions'][0];
      } catch (e) {
        detailTransaction = null;
      }
    }
  }
}
