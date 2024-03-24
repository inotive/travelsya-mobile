import 'package:flutter/material.dart';
import 'package:travelsya/shared/api/api_connection.dart';
import 'package:travelsya/shared/api/api_return_value.dart';
import 'package:http/http.dart' as http;
import 'package:travelsya/shared/cubits/point/point_model.dart';

class PointRepository {
  static Future<ApiReturnValue> pointFetch(
    BuildContext context,
  ) async {
    ApiReturnValue returnValue;

    String url = pointUrl;

    var request = http.MultipartRequest(
      'GET',
      Uri.parse(url),
    );

    ApiReturnValue<dynamic>? response = await ApiReturnValue.httpRequest(
        context,
        request: request,
        exceptionStatusCode: [201],
        auth: true);

    if (response!.status == RequestStatus.successRequest) {
      returnValue = ApiReturnValue(
          data: PointModel.fromJson(response.data),
          status: RequestStatus.successRequest);
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
