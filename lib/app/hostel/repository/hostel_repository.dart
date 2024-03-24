import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:travelsya/app/hostel/cubits/hostel_state.dart';
import 'package:travelsya/app/hostel/models/hostel_detail_model.dart';
import 'package:travelsya/app/hostel/models/hostel_model.dart';
import 'package:travelsya/app/hostel/models/hostel_room_model.dart';
import 'package:travelsya/shared/api/api_connection.dart';
import 'package:travelsya/shared/api/api_return_value.dart';
import 'package:http/http.dart' as http;

class HostelRepository {
  static Future<ApiReturnValue> ratingHostel(BuildContext context,
      {required String hostelId,
      required String roomId,
      required String review,
      required String transactionId,
      required String star}) async {
    ApiReturnValue returnValue;

    String url = '$baseAPIUrl/hostel/rating';

    var request = http.MultipartRequest('POST', Uri.parse(url));

    request.fields['hostel_id'] = hostelId;
    request.fields['hostel_room_id'] = roomId;
    request.fields['review'] = review;
    request.fields['bintang'] = star;
    request.fields['transaction_id'] = transactionId;

    ApiReturnValue<dynamic>? response = await ApiReturnValue.httpRequest(
        context,
        request: request,
        exceptionStatusCode: [201, 400],
        auth: true);

    if (response!.status == RequestStatus.successRequest) {
      returnValue =
          ApiReturnValue(data: null, status: RequestStatus.successRequest);
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

  static Future<ApiReturnValue> fetchListHostel(BuildContext context,
      {required HostelSearchFilter filter}) async {
    ApiReturnValue returnValue;

    String url = '$baseAPIUrl/hostel';

    var request = http.MultipartRequest(
      'POST',
      Uri.parse(url),
    );

    String endDate = '';

    DateTime currentDate = filter.startDate;

    if (filter.selectedDuration == 'Bulanan') {
      int finalMonth = currentDate.month;
      finalMonth = finalMonth + filter.totalDuration;
      currentDate = DateTime((currentDate.year + (finalMonth ~/ 12)),
          finalMonth % 12, currentDate.day);
    } else if (filter.selectedDuration == 'Harian') {
      currentDate = currentDate.add(Duration(days: filter.totalDuration));
    } else {
      int finalYear = currentDate.year;
      finalYear = finalYear + filter.totalDuration;
      currentDate = DateTime(finalYear, currentDate.month, currentDate.day);
    }

    endDate = DateFormat('yyyy-MM-dd').format(currentDate);

    request.fields['location'] = filter.selectedCity;
    request.fields['duration'] = filter.totalDuration.toString();
    request.fields['type_duration'] =
        filter.selectedDuration.toLowerCase() == 'bulanan'
            ? 'monthly'
            : 'yearly';
    request.fields['rent_start'] =
        DateFormat('yyyy-MM-dd').format(filter.startDate);
    request.fields['rent_end'] = endDate;
    request.fields['property_type'] = filter.propertyType.toLowerCase();
    request.fields['property_room'] = filter.roomType.toLowerCase();
    request.fields['property_furnish'] = filter.furnishType.toLowerCase();

    ApiReturnValue<dynamic>? response = await ApiReturnValue.httpRequest(
        context,
        request: request,
        exceptionStatusCode: [201, 400],
        auth: true);

    if (response!.status == RequestStatus.successRequest) {
      if (response.data['data'] == null) {
        List<HostelPreviewModel> data = [];
        returnValue =
            ApiReturnValue(data: data, status: RequestStatus.successRequest);
      } else {
        returnValue = ApiReturnValue(
            data: List.generate(response.data['data'].length, (index) {
              return HostelPreviewModel.fromJson(response.data['data'][index]);
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

  static Future<ApiReturnValue> fetchDetailHotelRoom(BuildContext context,
      {required String id}) async {
    ApiReturnValue returnValue;

    var request = http.MultipartRequest('GET', Uri.parse('$hostelRoomUrl/$id'));

    ApiReturnValue<dynamic>? response = await ApiReturnValue.httpRequest(
        context,
        request: request,
        exceptionStatusCode: [201, 400],
        auth: true);

    if (response!.status == RequestStatus.successRequest) {
      returnValue = ApiReturnValue(
          data: HostelRoomDetail.fromJson(response.data['data'][0]),
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

  static Future<ApiReturnValue> fetchPopulerHostel(
    BuildContext context,
  ) async {
    ApiReturnValue returnValue;

    String url = '$baseAPIUrl/hostel/populer';

    var request = http.MultipartRequest('GET', Uri.parse(url));

    ApiReturnValue<dynamic>? response = await ApiReturnValue.httpRequest(
        context,
        request: request,
        exceptionStatusCode: [201, 400],
        auth: true);

    if (response!.status == RequestStatus.successRequest) {
      if (response.data['data'] == null) {
        List<HostelPreviewModel> data = [];
        returnValue =
            ApiReturnValue(data: data, status: RequestStatus.successRequest);
      } else {
        returnValue = ApiReturnValue(
            data: List.generate(response.data['data'].length, (index) {
              return HostelPreviewModel.fromJson(response.data['data'][index]);
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

  static Future<ApiReturnValue> fetchCityAvailable(
    BuildContext context,
  ) async {
    ApiReturnValue returnValue;

    String url = '$baseAPIUrl/hostel/city';

    var request = http.MultipartRequest('GET', Uri.parse(url));

    ApiReturnValue<dynamic>? response = await ApiReturnValue.httpRequest(
        context,
        request: request,
        exceptionStatusCode: [201, 400],
        auth: true);

    if (response!.status == RequestStatus.successRequest) {
      if (response.data['data'] == null) {
        List<String> data = [];
        returnValue =
            ApiReturnValue(data: data, status: RequestStatus.successRequest);
      } else {
        List<String> dataFinal = [];
        for (var i = 0; i < response.data['data'].length; i++) {
          dataFinal.add(response.data['data'][i].toString());
        }
        returnValue = ApiReturnValue(
            data: dataFinal, status: RequestStatus.successRequest);
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

  static Future<ApiReturnValue> fetchDetailHostel(BuildContext context,
      {required String id,
      required String durationType,
      required String startDate,
      required String endDate}) async {
    ApiReturnValue returnValue;

    var request = http.MultipartRequest(
        'GET',
        Uri.parse(
            '$hostelUrl/$id?duration_type=$durationType&start_date=$startDate&end_date=$endDate'));

    ApiReturnValue<dynamic>? response = await ApiReturnValue.httpRequest(
        context,
        request: request,
        exceptionStatusCode: [201, 400],
        auth: true);

    if (response!.status == RequestStatus.successRequest) {
      returnValue = ApiReturnValue(
          data: HostelDetailModel.fromJson(response.data['data'][0]),
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
