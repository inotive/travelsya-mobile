import 'package:flutter/material.dart';
import 'package:travelsya/shared/api/api_connection.dart';
import 'package:travelsya/shared/api/api_return_value.dart';
import 'package:http/http.dart' as http;
import 'package:travelsya/shared/cubits/fee_admin/fee_admin_model.dart';

class FeeAdminRepository {
  static Future<ApiReturnValue> fetchFeeAdmin(
    BuildContext context,
  ) async {
    ApiReturnValue returnValue;

    String url = feeAdminUrl;

    var request = http.MultipartRequest(
      'GET',
      Uri.parse(url),
    );

    ApiReturnValue<dynamic>? response = await ApiReturnValue.httpRequest(
        context,
        request: request,
        exceptionStatusCode: [201],
        auth: false);

    if (response!.status == RequestStatus.successRequest) {
      returnValue = ApiReturnValue(
          data: List.generate(response.data['data'].length, (index) {
            return FeeAdmin.fromJson(response.data['data'][index]);
          }),
          status: RequestStatus.successRequest);
    } else {
      String? messages;
      try {
        Map<String, dynamic> datamessages = response.data['data']['response'];

        datamessages.forEach((key, value) {
          messages = value[0];
        });
      } catch (e) {}
      returnValue = ApiReturnValue(data: messages, status: response.status);
    }

    return returnValue;
  }
}
