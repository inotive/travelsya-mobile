import 'package:flutter/material.dart';
import 'package:travelsya/app/health/models/health_model.dart';
import 'package:travelsya/app/health/models/health_search_type.dart';
import 'package:travelsya/shared/api/api_connection.dart';
import 'package:travelsya/shared/api/api_return_value.dart';
import 'package:http/http.dart' as http;
import 'package:travelsya/shared/widgets/city_picker_bottomsheet.dart';

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

  static Future<ApiReturnValue> healthSearch(
    BuildContext context, {
    String? city,
    required HealthSearchType type,
  }) async {
    ApiReturnValue returnValue;

    late String url;

    switch (type) {
      case HealthSearchType.health:
        url = healthSearchUrl;
        break;
      case HealthSearchType.beauty:
        url = beautySearchUrl;
        break;
      case HealthSearchType.spa:
        url = spaSearchUrl;
        break;
    }

    final request = http.MultipartRequest(
      'GET',
      Uri.parse('$url?location=${city ?? ''}'),
    );

    print("DEBUG => search type: $type | city: $city");

    ApiReturnValue<dynamic>? response = await ApiReturnValue.httpRequest(
      context,
      request: request,
      exceptionStatusCode: [201],
      auth: false,
    );

    if (response!.status == RequestStatus.successRequest) {
      List<HealthPreviewModel> dataFinal = [];

      for (var item in response.data['data']['clinic']) {
        dataFinal.add(HealthPreviewModel.fromJson(item));
      }

      returnValue = ApiReturnValue(
        data: dataFinal,
        status: RequestStatus.successRequest,
      );
    } else {
      String? messages;
      try {
        final Map<String, dynamic> datamessages =
            response.data['data']['response'];

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

  // static Future<ApiReturnValue> getCities(BuildContext context,
  //     {CityPickerType type = CityPickerType.health}) async {
  //   ApiReturnValue returnValue;

  //   var request = http.MultipartRequest('GET', Uri.parse(healthCityUrl));

  //   ApiReturnValue<dynamic>? response = await ApiReturnValue.httpRequest(
  //     context,
  //     request: request,
  //     exceptionStatusCode: [201, 400],
  //     auth: true,
  //   );

  //   if (response!.status == RequestStatus.successRequest) {
  //     List<HealthCityModel> dataFinal = (response.data['data'] as List)
  //         .map<HealthCityModel>((city) => HealthCityModel.fromJson(city))
  //         .toList();

  //     returnValue = ApiReturnValue(
  //       data: dataFinal,
  //       status: RequestStatus.successRequest,
  //     );
  //   } else {
  //     String? messages;
  //     try {
  //       Map<String, dynamic> datamessages = response.data['data']['response'];
  //       datamessages.forEach((key, value) {
  //         messages = value[0];
  //       });
  //     } catch (e) {
  //       messages = null;
  //     }
  //     returnValue = ApiReturnValue(
  //       data: messages,
  //       status: response.status,
  //     );
  //   }

  //   return returnValue;
  // }

  static Future<ApiReturnValue> getCities(BuildContext context,
      {CityPickerType type = CityPickerType.health}) async {
    ApiReturnValue returnValue;

    String url = healthCityUrl;

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

  static Future<ApiReturnValue> spaHome(BuildContext context) async {
    ApiReturnValue returnValue;

    var request = http.MultipartRequest(
      'GET',
      Uri.parse(spaHomeUrl),
    );

    ApiReturnValue<dynamic>? response = await ApiReturnValue.httpRequest(
      context,
      request: request,
      exceptionStatusCode: [201],
      auth: false,
    );

    if (response!.status == RequestStatus.successRequest) {
      List<HealthCategoryModel> dataCategory = [];
      List<HealthPreviewModel> dataFinal = [];

      for (var i = 0; i < response.data['data']['categories'].length; i++) {
        dataCategory.add(
          HealthCategoryModel.fromJson(response.data['data']['categories'][i]),
        );
      }

      for (var i = 0; i < response.data['data']['special_deals'].length; i++) {
        dataFinal.add(
          HealthPreviewModel.fromJson(
              response.data['data']['special_deals'][i]),
        );
      }

      returnValue = ApiReturnValue(
        data: [dataCategory, dataFinal],
        status: RequestStatus.successRequest,
      );
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
