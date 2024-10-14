import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travelsya/shared/function/show_loading.dart';
import 'package:stacked/stacked.dart';
import 'package:travelsya/app/auth/cubits/auth_cubit.dart';
import 'package:travelsya/app/auth/cubits/auth_state.dart';
import 'package:travelsya/app/auth/repository/auth_repository.dart';
import 'package:travelsya/shared/api/api_return_value.dart';
import 'package:travelsya/shared/function/show_snackbar.dart';

class ChangePasswordVM extends BaseViewModel {
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmController = TextEditingController();
  TextEditingController oldPasswordController = TextEditingController();

  String? passwordValidation;
  String? confirmValidation;
  String? oldPasswordValidation;

  bool isPasswordShow = false;

  onPasswordIconTap() {
    isPasswordShow = !isPasswordShow;
    notifyListeners();
  }

  onOldPasswordChanged(String value) {
    if (value.isEmpty) {
      oldPasswordValidation = 'Mohon mengisi password lama Anda';
    } else {
      if (value.length >= 8) {
        oldPasswordValidation = null;
      } else {
        oldPasswordValidation = 'Password minimal 8 karakter';
      }
    }
    notifyListeners();
  }

  onPasswordChanged(String value) {
    if (value.isEmpty) {
      passwordValidation = 'Mohon mengisi password';
    } else {
      if (value.length >= 8) {
        passwordValidation = null;
      } else {
        passwordValidation = 'Password minimal 8 karakter';
      }
    }
    notifyListeners();
  }

  onConfirmChanged(String value) {
    if (value.isEmpty) {
      confirmValidation = 'Mohon mengisi konfirmasi kata sandi';
    } else {
      if (value == passwordController.text) {
        confirmValidation = null;
      } else {
        confirmValidation = 'Kata sandi tidak cocok';
      }
    }
    notifyListeners();
  }

  onResetPasswordSubmit(BuildContext context, {required String code}) {
    onPasswordChanged(passwordController.text);
    onConfirmChanged(confirmController.text);

    if (passwordValidation == null && confirmValidation == null) {
      showLoading(context);
      AuthRepository.resetPassword(
        context,
        password: passwordController.text,
        code: code,
      ).then((value) {
        Navigator.pop(context);
        if (value.status == RequestStatus.successRequest) {
          showSnackbar(context,
              data: 'Berhasil Reset Kata Sandi, Silahkan Login Kembali',
              colors: Colors.green);
          Navigator.pop(context);
          Navigator.pop(context);
        } else {
          showSnackbar(context,
              data: value.data ?? 'Gagal Reset kata sandi',
              colors: Colors.orange);
        }
      });
    } else {
      showSnackbar(context,
          data: 'Mohon mengisi form dengan benar', colors: Colors.orange);
    }
  }

  onPasswordChangeSubmit(BuildContext context) {
    onPasswordChanged(passwordController.text);
    onConfirmChanged(confirmController.text);
    onOldPasswordChanged(oldPasswordController.text);

    if (passwordValidation == null &&
        confirmValidation == null &&
        oldPasswordValidation == null) {
      AuthState state = BlocProvider.of<AuthCubit>(context).state;
      if (state is AuthLoaded) {
        showLoading(context);
        AuthRepository.changePassword(context,
                oldPassword: oldPasswordController.text,
                password: passwordController.text,
                data: state.data)
            .then((value) {
          Navigator.pop(context);
          if (value.status == RequestStatus.successRequest) {
            showSnackbar(context,
                data: 'Berhasil menyimpan data kata sandi',
                colors: Colors.green);
            Navigator.pop(context);
          } else {
            showSnackbar(context,
                data: value.data ?? 'Gagal menyimpan data kata sandi',
                colors: Colors.orange);
          }
        });
      }
    } else {
      showSnackbar(context,
          data: 'Mohon mengisi form dengan benar', colors: Colors.orange);
    }
  }
}
