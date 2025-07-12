import 'package:travelsya/app/auth/model/user_model.dart';
import 'package:travelsya/app/order/models/order_list_model.dart';

class HistoryPoint {
  late int id;
  late String userId;
  late String transactionId;
  late String flow;
  late String date;
  late String createdAt;
  late int point;
  late OrderList transaction;

  HistoryPoint.frmoJson(Map<String, dynamic> jsonMap) {
    id = jsonMap['id'];
    userId = jsonMap['user_id'].toString();
    transactionId = jsonMap['transaction_id'].toString();
    flow = jsonMap['flow'];
    point = int.parse(jsonMap['point'].toString());
    date = jsonMap['date'];
    createdAt = jsonMap['created_at'];
    transaction = OrderList.fromJsonPoint(jsonMap['transaction']);
  }
}

class ProfileModel {
  late UserModel user;
  List<HistoryPoint> point = [];

  ProfileModel.fromJson(Map<String, dynamic> jsonMap) {
    user = UserModel.fromJsonWithToken(jsonMap, '');
    for (var i = 0; i < jsonMap['history_point'].length; i++) {
      point.add(HistoryPoint.frmoJson(jsonMap['history_point'][i]));
    }
  }
}
