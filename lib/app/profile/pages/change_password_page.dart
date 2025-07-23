import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:travelsya/app/profile/vm/change_password_vm.dart';
import 'package:travelsya/shared/styles/font_style.dart';
import 'package:travelsya/shared/styles/size_styles.dart';
import 'package:travelsya/shared/styles/theme_style.dart';
import 'package:travelsya/shared/widgets/appbar_widget.dart';
import 'package:travelsya/shared/widgets/form_helper/elevated_button_widget.dart';
import 'package:travelsya/shared/widgets/form_helper/rounded_texfield_widget.dart';
import 'package:travelsya/shared/widgets/form_helper/title_with_widget.dart';
import 'package:travelsya/shared/widgets/statusbar_widget.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  bool isSwitched = false;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ChangePasswordVM>.reactive(
        viewModelBuilder: () {
          return ChangePasswordVM();
        },
        onViewModelReady: (model) {},
        builder: (context, model, child) {
          return StatusbarWidget(
              child: Scaffold(
                  appBar: appbarWidget(context,
                      title: 'Keamanan',
                      customColor: Theme.of(context).primaryColor,
                      customForeground: Colors.white),
                  backgroundColor: const Color(0xfff4f4f4),
                  bottomNavigationBar: Padding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                    child: ElevatedButtonWidget(
                      enabled: true,
                      onTap: () {
                        model.onPasswordChangeSubmit(context);
                      },
                      title: 'Update Kata Sandi',
                    ),
                  ),
                  body: LayoutBuilder(
                    builder: (context, constraints) {
                      return SingleChildScrollView(
                        child: ConstrainedBox(
                          constraints:
                              BoxConstraints(minHeight: constraints.maxHeight),
                          child: IntrinsicHeight(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  color: Colors.white,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: margin16, vertical: margin24),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text('Biometrik',
                                                style: mainBody2.copyWith(
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            SizedBox(height: margin16),
                                            Text(
                                                'Login lebih cepat dan aman dengan\nsidik jari atau pengenalan wajah',
                                                style: mainBody4),
                                          ],
                                        ),
                                      ),
                                      Switch(
                                        value: isSwitched,
                                        activeColor: Colors.white,
                                        activeTrackColor: primaryColor,
                                        inactiveThumbColor: Colors.white,
                                        inactiveTrackColor: Colors.red.shade200,
                                        onChanged: (value) {
                                          setState(() {
                                            isSwitched = value;
                                          });
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: margin8,
                                ),
                                Container(
                                  color: Colors.white,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: margin16, vertical: margin24),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Ubah Kata Sandi',
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        height: margin16,
                                      ),
                                      TitleWithWidget(
                                          title: 'Kata Sandi Lama',
                                          validation:
                                              model.oldPasswordValidation,
                                          child: RoundedTextfield(
                                              controller:
                                                  model.oldPasswordController,
                                              obscureText:
                                                  !model.isPasswordShow,
                                              onChanged: (value) {
                                                model.onOldPasswordChanged(
                                                    value);
                                              },
                                              suffixIcon: GestureDetector(
                                                  onTap: () {
                                                    model.onPasswordIconTap();
                                                  },
                                                  child: Icon(
                                                      model.isPasswordShow
                                                          ? Icons
                                                              .visibility_outlined
                                                          : Icons
                                                              .visibility_off_outlined,
                                                      color: model
                                                              .isPasswordShow
                                                          ? Theme.of(context)
                                                              .primaryColor
                                                          : Colors.grey)),
                                              hintText: 'Kata Sandi Lama')),
                                      SizedBox(
                                        height: margin16,
                                      ),
                                      TitleWithWidget(
                                          title: 'Kata Sandi Baru',
                                          validation: model.passwordValidation,
                                          child: RoundedTextfield(
                                              controller:
                                                  model.passwordController,
                                              obscureText:
                                                  !model.isPasswordShow,
                                              onChanged: (value) {
                                                model.onPasswordChanged(value);
                                              },
                                              suffixIcon: GestureDetector(
                                                  onTap: () {
                                                    model.onPasswordIconTap();
                                                  },
                                                  child: Icon(
                                                      model.isPasswordShow
                                                          ? Icons
                                                              .visibility_outlined
                                                          : Icons
                                                              .visibility_off_outlined,
                                                      color: model
                                                              .isPasswordShow
                                                          ? Theme.of(context)
                                                              .primaryColor
                                                          : Colors.grey)),
                                              hintText: 'Kata Sandi Baru')),
                                      SizedBox(
                                        height: margin16,
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                    child: Container(
                                  color: Colors.white,
                                ))
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  )
                  // Column(children: [
                  //   Expanded(
                  //       child: ListView(
                  //     padding: EdgeInsets.symmetric(horizontal: margin16),
                  //     children: [
                  //       SizedBox(
                  //         height: margin16,
                  //       ),
                  //       TitleWithWidget(
                  //           title: 'Kata Sandi Lama',
                  //           validation: model.oldPasswordValidation,
                  //           child: RoundedTextfield(
                  //               controller: model.oldPasswordController,
                  //               obscureText: !model.isPasswordShow,
                  //               onChanged: (value) {
                  //                 model.onOldPasswordChanged(value);
                  //               },
                  //               suffixIcon: GestureDetector(
                  //                   onTap: () {
                  //                     model.onPasswordIconTap();
                  //                   },
                  //                   child: Icon(
                  //                       model.isPasswordShow
                  //                           ? Icons.visibility_outlined
                  //                           : Icons.visibility_off_outlined,
                  //                       color: model.isPasswordShow
                  //                           ? Theme.of(context).primaryColor
                  //                           : Colors.grey)),
                  //               hintText: 'Kata Sandi Lama')),
                  //       SizedBox(
                  //         height: margin16,
                  //       ),
                  //       TitleWithWidget(
                  //           title: 'Kata Sandi Baru',
                  //           validation: model.passwordValidation,
                  //           child: RoundedTextfield(
                  //               controller: model.passwordController,
                  //               obscureText: !model.isPasswordShow,
                  //               onChanged: (value) {
                  //                 model.onPasswordChanged(value);
                  //               },
                  //               suffixIcon: GestureDetector(
                  //                   onTap: () {
                  //                     model.onPasswordIconTap();
                  //                   },
                  //                   child: Icon(
                  //                       model.isPasswordShow
                  //                           ? Icons.visibility_outlined
                  //                           : Icons.visibility_off_outlined,
                  //                       color: model.isPasswordShow
                  //                           ? Theme.of(context).primaryColor
                  //                           : Colors.grey)),
                  //               hintText: 'Kata Sandi Baru')),
                  //       SizedBox(
                  //         height: margin16,
                  //       ),
                  //       TitleWithWidget(
                  //           title: 'Konfirmasi Kata Sandi Baru',
                  //           validation: model.confirmValidation,
                  //           child: RoundedTextfield(
                  //               controller: model.confirmController,
                  //               obscureText: !model.isPasswordShow,
                  //               onChanged: (value) {
                  //                 model.onConfirmChanged(value);
                  //               },
                  //               suffixIcon: GestureDetector(
                  //                   onTap: () {
                  //                     model.onPasswordIconTap();
                  //                   },
                  //                   child: Icon(
                  //                       model.isPasswordShow
                  //                           ? Icons.visibility_outlined
                  //                           : Icons.visibility_off_outlined,
                  //                       color: model.isPasswordShow
                  //                           ? Theme.of(context).primaryColor
                  //                           : Colors.grey)),
                  //               hintText: 'Konfirmasi Kata Sandi Baru')),
                  //       SizedBox(
                  //         height: margin16,
                  //       ),
                  //     ],
                  //   )),
                  //   Container(
                  //     padding: EdgeInsets.all(margin16),
                  //     child: ElevatedButtonWidget(
                  //         enabled: true,
                  //         onTap: () {
                  //           model.onPasswordChangeSubmit(context);
                  //         },
                  //         title: 'Update Kata Sandi'),
                  //   )
                  // ]),
                  ));
        });
  }
}
