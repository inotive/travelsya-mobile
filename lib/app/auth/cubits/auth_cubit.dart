import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travelsya/shared/function/show_loading.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travelsya/app/auth/cubits/auth_state.dart';
import 'package:travelsya/app/auth/cubits/profile_cubit.dart';
import 'package:travelsya/app/auth/model/user_model.dart';
import 'package:travelsya/app/auth/repository/auth_repository.dart';
import 'package:travelsya/app/ppob/cubits/ppob_cubit.dart';
import 'package:travelsya/shared/cubits/main_index_cubit.dart';
import 'package:travelsya/shared/api/api_return_value.dart';
import 'package:travelsya/shared/function/show_snackbar.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  updateData(UserModel data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('user', json.encode(data.toJson()));

    emit(AuthLoading());
    emit(AuthLoaded(data));
  }

  logout(BuildContext context, {bool isFromSessionOver = false}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (prefs.getString('user') != null) {
      AuthRepository.logout(
        context,
      );
      prefs.remove('user');
      emit(AuthInitial());
      BlocProvider.of<MainIndexCubit>(context).changeIndex(0);
      if (context.mounted) {
        if (isFromSessionOver) {
          showSnackbar(
            context,
            colors: Colors.orange,
            data: 'Sesi Habis, Mohon Login Kembali',
          );
        } else {
          showSnackbar(
            context,
            colors: Colors.green,
            data: 'Logout Berhasil',
          );
        }
      }
    }
  }

  loadSession(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    emit(AuthLoaded(UserModel.fromJson(json.decode(prefs.getString('user')!))));

    BlocProvider.of<ProfileCubit>(context).fetchProfile(context);
  }

  createSession(UserModel data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('user', json.encode(data.toJson()));
  }

  register(
    BuildContext context, {
    required String name,
    required String password,
    required String email,
  }) async {
    showLoading(context);
    AuthRepository.register(context,
            name: name, email: email, password: password)
        .then((value) {
      Navigator.pop(context);
      if (value.status == RequestStatus.successRequest) {
        emit(AuthLoaded(value.data));
        createSession(value.data);
        showSnackbar(context,
            data: 'Berhasil melakukan pendaftaran', colors: Colors.green);
        Navigator.pop(context);
        Navigator.pop(context);
      } else {
        showSnackbar(context,
            data: value.data ?? 'Gagal melakukan pendaftaran',
            colors: Colors.orange);
      }
    });
  }

  login(BuildContext context,
      {required String password,
      required String email,
      required bool isRememberMe}) async {
    showLoading(context);
    AuthRepository.login(context, email: email, password: password)
        .then((value) async {
      Navigator.pop(context);
      if (value.status == RequestStatus.successRequest) {
        emit(AuthLoaded(value.data));
        createSession(value.data);
        BlocProvider.of<ProfileCubit>(context).fetchProfile(context);
        SharedPreferences prefs = await SharedPreferences.getInstance();
        if (isRememberMe) {
          prefs.setString(
              'remember', json.encode({'email': email, 'password': password}));
        } else {
          prefs.remove('remember');
        }
        // ignore: use_build_context_synchronously
        showSnackbar(context,
            data: 'Berhasil melakukan Login', colors: Colors.green);
        Navigator.pop(context);
      } else {
        showSnackbar(context,
            data: value.data ?? 'Gagal melakukan pendaftaran',
            colors: Colors.orange);
      }
    });
  }
}
