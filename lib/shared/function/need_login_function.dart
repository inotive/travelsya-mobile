import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travelsya/app/auth/cubits/auth_cubit.dart';
import 'package:travelsya/app/auth/cubits/auth_state.dart';
import 'package:travelsya/app/auth/pages/login_page/login_page.dart';
import 'package:travelsya/shared/function/show_snackbar.dart';

needLoginFeature(BuildContext context, Function onLogged) {
  AuthState state = BlocProvider.of<AuthCubit>(context).state;

  if (state is AuthLoaded) {
    onLogged();
  } else {
    showSnackbar(context,
        data: 'Silahkan Login untuk mengakses Fitur Ini',
        colors: Colors.orange);
    Navigator.push(
        context, MaterialPageRoute(builder: (_) => const LoginPage()));
  }
}
