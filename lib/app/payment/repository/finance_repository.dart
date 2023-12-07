import 'package:flutter/material.dart';
import 'package:travelsya/app/payment/models/finance_model.dart';
import 'package:travelsya/app/ppob/models/ppob_model.dart';
import 'package:travelsya/shared/api/api_connection.dart';
import 'package:travelsya/shared/api/api_return_value.dart';
import 'package:http/http.dart' as http;

class FinanceRepository {
  static Future<ApiReturnValue> topUp(BuildContext context,
      {required String phone,
      required bool isPointUsed,
      required PPOBModel data,
      required String uniqueCode}) async {
    ApiReturnValue returnValue;

    String url = '$baseAPIUrl/pulsa/topup';

    Map<String, dynamic> dataBody = {
      'product_id': data.id,
      'kode_unik': uniqueCode,
      'kode_pembayaran': data.code,
      'no_hp': phone,
      'point': isPointUsed ? '1' : '0',
    };

    ApiReturnValue<dynamic>? response = await ApiReturnValue.httpPostRequest(
        context,
        dataBody: dataBody,
        url: url,
        exceptionStatusCode: [201],
        auth: true);

    if (response!.status == RequestStatus.successRequest) {
      returnValue = ApiReturnValue(
          data: response.data['data']['invoice_url'],
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

  static Future<ApiReturnValue> paymentRequestInquiry(BuildContext context,
      {required bool isPointUsed,
      required int productId,
      required String noTagihan,
      required String uniqueCode,
      required String nominalTagihan}) async {
    ApiReturnValue returnValue;

    String url = '$baseAPIUrl/ppob/transaction/request';

    Map<String, dynamic> dataBody = {
      'point': isPointUsed ? 1 : 0,
      'product_id': productId,
      'nomor_tagihan': noTagihan,
      'nominal_tagihan': nominalTagihan,
      'kode_unik': uniqueCode
    };

    ApiReturnValue<dynamic>? response = await ApiReturnValue.httpPostRequest(
        context,
        dataBody: dataBody,
        url: url,
        exceptionStatusCode: [201],
        auth: true);

    if (response!.status == RequestStatus.successRequest) {
      returnValue = ApiReturnValue(
          data: response.data['data']['invoice_url'],
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

  static Future<ApiReturnValue> paymentRequest(
    BuildContext context, {
    required String type,
    required bool isInquiry,
    required bool isPointUsed,
    required List<ItemModel> data,
  }) async {
    ApiReturnValue returnValue;

    String url = '$baseAPIUrl/ppob/transaction/request';

    Map<String, dynamic> dataBody = {
      'point': isPointUsed ? '1' : '0',
      'product_id': data[0].id,
      'nomor_tagihan': data[0].phone
    };

    ApiReturnValue<dynamic>? response = await ApiReturnValue.httpPostRequest(
        context,
        dataBody: dataBody,
        url: url,
        exceptionStatusCode: [201],
        auth: true);

    if (response!.status == RequestStatus.successRequest) {
      returnValue = ApiReturnValue(
          data: response.data['data']['invoice_url'],
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

  static Future<ApiReturnValue> paymentRequestHostel(BuildContext context,
      {required Map<String, dynamic> data}) async {
    ApiReturnValue returnValue;

    String url = '$baseAPIUrl/hostel/transaction/request';

    Map<String, dynamic> dataBody = data;

    ApiReturnValue<dynamic>? response = await ApiReturnValue.httpPostRequest(
        context,
        dataBody: dataBody,
        url: url,
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
      } catch (e) {}
      returnValue = ApiReturnValue(data: messages, status: response.status);
    }

    return returnValue;
  }

  static Future<ApiReturnValue> paymentRequestHotel(BuildContext context,
      {required Map<String, dynamic> data}) async {
    ApiReturnValue returnValue;

    String url = '$baseAPIUrl/hotel/transaction/request';

    Map<String, dynamic> dataBody = data;

    ApiReturnValue<dynamic>? response = await ApiReturnValue.httpPostRequest(
        context,
        dataBody: dataBody,
        url: url,
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
      } catch (e) {}
      returnValue = ApiReturnValue(data: messages, status: response.status);
    }

    return returnValue;
  }
}
