import 'package:flutter/material.dart';
import 'package:travelsya/shared/styles/font_style.dart';
import 'package:travelsya/shared/styles/theme_style.dart';
import 'package:sizer/sizer.dart';
import 'package:travelsya/shared/widgets/form_helper.dart';

class SecurityPage extends StatelessWidget {
  const SecurityPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: Colors.white,
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
                    Expanded(
                        child: Text(
                      'Keamanan',
                      style: mainFont.copyWith(
                          fontSize: 13.0.sp,
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
                    padding: EdgeInsets.all(5.0.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Biometrik',
                          style: mainFont.copyWith(
                              fontSize: 13.0.sp,
                              color: neutral100,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 3.0.w,
                        ),
                        Row(
                          children: [
                            Expanded(
                                child: Text(
                              'Login lebih cepat dan aman dengan sidik jari atau pengenalan wajah',
                              style: mainFont.copyWith(
                                  fontSize: 10.0.sp, color: neutral100),
                            )),
                            SizedBox(
                              width: 3.0.w,
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
                    height: 2.0.w,
                    width: double.infinity,
                    color: neutral10,
                  ),
                  Container(
                    padding: EdgeInsets.all(5.0.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Ubah Kata Sandi',
                          style: mainFont.copyWith(
                              fontSize: 13.0.sp,
                              color: neutral100,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 3.0.w,
                        ),
                        FormHelper.titleWithWidget(
                            title: 'Kata Sandi Lama',
                            widget: FormHelper.roundedTextfield(context,
                                controller: TextEditingController(),
                                suffixWidget:
                                    const Icon(Icons.visibility_off_outlined),
                                hintText: 'Kata Sandi Lama')),
                        SizedBox(
                          height: 5.0.w,
                        ),
                        FormHelper.titleWithWidget(
                            title: 'Kata Sandi Baru',
                            widget: FormHelper.roundedTextfield(context,
                                controller: TextEditingController(),
                                suffixWidget:
                                    const Icon(Icons.visibility_off_outlined),
                                hintText: 'Kata Sandi Baru'))
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 5.0.w,
                  ),
                ],
              )),
              Container(
                padding: EdgeInsets.all(5.0.w),
                child: FormHelper.elevatedButtonBasic(context,
                    enabled: true, onTap: () {}, title: 'Update Kata Sandi'),
              )
            ])));
  }
}
