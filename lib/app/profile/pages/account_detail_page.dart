import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travelsya/shared/function/show_loading.dart';
import 'package:sizer/sizer.dart';
import 'package:travelsya/app/auth/cubits/auth_cubit.dart';
import 'package:travelsya/app/auth/cubits/auth_state.dart';
import 'package:travelsya/app/auth/repository/auth_repository.dart';
import 'package:travelsya/shared/api/api_return_value.dart';
import 'package:travelsya/shared/function/show_snackbar.dart';
import 'package:travelsya/shared/styles/font_style.dart';
import 'package:travelsya/shared/widgets/form_helper.dart';

class AccountDetailPage extends StatefulWidget {
  const AccountDetailPage({super.key});

  @override
  State<AccountDetailPage> createState() => _AccountDetailPageState();
}

class _AccountDetailPageState extends State<AccountDetailPage> {
  TextEditingController passController = TextEditingController();
  bool showPassword = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: const Color(0xfff5f5f5),
            body: Column(children: [
              Container(
                padding: EdgeInsets.all(5.0.w),
                color: Theme.of(context).primaryColor,
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      width: 3.0.w,
                    ),
                    Text(
                      'Hapus Akun',
                      style: mainFont.copyWith(
                          fontSize: 13.0.sp,
                          color: Colors.white,
                          fontWeight: FontWeight.w700),
                    )
                  ],
                ),
              ),
              Expanded(
                  child: Center(
                child: ListView(
                  padding: EdgeInsets.symmetric(horizontal: 5.0.w),
                  shrinkWrap: true,
                  children: [
                    SizedBox(
                      height: 10.0.w,
                    ),
                    Center(
                      child: Icon(
                        Icons.warning_rounded,
                        color: Colors.orange,
                        size: 30.0.w,
                      ),
                    ),
                    SizedBox(
                      height: 3.0.w,
                    ),
                    Text(
                      'Hapus Akun',
                      textAlign: TextAlign.center,
                      style: mainFont.copyWith(
                          fontSize: 14.0.sp,
                          color: Colors.black87,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Mohon memasukkan password Anda untuk mengkonfirmasi penghapusan akun, Waktu yang dibutuhkan adalah 2x24 Jam hingga akun Anda kami hapus',
                      textAlign: TextAlign.center,
                      style: mainFont.copyWith(
                        fontSize: 9.0.sp,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(
                      height: 5.0.w,
                    ),
                    FormHelper.roundedTextfield(context,
                        controller: passController,
                        obscureText: !showPassword,
                        suffixWidget: GestureDetector(
                            onTap: () {
                              setState(() {
                                showPassword = !showPassword;
                              });
                            },
                            child: Icon(
                                showPassword
                                    ? Icons.visibility_outlined
                                    : Icons.visibility_off_outlined,
                                color: showPassword
                                    ? Theme.of(context).primaryColor
                                    : Colors.grey)),
                        hintText: 'Password Akun Anda'),
                    SizedBox(
                      height: 8.0.w,
                    ),
                    FormHelper.elevatedButtonBasic(context, enabled: true,
                        onTap: () {
                      AuthState state =
                          BlocProvider.of<AuthCubit>(context).state;
                      if (state is AuthLoaded) {
                        showLoading(context);
                        AuthRepository.login(context,
                                email: state.data.email,
                                password: passController.text)
                            .then((value) {
                          Navigator.pop(context);
                          if (value.status == RequestStatus.successRequest) {
                            showSnackbar(context,
                                data: 'Pengajuan penghapusan akun berhasil',
                                colors: Colors.green);
                            BlocProvider.of<AuthCubit>(context).logout(
                              context,
                            );
                            Navigator.pop(context);
                          } else {
                            showSnackbar(context,
                                data: 'Password tidak cocok',
                                colors: Colors.orange);
                          }
                        });
                      }
                    }, title: 'Konfirmasi Hapus Akun'),
                    SizedBox(
                      height: 10.0.w,
                    ),
                  ],
                ),
              ))
            ])));
  }
}
