import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stacked/stacked.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travelsya/app/auth/cubits/auth_cubit.dart';
import 'package:travelsya/app/home_main/pages/home_main_page.dart';

class SplashVM extends BaseViewModel {
  void onInit(BuildContext context) {
    Timer(const Duration(seconds: 2), () async {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      if (context.mounted) {
        if (prefs.getString('user') != null) {
          BlocProvider.of<AuthCubit>(context).loadSession(context);
        }

        Navigator.push(
            context, MaterialPageRoute(builder: (_) => const HomeMainPage()));
      }
    });
  }
}
