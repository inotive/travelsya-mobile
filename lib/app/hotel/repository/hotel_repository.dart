import 'package:flutter/material.dart';
import 'package:travelsya/app/hotel/models/hotel_detail_model.dart';
import 'package:travelsya/app/hotel/models/hotel_preview_model.dart';
import 'package:travelsya/app/hotel/models/hotel_room_model.dart';
import 'package:travelsya/shared/api/api_connection.dart';
import 'package:travelsya/shared/api/api_return_value.dart';
import 'package:http/http.dart' as http;

class HotelRepository {
  static Future<ApiReturnValue> ratingHotel(BuildContext context,
      {required String hotelId,
      required String roomId,
      required String review,
      required String star}) async {
    ApiReturnValue returnValue;

    String url = '$baseAPIUrl/hotel/rating';

    var request = http.MultipartRequest('POST', Uri.parse(url));

    request.fields['hotel_id'] = hotelId;
    request.fields['hotel_room_id'] = roomId;
    request.fields['review'] = review;
    request.fields['bintang'] = star;

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
      } catch (e) {}
      returnValue = ApiReturnValue(data: messages, status: response.status);
    }

    return returnValue;
  }

  static Future<ApiReturnValue> fetchListHotel(BuildContext context,
      {String city = '',
      String name = '',
      String? startDate,
      String? room,
      String? guest,
      String? endDate}) async {
    ApiReturnValue returnValue;

    Map<String, String> bodyParam = {};

    if (city.isNotEmpty) {
      bodyParam['location'] = city;
    }

    if (startDate != null && endDate != null) {
      bodyParam['check_in'] = startDate;
      bodyParam['check_out'] = endDate;
    }

    if (room != null) {
      bodyParam['room'] = room;
    }

    if (guest != null) {
      bodyParam['quest'] = guest;
    }

    ApiReturnValue<dynamic>? response = await ApiReturnValue.httpPostRequest(
        context,
        url: hotelUrl,
        dataBody: bodyParam,
        exceptionStatusCode: [201, 400],
        auth: true);

    if (response!.status == RequestStatus.successRequest) {
      if (response.data['data'] == null) {
        List<HotelPreview> data = [];
        returnValue =
            ApiReturnValue(data: data, status: RequestStatus.successRequest);
      } else {
        returnValue = ApiReturnValue(
            data: List.generate(response.data['data'].length, (index) {
              return HotelPreview.fromJson(response.data['data'][index]);
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
      } catch (e) {}
      returnValue = ApiReturnValue(data: messages, status: response.status);
    }

    return returnValue;
  }

  static Future<ApiReturnValue> fetchPopulerHotel(
    BuildContext context,
  ) async {
    ApiReturnValue returnValue;

    var request = http.MultipartRequest('GET', Uri.parse(hotelPopularUrl));

    ApiReturnValue<dynamic>? response = await ApiReturnValue.httpRequest(
        context,
        request: request,
        exceptionStatusCode: [201, 400],
        auth: true);

    if (response!.status == RequestStatus.successRequest) {
      if (response.data['data'] == null) {
        List<HotelPreview> data = [];
        returnValue =
            ApiReturnValue(data: data, status: RequestStatus.successRequest);
      } else {
        returnValue = ApiReturnValue(
            data: List.generate(response.data['data'].length, (index) {
              return HotelPreview.fromJson(response.data['data'][index]);
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
      } catch (e) {}
      returnValue = ApiReturnValue(data: messages, status: response.status);
    }

    return returnValue;
  }

  static Future<ApiReturnValue> fetchCityAvailable(
    BuildContext context,
  ) async {
    ApiReturnValue returnValue;

    String url = '$baseAPIUrl/hotel/city';

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
      } catch (e) {}
      returnValue = ApiReturnValue(data: messages, status: response.status);
    }

    return returnValue;
  }

  static Future<ApiReturnValue> fetchDetailHotel(BuildContext context,
      {required String id}) async {
    ApiReturnValue returnValue;

    var request = http.MultipartRequest('GET', Uri.parse('$hotelUrl/$id'));

    ApiReturnValue<dynamic>? response = await ApiReturnValue.httpRequest(
        context,
        request: request,
        exceptionStatusCode: [201, 400],
        auth: true);

    if (response!.status == RequestStatus.successRequest) {
      returnValue = ApiReturnValue(
          data: HotelDetailModel.fromJson(response.data['data'][0]),
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

  static Future<ApiReturnValue> fetchDetailHotelRoom(BuildContext context,
      {required String id}) async {
    ApiReturnValue returnValue;

    var request = http.MultipartRequest('GET', Uri.parse('$hotelRoomUrl/$id'));

    ApiReturnValue<dynamic>? response = await ApiReturnValue.httpRequest(
        context,
        request: request,
        exceptionStatusCode: [201, 400],
        auth: true);

    if (response!.status == RequestStatus.successRequest) {
      returnValue = ApiReturnValue(
          data: HotelRoomDetail.fromJson(response.data['data'][0]),
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
