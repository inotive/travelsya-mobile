import 'package:flutter/material.dart';
import 'package:travelsya/app/rekreasi/models/recreation_model.dart';
import 'package:travelsya/shared/api/api_connection.dart';
import 'package:travelsya/shared/api/api_return_value.dart';
import 'package:http/http.dart' as http;

class RecreationService {
  static Future<ApiReturnValue> checkoutRecreation(BuildContext context,
      {required Map<String, dynamic> data}) async {
    ApiReturnValue returnValue;

    Map<String, dynamic> dataBody = data;

    ApiReturnValue<dynamic>? response = await ApiReturnValue.httpPostRequest(
        context,
        dataBody: dataBody,
        url: recreationOrderUrl,
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

  static Future<ApiReturnValue> recreationSearch(BuildContext context,
      {String city = ''}) async {
    ApiReturnValue returnValue;

    var request = http.MultipartRequest(
      'GET',
      Uri.parse('$recreationSearchUrl?location=$city'),
    );

    ApiReturnValue<dynamic>? response = await ApiReturnValue.httpRequest(
        context,
        request: request,
        exceptionStatusCode: [201],
        auth: false);

    if (response!.status == RequestStatus.successRequest) {
      List<RecreationPreviewModel> dataFinal = [];

      for (var i = 0; i < response.data['data'].length; i++) {
        dataFinal
            .add(RecreationPreviewModel.fromJson(response.data['data'][i]));
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

  static Future<ApiReturnValue> recreationDetail(BuildContext context,
      {required String id}) async {
    ApiReturnValue returnValue;

    var request = http.MultipartRequest(
      'GET',
      Uri.parse('$recreationDetailUrl/$id'),
    );

    ApiReturnValue<dynamic>? response = await ApiReturnValue.httpRequest(
        context,
        request: request,
        exceptionStatusCode: [201],
        auth: false);

    if (response!.status == RequestStatus.successRequest) {
      returnValue = ApiReturnValue(
          data: RecreationDetailModel.fromJson(response.data['data']),
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

  static Future<ApiReturnValue> recreationByCategory(BuildContext context,
      {required String id}) async {
    ApiReturnValue returnValue;

    var request = http.MultipartRequest(
      'GET',
      Uri.parse('$recreationByCategoryUrl/$id'),
    );

    ApiReturnValue<dynamic>? response = await ApiReturnValue.httpRequest(
        context,
        request: request,
        exceptionStatusCode: [201],
        auth: false);

    if (response!.status == RequestStatus.successRequest) {
      List<RecreationPreviewModel> dataFinal = [];

      for (var i = 0; i < response.data['data']['recreations'].length; i++) {
        dataFinal.add(RecreationPreviewModel.fromJson(
            response.data['data']['recreations'][i]));
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

  static Future<ApiReturnValue> recreationCategory(
    BuildContext context,
  ) async {
    ApiReturnValue returnValue;

    var request = http.MultipartRequest(
      'GET',
      Uri.parse(recreationUrl),
    );

    ApiReturnValue<dynamic>? response = await ApiReturnValue.httpRequest(
        context,
        request: request,
        exceptionStatusCode: [201],
        auth: false);

    if (response!.status == RequestStatus.successRequest) {
      List<RecreationCategoryModel> dataFinal = [];

      for (var i = 0; i < response.data['data']['category'].length; i++) {
        dataFinal.add(RecreationCategoryModel.fromJson(
            response.data['data']['category'][i]));
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
