import 'package:flutter/material.dart';
import 'package:travelsya/app/auth/model/profile_model.dart';
import 'package:travelsya/app/auth/model/user_model.dart';
import 'package:travelsya/shared/api/api_connection.dart';
import 'package:travelsya/shared/api/api_return_value.dart';

class AuthRepository {
  static Future<ApiReturnValue> logout(
    BuildContext context,
  ) async {
    ApiReturnValue returnValue;

    String url = '$baseAPIUrl/logout';

    Map<String, String> dataBody = {};

    ApiReturnValue<dynamic>? response = await ApiReturnValue.httpPostRequest(
        context,
        dataBody: dataBody,
        url: url,
        exceptionStatusCode: [201],
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

  static Future<ApiReturnValue> fetchProfile(
    BuildContext context,
  ) async {
    ApiReturnValue returnValue;

    Map<String, String> dataBody = {};

    ApiReturnValue<dynamic>? response = await ApiReturnValue.httpPostRequest(
        context,
        dataBody: dataBody,
        url: profileUrl,
        exceptionStatusCode: [201],
        auth: true);

    if (response!.status == RequestStatus.successRequest) {
      returnValue = ApiReturnValue(
          data: ProfileModel.fromJson(response.data['data']),
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

  static Future<ApiReturnValue> register(
    BuildContext context, {
    required String name,
    required String email,
    required String password,
  }) async {
    ApiReturnValue returnValue;

    Map<String, String> dataBody = {};

    dataBody['name'] = name;
    dataBody['email'] = email;
    dataBody['password'] = password;

    ApiReturnValue<dynamic>? response = await ApiReturnValue.httpPostRequest(
        context,
        dataBody: dataBody,
        url: registerUrl,
        exceptionStatusCode: [201],
        auth: false);

    if (response!.status == RequestStatus.successRequest) {
      returnValue = ApiReturnValue(
          data: UserModel.fromJson(response.data['data']),
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

  static Future<ApiReturnValue> changePassword(BuildContext context,
      {required String oldPassword,
      required String password,
      required UserModel data}) async {
    ApiReturnValue returnValue;

    String url = '$baseAPIUrl/user/update';

    Map<String, String> dataBody = {};

    dataBody['name'] = data.name;
    dataBody['email'] = data.email;
    dataBody['phone'] = data.phone ?? '';
    dataBody['password'] = password;
    dataBody['old_password'] = oldPassword;

    ApiReturnValue<dynamic>? response = await ApiReturnValue.httpPostRequest(
        context,
        dataBody: dataBody,
        url: url,
        exceptionStatusCode: [201, 401],
        auth: true);

    if (response!.status == RequestStatus.successRequest) {
      String datamessages = response.data['meta']['status'];
      if (datamessages == 'error') {
        String? messages;
        try {
          messages = response.data['data']['message'];
        } catch (e) {}

        returnValue =
            ApiReturnValue(data: messages, status: RequestStatus.failedRequest);
      } else {
        returnValue =
            ApiReturnValue(data: null, status: RequestStatus.successRequest);
      }
    } else {
      String? messages;
      try {
        messages = response.data['data']['message'];
      } catch (e) {}
      returnValue = ApiReturnValue(data: messages, status: response.status);
    }

    return returnValue;
  }

  static Future<ApiReturnValue> updateProfile(
    BuildContext context, {
    required String name,
    required String phone,
    required UserModel data,
    required String email,
  }) async {
    ApiReturnValue returnValue;

    Map<String, String> dataBody = {};

    dataBody['name'] = name;
    dataBody['email'] = email;
    dataBody['phone'] = phone;

    ApiReturnValue<dynamic>? response =
        await ApiReturnValue.httpPostRequest(context,
            dataBody: dataBody,
            url: updateProfileUrl,
            exceptionStatusCode: [
              201,
            ],
            auth: true);

    if (response!.status == RequestStatus.successRequest) {
      returnValue = ApiReturnValue(
          data: UserModel.fromJsonWithToken(response.data['data'], data.token),
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

  static Future<ApiReturnValue> resetPassword(BuildContext context,
      {required String password, required String code}) async {
    ApiReturnValue returnValue;

    String url = '$baseAPIUrl/reset-password';

    Map<String, String> dataBody = {};

    dataBody['password'] = password;
    dataBody['token'] = code;

    ApiReturnValue<dynamic>? response = await ApiReturnValue.httpPostRequest(
        context,
        dataBody: dataBody,
        url: url,
        exceptionStatusCode: [201],
        auth: false);

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

  static Future<ApiReturnValue> forgotPassword(BuildContext context,
      {required String email}) async {
    ApiReturnValue returnValue;

    String url = '$baseAPIUrl/send-token-password';

    Map<String, String> dataBody = {};

    dataBody['email'] = email;

    ApiReturnValue<dynamic>? response = await ApiReturnValue.httpPostRequest(
        context,
        dataBody: dataBody,
        url: url,
        exceptionStatusCode: [201],
        auth: false);

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

  static Future<ApiReturnValue> verifyOTP(BuildContext context,
      {required String token}) async {
    ApiReturnValue returnValue;

    String url = '$baseAPIUrl/token-password-confirmation';

    Map<String, String> dataBody = {};

    dataBody['token'] = token;

    ApiReturnValue<dynamic>? response = await ApiReturnValue.httpPostRequest(
        context,
        dataBody: dataBody,
        url: url,
        exceptionStatusCode: [201],
        auth: false);

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

  static Future<ApiReturnValue> login(
    BuildContext context, {
    required String email,
    required String password,
  }) async {
    ApiReturnValue returnValue;

    Map<String, String> dataBody = {};

    dataBody['email'] = email;
    dataBody['password'] = password;

    ApiReturnValue<dynamic>? response = await ApiReturnValue.httpPostRequest(
        context,
        dataBody: dataBody,
        url: loginUrl,
        exceptionStatusCode: [201, 401],
        auth: false);

    if (response!.status == RequestStatus.successRequest) {
      if (response.data['meta']['code'] == 200) {
        returnValue = ApiReturnValue(
            data: UserModel.fromJson(response.data['data']),
            status: RequestStatus.successRequest);
      } else {
        returnValue = ApiReturnValue(
            data: 'Email atau Password Salah',
            status: RequestStatus.failedRequest);
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
}
