import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:string_validator/string_validator.dart';
import 'package:travelsya/app/auth/pages/otp_page.dart';
import 'package:travelsya/app/auth/repository/auth_repository.dart';
import 'package:travelsya/shared/api/api_return_value.dart';
import 'package:travelsya/shared/function/show_loading.dart';
import 'package:travelsya/shared/function/show_snackbar.dart';

class ForgotPasswordVM extends BaseViewModel {
  TextEditingController controller = TextEditingController();

  String? emailValidation;

  onChangeEmail(String value) {
    if (isEmail(value)) {
      emailValidation = null;
    } else {
      emailValidation = 'Email tidak valid';
    }
    notifyListeners();
  }

  onResetPassword(BuildContext context) {
    onChangeEmail(controller.text);

    if (emailValidation == null) {
      showLoading(context);
      AuthRepository.forgotPassword(context, email: controller.text)
          .then((value) {
        Navigator.pop(context);
        if (value.status == RequestStatus.successRequest) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => OTPPage(
                        email: controller.text,
                      )));
        } else {
          showSnackbar(context,
              data: value.data ?? 'Gagal mengirim kode reset password',
              colors: Colors.orange);
        }
      });
    } else {
      showSnackbar(context,
          data: 'Mohon cek inputan Anda', colors: Colors.orange);
    }
  }
}
