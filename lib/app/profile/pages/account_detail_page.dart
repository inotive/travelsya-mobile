import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travelsya/shared/function/show_loading.dart';
import 'package:travelsya/app/auth/cubits/auth_cubit.dart';
import 'package:travelsya/app/auth/cubits/auth_state.dart';
import 'package:travelsya/app/auth/repository/auth_repository.dart';
import 'package:travelsya/shared/api/api_return_value.dart';
import 'package:travelsya/shared/function/show_snackbar.dart';
import 'package:travelsya/shared/styles/font_style.dart';
import 'package:travelsya/shared/styles/size_styles.dart';
import 'package:travelsya/shared/widgets/form_helper/elevated_button_widget.dart';
import 'package:travelsya/shared/widgets/form_helper/rounded_texfield_widget.dart';

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
                padding: EdgeInsets.all(margin16),
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
                      width: margin24 / 2,
                    ),
                    Text(
                      'Hapus Akun',
                      style: mainFont.copyWith(
                          fontSize: 15,
                          color: Colors.white,
                          fontWeight: FontWeight.w700),
                    )
                  ],
                ),
              ),
              Expanded(
                  child: Center(
                child: ListView(
                  padding: EdgeInsets.symmetric(horizontal: margin16),
                  shrinkWrap: true,
                  children: [
                    SizedBox(
                      height: margin32,
                    ),
                    const Center(
                      child: Icon(
                        Icons.warning_rounded,
                        color: Colors.orange,
                        size: 100,
                      ),
                    ),
                    SizedBox(
                      height: margin24 / 2,
                    ),
                    Text(
                      'Hapus Akun',
                      textAlign: TextAlign.center,
                      style: mainFont.copyWith(
                          fontSize: 16,
                          color: Colors.black87,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Mohon memasukkan password Anda untuk mengkonfirmasi penghapusan akun, Waktu yang dibutuhkan adalah 2x24 Jam hingga akun Anda kami hapus',
                      textAlign: TextAlign.center,
                      style: mainFont.copyWith(
                        fontSize: 11,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(
                      height: margin16,
                    ),
                    RoundedTextfield(
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
                    const SizedBox(
                      height: 20,
                    ),
                    ElevatedButtonWidget(
                        enabled: true,
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
                              if (value.status ==
                                  RequestStatus.successRequest) {
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
                        },
                        title: 'Konfirmasi Hapus Akun'),
                    SizedBox(
                      height: margin32,
                    ),
                  ],
                ),
              ))
            ])));
  }
}
