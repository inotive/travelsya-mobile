import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:travelsya/app/rental_mobil/models/rental_mobil_fitler_model.dart';
import 'package:travelsya/app/rental_mobil/models/rental_mobil_model.dart';
import 'package:travelsya/shared/api/api_connection.dart';
import 'package:travelsya/shared/api/api_return_value.dart';
import 'package:http/http.dart' as http;

class RentalMobilService {
  static Future<ApiReturnValue> checkoutRental(BuildContext context,
      {required Map<String, dynamic> data}) async {
    ApiReturnValue returnValue;

    Map<String, dynamic> dataBody = data;

    ApiReturnValue<dynamic>? response = await ApiReturnValue.httpPostRequest(
        context,
        dataBody: dataBody,
        url: carOrderUrl,
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

  static Future<ApiReturnValue> searchRentalMobil(BuildContext context,
      {required RentalMobilFitlerModel filter}) async {
    ApiReturnValue returnValue;

    var request = http.MultipartRequest('POST', Uri.parse(carFindUrl));

    request.fields['location'] = filter.selectedLocation ?? '';
    request.fields['date'] =
        DateFormat('yyyy-MM-dd').format(filter.selectedDate);
    request.fields['jam'] = filter.selectedTime.hour.toString();
    request.fields['duration'] = filter.duration.toString();
    request.fields['with_driver'] = filter.isWithDriver ? '1' : '0';
    request.fields['transmisi'] = filter.tranmition == 0
        ? ''
        : filter.tranmition == 1
            ? 'manual'
            : 'otomatis';

    ApiReturnValue<dynamic>? response = await ApiReturnValue.httpRequest(
        context,
        request: request,
        exceptionStatusCode: [201, 400],
        auth: true);

    if (response!.status == RequestStatus.successRequest) {
      List<RentalMobilModel> dataFinal = [];

      try {
        for (var i = 0; i < response.data['data']['brand'].length; i++) {
          dataFinal.add(RentalMobilModel.fromJson(
              response.data['data']['brand'][i],
              response.data['data']['vendor']));
        }
      } catch (e) {
        Map<String, dynamic> dataTemp = response.data['data']['brand'];

        for (var i = 0; i < dataTemp.keys.length; i++) {
          dataFinal.add(RentalMobilModel.fromJson(
              dataTemp[dataTemp.keys.toList()[i]],
              response.data['data']['vendor']));
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
