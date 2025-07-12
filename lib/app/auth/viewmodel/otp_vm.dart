import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:travelsya/shared/function/show_loading.dart';
import 'package:stacked/stacked.dart';
import 'package:travelsya/app/auth/pages/reset_password_page.dart';
import 'package:travelsya/app/auth/repository/auth_repository.dart';
import 'package:travelsya/shared/api/api_return_value.dart';
import 'package:travelsya/shared/function/show_snackbar.dart';
import 'package:travelsya/shared/styles/font_style.dart';

class OTPVM extends BaseViewModel {
  TextEditingController codeController = TextEditingController();
  bool timerResend = false;
  int countDown = 60;

  PinTheme getThemeDefaultTheme(BuildContext context) {
    return PinTheme(
      width: 40,
      height: 40,
      textStyle: mainFont.copyWith(
          fontSize: 15,
          color: Theme.of(context).primaryColor,
          fontWeight: FontWeight.w600),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.black38)),
      ),
    );
  }

  onSubmit(BuildContext context, String code) {
    showLoading(context);
    AuthRepository.verifyOTP(context, token: code).then((value) {
      Navigator.pop(context);
      if (value.status == RequestStatus.successRequest) {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (_) => ResetPasswordPage(code: code)));
      } else {
        showSnackbar(context,
            data: value.data ?? 'Gagal memverifikasi Kode',
            colors: Colors.orange);
      }
    });
  }

  onResendOtp(BuildContext context, {required String email}) {
    showLoading(context);
    AuthRepository.forgotPassword(context, email: email).then((value) {
      Navigator.pop(context);
      if (value.status == RequestStatus.successRequest) {
        timerResend = false;
        countDown = 60;
        notifyListeners();
        showSnackbar(context,
            data: 'Berhasil memverifikasi Kode', colors: Colors.green);
      } else {
        showSnackbar(context,
            data: value.data ?? 'Gagal mengirim Kode', colors: Colors.orange);
      }
    });
  }

  onInit(BuildContext context) {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!timerResend) {
        countDown = countDown - 1;

        if (countDown == 0) {
          timerResend = true;
        }

        notifyListeners();
      }
    });
  }
}
