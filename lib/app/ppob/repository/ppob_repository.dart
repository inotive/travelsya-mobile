import 'package:flutter/material.dart';
import 'package:travelsya/app/ppob/models/ppob_general_model.dart';
import 'package:travelsya/app/ppob/models/ppob_model.dart';
import 'package:travelsya/shared/api/api_connection.dart';
import 'package:travelsya/shared/api/api_return_value.dart';
import 'package:http/http.dart' as http;

class PPOBRepository {
  static Future<ApiReturnValue> fetchPPOBData(
    BuildContext context,
  ) async {
    ApiReturnValue returnValue;

    String url = '$baseAPIUrl/ppob';

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
          data: PPOBGroup.fromJson(response.data),
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

  static Future<ApiReturnValue> inquiryPPOB(BuildContext context,
      {required String inquiryType, required String noPelanggan}) async {
    ApiReturnValue returnValue;

    String url = '$baseAPIUrl/ppob/inquiry/request';

    var request = http.MultipartRequest('POST', Uri.parse(url));

    request.fields['no_pelanggan'] = noPelanggan;
    request.fields['nom'] = inquiryType;

    ApiReturnValue<dynamic>? response = await ApiReturnValue.httpRequest(
        context,
        request: request,
        exceptionStatusCode: [201],
        auth: true);

    if (response!.status == RequestStatus.successRequest) {
      if (response.data['meta']['status'] == 'success') {
        returnValue = ApiReturnValue(
            data: PPOBInquiryGeneralModel.fromJson(response.data['data']),
            status: RequestStatus.successRequest);
      } else {
        String? messages;
        try {
          messages = response.data['data'];
        } catch (e) {}
        returnValue =
            ApiReturnValue(data: messages, status: RequestStatus.failedRequest);
      }
    } else {
      String? messages;
      try {
        messages = response.data['data'];
      } catch (e) {}
      returnValue = ApiReturnValue(data: messages, status: response.status);
    }

    return returnValue;
  }
}
