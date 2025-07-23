import 'package:flutter/material.dart';
import 'package:travelsya/shared/styles/font_style.dart';
import 'package:travelsya/shared/styles/size_styles.dart';
import 'package:travelsya/shared/styles/theme_style.dart';
import 'package:travelsya/shared/widgets/form_helper/elevated_button_widget.dart';
import 'package:travelsya/shared/widgets/form_helper/rounded_texfield_widget.dart';
import 'package:travelsya/shared/widgets/form_helper/title_with_widget.dart';

class SecurityPage extends StatelessWidget {
  const SecurityPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: Colors.white,
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
                    Expanded(
                        child: Text(
                      'Keamanan',
                      style: mainFont.copyWith(
                          fontSize: 15,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ))
                  ],
                ),
              ),
              Expanded(
                  child: ListView(
                children: [
                  Container(
                    padding: EdgeInsets.all(margin16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Biometrik',
                          style: mainFont.copyWith(
                              fontSize: 15,
                              color: neutral100,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: margin24 / 2,
                        ),
                        Row(
                          children: [
                            Expanded(
                                child: Text(
                              'Login lebih cepat dan aman dengan sidik jari atau pengenalan wajah',
                              style: mainFont.copyWith(
                                  fontSize: 12, color: neutral100),
                            )),
                            SizedBox(
                              width: margin24 / 2,
                            ),
                            Switch(
                              value: true,
                              onChanged: (value) {},
                              activeColor: Theme.of(context).primaryColor,
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  Container(
                    height: 8,
                    width: double.infinity,
                    color: neutral10,
                  ),
                  Container(
                    padding: EdgeInsets.all(margin16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Ubah Kata Sandi',
                          style: mainFont.copyWith(
                              fontSize: 15,
                              color: neutral100,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: margin24 / 2,
                        ),
                        TitleWithWidget(
                            title: 'Kata Sandi Lama',
                            child: RoundedTextfield(
                                controller: TextEditingController(),
                                suffixIcon:
                                    const Icon(Icons.visibility_off_outlined),
                                hintText: 'Kata Sandi Lama')),
                        SizedBox(
                          height: margin16,
                        ),
                        TitleWithWidget(
                            title: 'Kata Sandi Baru',
                            child: RoundedTextfield(
                                controller: TextEditingController(),
                                suffixIcon:
                                    const Icon(Icons.visibility_off_outlined),
                                hintText: 'Kata Sandi Baru'))
                      ],
                    ),
                  ),
                  SizedBox(
                    height: margin16,
                  ),
                ],
              )),
              Container(
                padding: EdgeInsets.all(margin16),
                child: ElevatedButtonWidget(
                    enabled: true, onTap: () {}, title: 'Update Kata Sandi'),
              )
            ])));
  }
}
