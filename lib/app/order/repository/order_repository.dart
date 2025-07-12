import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:travelsya/app/order/models/order_list_model.dart';
import 'package:travelsya/shared/api/api_connection.dart';
import 'package:travelsya/shared/api/api_return_value.dart';
import 'package:http/http.dart' as http;

class OrderRepository {
  static Future<ApiReturnValue> fetchListOrder(BuildContext context,
      {String? invId}) async {
    ApiReturnValue returnValue;

    String url = '$baseAPIUrl/transaction/user';

    if (invId != null) {
      url = '$baseAPIUrl/transaction/invoice?no_inv=$invId';
    }

    var request = http.MultipartRequest('GET', Uri.parse(url));

    ApiReturnValue<dynamic>? response = await ApiReturnValue.httpRequest(
        context,
        request: request,
        exceptionStatusCode: [201, 400],
        auth: true);

    if (response!.status == RequestStatus.successRequest) {
      if (response.data['data'] == null) {
        List<OrderList> dataFinal = [];
        returnValue = ApiReturnValue(
            data: dataFinal, status: RequestStatus.successRequest);
      } else {
        returnValue = ApiReturnValue(
            data: List.generate(response.data['data'].length, (index) {
              return OrderList.fromJson(response.data['data'][index]);
            }).reversed.toList(),
            status: RequestStatus.successRequest);
      }
    } else {
      String? messages;
      try {
        Map<String, dynamic> datamessages = response.data['data']['response'];

        datamessages.forEach((key, value) {
          messages = value[0];
        });
      } catch (e) {
        messages = null;
      }
      returnValue = ApiReturnValue(data: messages, status: response.status);
    }

    return returnValue;
  }

  static Future<ApiReturnValue> fetchDetailOrder(BuildContext context,
      {required String invId}) async {
    ApiReturnValue returnValue;

    String url = '$baseAPIUrl/transaction/invoice?no_inv=$invId';

    var request = http.MultipartRequest('GET', Uri.parse(url));

    ApiReturnValue<dynamic>? response = await ApiReturnValue.httpRequest(
        context,
        request: request,
        exceptionStatusCode: [201, 400],
        auth: true);

    if (response!.status == RequestStatus.successRequest) {
      Map<String, dynamic>? dataFinal;

      try {
        List<dynamic> dataRaw = response.data['data'];

        dataFinal = dataRaw[0];
      } catch (e) {
        dataFinal = response.data['data'];
      }

      returnValue =
          ApiReturnValue(data: dataFinal, status: RequestStatus.successRequest);
    } else {
      String? messages;
      try {
        Map<String, dynamic> datamessages = response.data['data']['response'];

        datamessages.forEach((key, value) {
          messages = value[0];
        });
      } catch (e) {
        messages = null;
      }
      returnValue = ApiReturnValue(data: messages, status: response.status);
    }

    return returnValue;
  }
}
