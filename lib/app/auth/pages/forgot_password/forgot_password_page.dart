import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:travelsya/app/auth/viewmodel/forgot_password_vm.dart';
import 'package:travelsya/shared/helper/const_helper.dart';
import 'package:travelsya/shared/styles/font_style.dart';
import 'package:travelsya/shared/styles/size_styles.dart';
import 'package:travelsya/shared/widgets/form_helper.dart';
import 'package:travelsya/shared/widgets/form_helper/elevated_button_widget.dart';
import 'package:travelsya/shared/widgets/form_helper/rounded_texfield_widget.dart';
import 'package:travelsya/shared/widgets/form_helper/validation_widget.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ForgotPasswordVM>.reactive(
        viewModelBuilder: () {
          return ForgotPasswordVM();
        },
        onViewModelReady: (model) {},
        builder: (context, model, child) {
          return SafeArea(
              child: Scaffold(
            backgroundColor: Colors.white,
            body: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(margin16),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Icon(
                          Icons.arrow_back,
                          color: Colors.black87,
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: ListView(
                    padding: EdgeInsets.symmetric(horizontal: margin16),
                    shrinkWrap: true,
                    children: [
                      SizedBox(height: margin32),
                      Container(
                        width: 80,
                        height: 80,
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle, color: Color(0xffF4F4F4)),
                        alignment: Alignment.center,
                        child: SizedBox(
                          width: 40,
                          height: 40,
                          child: Image.asset(ConstHelper.padlockIcon),
                        ),
                      ),
                      SizedBox(
                        height: margin32,
                      ),
                      Center(
                        child: Text('Lupa Password',
                            style: mainBody2.copyWith(
                                fontWeight: FontWeight.bold)),
                      ),
                      SizedBox(
                        height: margin24 / 2,
                      ),
                      Container(
                          margin: EdgeInsets.symmetric(horizontal: margin16),
                          child: Text(
                              'Mohon mengisi email Anda untuk melanjutkan reset password',
                              textAlign: TextAlign.center,
                              style: mainBody4)),
                      SizedBox(
                        height: margin32,
                      ),
                      ValidationWidget(
                        validation: model.emailValidation,
                        child: RoundedTextfield(
                            hintText: 'Masukkan email Anda',
                            onChanged: (value) {
                              model.onChangeEmail(value);
                            },
                            keyboardType: TextInputType.emailAddress,
                            controller: model.controller),
                      ),
                      SizedBox(
                        height: margin16,
                      ),
                    ],
                  ),
                ),
                Container(
                    padding: EdgeInsets.all(margin16),
                    child: ElevatedButtonWidget(
                        onTap: () {
                          model.onResetPassword(context);
                        },
                        title: 'Reset Password'))
              ],
            ),
          ));
        });
  }
}
