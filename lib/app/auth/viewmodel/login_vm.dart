import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';
import 'package:string_validator/string_validator.dart';
import 'package:travelsya/app/auth/cubits/auth_cubit.dart';
import 'package:travelsya/app/auth/pages/forgot_password/forgot_password_page.dart';
import 'package:travelsya/app/auth/pages/register_page.dart';
import 'package:travelsya/shared/function/show_snackbar.dart';

class LoginVM extends BaseViewModel {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isPasswordShow = false;
  bool isRememberMe = false;

  String? emailValidation;
  String? passwordValidation;

  onInit() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString('remember') != null) {
      Map<String, dynamic> jsonMap = json.decode(prefs.getString('remember')!);
      emailController.text = jsonMap['email'];
      passwordController.text = jsonMap['password'];
      isRememberMe = true;
      notifyListeners();
    }
  }

  onRememberMeTap() {
    isRememberMe = !isRememberMe;
    notifyListeners();
  }

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

  onLogin(BuildContext context) {
    onEmailChanged(emailController.text);
    onPasswordChanged(passwordController.text);

    if (emailValidation == null && passwordValidation == null) {
      BlocProvider.of<AuthCubit>(context).login(context,
          isRememberMe: isRememberMe,
          email: emailController.text,
          password: passwordController.text);
    } else {
      showSnackbar(context,
          data: 'Mohon mengisi semua form dengan benar', colors: Colors.orange);
    }
  }

  onRegisterTap(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (_) => const RegisterPage()));
  }

  onForgotPasswordTap(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (_) => const ForgotPasswordPage()));
  }
}
