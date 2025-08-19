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
  OrderList? transaction;

  HistoryPoint.fromJson(Map<String, dynamic> jsonMap) {
    id = jsonMap['id'];
    userId = jsonMap['user_id'].toString();
    transactionId = jsonMap['transaction_id'].toString();
    flow = jsonMap['flow'];
    point = int.parse(jsonMap['point'].toString());
    date = jsonMap['date'];
    createdAt = jsonMap['created_at'];
    if (jsonMap['transaction'] != null) {
      transaction = OrderList.fromJsonPoint(jsonMap['transaction']);
    } else {
      transaction = null;
    }
  }
}

class ProfileModel {
  late UserModel user;
  List<HistoryPoint> point = [];

  ProfileModel.fromJson(Map<String, dynamic> jsonMap) {
    user = UserModel.fromJsonWithToken(jsonMap, '');
    if (jsonMap['history_point'] != null) {
      for (var item in jsonMap['history_point']) {
        point.add(HistoryPoint.fromJson(item));
      }
    }
  }
}
