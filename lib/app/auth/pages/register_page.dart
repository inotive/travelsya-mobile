import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:travelsya/app/auth/viewmodel/register_vm.dart';
import 'package:travelsya/shared/styles/font_style.dart';
import 'package:travelsya/shared/styles/size_styles.dart';
import 'package:travelsya/shared/styles/theme_style.dart';
import 'package:travelsya/shared/widgets/form_helper/elevated_button_widget.dart';
import 'package:travelsya/shared/widgets/form_helper/rounded_texfield_widget.dart';
import 'package:travelsya/shared/widgets/form_helper/title_with_widget.dart';
import 'package:travelsya/shared/widgets/statusbar_widget.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<RegisterVM>.reactive(
        viewModelBuilder: () {
          return RegisterVM();
        },
        onViewModelReady: (model) {},
        builder: (context, model, child) {
          return StatusbarWidget(
              child: Scaffold(
            backgroundColor: Colors.white,
            body: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).padding.top,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    padding: EdgeInsets.all(margin16),
                    alignment: Alignment.centerRight,
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle, color: Color(0xffFFEEF1)),
                      alignment: Alignment.center,
                      child: Icon(
                        Icons.close,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                ),
                Expanded(
                    child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: margin32,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: margin16),
                        width: double.infinity,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Daftar Akun',
                                style: mainBody1.copyWith(
                                    fontWeight: FontWeight.bold)),
                            SizedBox(
                              height: margin32,
                            ),
                            TitleWithWidget(
                                title: 'Email',
                                validation: model.emailValidation,
                                child: RoundedTextfield(
                                    hintText: 'Masukkan email Anda',
                                    onChanged: (value) {
                                      model.onEmailChanged(value);
                                    },
                                    controller: model.emailController)),
                            SizedBox(height: margin16),
                            TitleWithWidget(
                                title: 'Nama Lengkap',
                                validation: model.nameValidation,
                                child: RoundedTextfield(
                                    hintText: 'Masukkan nama lengkap Anda',
                                    onChanged: (value) {
                                      model.onNameChanged(value);
                                    },
                                    controller: model.nameController)),
                            SizedBox(
                              height: margin4,
                            ),
                            Text('Seperti di KTP/SIM/Paspor.',
                                style: mainBody5.copyWith(color: neutral50)),
                            SizedBox(
                              height: margin16,
                            ),
                            TitleWithWidget(
                                title: 'Kata Sandi',
                                validation: model.passwordValidation,
                                child: RoundedTextfield(
                                    hintText: 'Masukkan kata sandi Anda',
                                    suffixWidget: GestureDetector(
                                        onTap: () {
                                          model.onPasswordIconTap();
                                        },
                                        child: Icon(
                                            model.isPasswordShow
                                                ? Icons.visibility_outlined
                                                : Icons.visibility_off_outlined,
                                            color: model.isPasswordShow
                                                ? Theme.of(context).primaryColor
                                                : Colors.grey)),
                                    obscureText: !model.isPasswordShow,
                                    onChanged: (value) {
                                      model.onPasswordChanged(value);
                                    },
                                    controller: model.passwordController)),
                            SizedBox(
                              height: margin16,
                            ),
                            TitleWithWidget(
                                title: 'Konfirmasi Kata Sandi',
                                validation: model.confirmValidation,
                                child: RoundedTextfield(
                                    hintText: 'Masukkan ulang kata sandi Anda',
                                    suffixWidget: GestureDetector(
                                        onTap: () {
                                          model.onPasswordIconTap();
                                        },
                                        child: Icon(
                                            model.isPasswordShow
                                                ? Icons.visibility_outlined
                                                : Icons.visibility_off_outlined,
                                            color: model.isPasswordShow
                                                ? Theme.of(context).primaryColor
                                                : Colors.grey)),
                                    obscureText: !model.isPasswordShow,
                                    onChanged: (value) {
                                      model.onConfirmChanged(value);
                                    },
                                    controller: model.confirmController)),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: margin32,
                      ),
                    ],
                  ),
                )),
                Container(
                  padding: EdgeInsets.all(margin16),
                  child: ElevatedButtonWidget(
                      onTap: () {
                        model.onRegister(context);
                      },
                      title: 'Buat Akun'),
                )
              ],
            ),
          ));
        });
  }
}
