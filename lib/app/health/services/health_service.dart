import 'package:flutter/material.dart';
import 'package:travelsya/app/health/models/health_model.dart';
import 'package:travelsya/shared/api/api_connection.dart';
import 'package:travelsya/shared/api/api_return_value.dart';
import 'package:http/http.dart' as http;

class HealthService {
  static Future<ApiReturnValue> checkoutHealth(BuildContext context,
      {required Map<String, dynamic> data}) async {
    ApiReturnValue returnValue;

    Map<String, dynamic> dataBody = data;

    ApiReturnValue<dynamic>? response = await ApiReturnValue.httpPostRequest(
        context,
        dataBody: dataBody,
        url: clinicOrderUrl,
        exceptionStatusCode: [201],
        auth: true);

    if (response!.status == RequestStatus.successRequest) {
      returnValue = ApiReturnValue(
          data: response.data['data']['invoice_url'],
          status: RequestStatus.successRequest);
    } else {
      String? messages;
      try {
        messages = response.data['meta']['message'];
      } catch (e) {
        messages = null;
      }
      returnValue = ApiReturnValue(data: messages, status: response.status);
    }

    return returnValue;
  }

  static Future<ApiReturnValue> clinicDetail(BuildContext context,
      {required String id}) async {
    ApiReturnValue returnValue;

    var request = http.MultipartRequest(
      'GET',
      Uri.parse('$clinicDetailUrl/$id'),
    );

    ApiReturnValue<dynamic>? response = await ApiReturnValue.httpRequest(
        context,
        request: request,
        exceptionStatusCode: [201],
        auth: false);

    if (response!.status == RequestStatus.successRequest) {
      returnValue = ApiReturnValue(
          data: HealthDetailModel.fromJson(response.data['data']['show'],
              response.data['data']['mungkin_suka']),
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

  static Future<ApiReturnValue> healthSearch(BuildContext context,
      {String? city, bool isHealth = true}) async {
    ApiReturnValue returnValue;

    var request = http.MultipartRequest(
      'GET',
      Uri.parse(
          '${isHealth ? healthSearchUrl : beautySearchUrl}?location=${city ?? ''}'),
    );

    ApiReturnValue<dynamic>? response = await ApiReturnValue.httpRequest(
        context,
        request: request,
        exceptionStatusCode: [201],
        auth: false);

    if (response!.status == RequestStatus.successRequest) {
      List<HealthPreviewModel> dataFinal = [];

      for (var i = 0; i < response.data['data']['clinic'].length; i++) {
        dataFinal.add(
            HealthPreviewModel.fromJson(response.data['data']['clinic'][i]));
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

  static Future<ApiReturnValue> healthHome(BuildContext context,
      {bool isHealth = true}) async {
    ApiReturnValue returnValue;

    var request = http.MultipartRequest(
      'GET',
      Uri.parse(isHealth ? healthHomeUrl : beautyHomeUrl),
    );

    ApiReturnValue<dynamic>? response = await ApiReturnValue.httpRequest(
        context,
        request: request,
        exceptionStatusCode: [201],
        auth: false);

    if (response!.status == RequestStatus.successRequest) {
      List<HealthCategoryModel> dataCategory = [];
      List<HealthPreviewModel> dataFinal = [];

      for (var i = 0; i < response.data['data']['categories'].length; i++) {
        dataCategory.add(HealthCategoryModel.fromJson(
            response.data['data']['categories'][i]));
      }

      for (var i = 0; i < response.data['data']['special_deals'].length; i++) {
        dataFinal.add(HealthPreviewModel.fromJson(
            response.data['data']['special_deals'][i]));
      }

      returnValue = ApiReturnValue(
          data: [dataCategory, dataFinal],
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

  static Future<ApiReturnValue> healthBeautyHome(
    BuildContext context,
  ) async {
    ApiReturnValue returnValue;

    var request = http.MultipartRequest(
      'GET',
      Uri.parse(healthBeautyListUrl),
    );

    ApiReturnValue<dynamic>? response = await ApiReturnValue.httpRequest(
        context,
        request: request,
        exceptionStatusCode: [201],
        auth: false);

    if (response!.status == RequestStatus.successRequest) {
      List<HealthPreviewModel> datahealth = [];
      List<HealthPreviewModel> databeauty = [];

      for (var i = 0; i < response.data['data']['kesehatan'].length; i++) {
        datahealth.add(
            HealthPreviewModel.fromJson(response.data['data']['kesehatan'][i]));
      }

      for (var i = 0; i < response.data['data']['kecantikan'].length; i++) {
        databeauty.add(HealthPreviewModel.fromJson(
            response.data['data']['kecantikan'][i]));
      }

      returnValue = ApiReturnValue(
          data: [datahealth, databeauty], status: RequestStatus.successRequest);
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
