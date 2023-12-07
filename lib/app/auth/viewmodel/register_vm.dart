import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travelsya/shared/function/show_loading.dart';
import 'package:stacked/stacked.dart';
import 'package:string_validator/string_validator.dart';
import 'package:travelsya/app/auth/cubits/auth_cubit.dart';
import 'package:travelsya/app/auth/repository/auth_repository.dart';

import 'package:travelsya/shared/api/api_return_value.dart';
import 'package:travelsya/shared/function/show_snackbar.dart';
import 'package:travelsya/shared/widgets/form_helper.dart';

class RegisterVM extends BaseViewModel {
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmController = TextEditingController();
  bool isPasswordShow = false;

  String? emailValidation;
  String? nameValidation;
  String? passwordValidation;
  String? confirmValidation;

  onPasswordIconTap() {
    isPasswordShow = !isPasswordShow;
    notifyListeners();
  }

  onEmailChanged(String value) {
    if (value.isEmpty) {
      emailValidation = 'Mohon mengisi email Anda';
    } else {
      if (isEmail(value)) {
        emailValidation = null;
      } else {
        emailValidation = 'Email tidak valid';
      }
    }

    notifyListeners();
  }

  onNameChanged(String value) {
    if (value.isEmpty) {
      nameValidation = 'Mohon mengisi nama Anda';
    } else {
      if (isAlpha(value.replaceAll(' ', ''))) {
        nameValidation = null;
      } else {
        nameValidation =
            'Nama tidak valid, mohon mengisi nama hanya dengan karakter alphabet';
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

  onRegister(BuildContext context) {
    onEmailChanged(emailController.text);
    onNameChanged(nameController.text);
    onPasswordChanged(passwordController.text);
    onConfirmChanged(confirmController.text);

    if (emailValidation == null &&
        nameValidation == null &&
        passwordValidation == null &&
        confirmValidation == null) {
      BlocProvider.of<AuthCubit>(context).register(context,
          name: nameController.text,
          password: passwordController.text,
          email: emailController.text);
    } else {
      showSnackbar(context,
          data: 'Mohon mengisi form dengan benar', colors: Colors.orange);
    }
  }
}
