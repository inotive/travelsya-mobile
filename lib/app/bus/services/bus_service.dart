import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:travelsya/app/bus/models/bus_filter_model.dart';
import 'package:travelsya/app/bus/models/bus_model.dart';
import 'package:travelsya/shared/api/api_connection.dart';
import 'package:travelsya/shared/api/api_return_value.dart';
import 'package:http/http.dart' as http;

class BusService {
  static Future<ApiReturnValue> checkoutBus(BuildContext context,
      {required Map<String, dynamic> data}) async {
    ApiReturnValue returnValue;

    Map<String, dynamic> dataBody = data;

    ApiReturnValue<dynamic>? response = await ApiReturnValue.httpPostRequest(
        context,
        dataBody: dataBody,
        url: busCheckoutUrl,
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

  static Future<ApiReturnValue> searchBus(BuildContext context,
      {required BusFilterModel filter}) async {
    ApiReturnValue returnValue;

    var request = http.MultipartRequest('POST', Uri.parse(busSearchUrl));

    request.fields['kota_awal'] = filter.selectedCityOrigin!;
    request.fields['kota_tujuan'] = filter.selectedCityDestination!;

    request.fields['date_pergi'] =
        DateFormat('yyyy-MM-dd').format(filter.selectedDateGo!);
    request.fields['is_pulang_pergi'] = filter.isWayBack ? '1' : '0';
    request.fields['jumlah_penumpang'] = filter.totalPassanger.toString();

    if (filter.isWayBack) {
      request.fields['date_pulang'] =
          DateFormat('yyyy-MM-dd').format(filter.selectedDateBack!);
    }

    ApiReturnValue<dynamic>? response = await ApiReturnValue.httpRequest(
        context,
        request: request,
        exceptionStatusCode: [201, 400],
        auth: true);

    if (response!.status == RequestStatus.successRequest) {
      List<BusDataModel> dataFinal = [];
      List<BusDataModel> dataFinalPulang = [];

      for (var i = 0; i < response.data['data']['pergi'].length; i++) {
        dataFinal.add(BusDataModel.fromJson(
          response.data['data']['pergi'][i],
        ));
      }

      for (var i = 0; i < response.data['data']['pulang'].length; i++) {
        dataFinalPulang.add(BusDataModel.fromJson(
          response.data['data']['pulang'][i],
        ));
      }

      returnValue = ApiReturnValue(
          data: [dataFinal, dataFinalPulang],
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
