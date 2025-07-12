import 'package:flutter/material.dart';
import 'package:travelsya/app/homepage/models/ads_model.dart';
import 'package:travelsya/shared/api/api_connection.dart';
import 'package:travelsya/shared/api/api_return_value.dart';
import 'package:http/http.dart' as http;

class AdsRepository {
  static Future<ApiReturnValue> fetchAds(
    BuildContext context,
  ) async {
    ApiReturnValue returnValue;

    var request = http.MultipartRequest(
      'GET',
      Uri.parse(adsUrl),
    );

    ApiReturnValue<dynamic>? response = await ApiReturnValue.httpRequest(
        context,
        request: request,
        exceptionStatusCode: [201, 400],
        auth: false);

    if (response!.status == RequestStatus.successRequest) {
      List<AdsModel> dataFinal = [];

      if (response.data == null) {
        for (var i = 0; i < response.data['data'].length; i++) {
          if (AdsModel.fromJson(response.data['data'][i]).isActive == 1) {
            dataFinal.add(AdsModel.fromJson(response.data['data'][i]));
          }
        }
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
