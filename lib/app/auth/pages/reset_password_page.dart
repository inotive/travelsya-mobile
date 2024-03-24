import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:travelsya/app/profile/vm/change_password_vm.dart';
import 'package:travelsya/shared/styles/font_style.dart';
import 'package:sizer/sizer.dart';
import 'package:travelsya/shared/widgets/form_helper.dart';

class ResetPasswordPage extends StatelessWidget {
  final String code;
  const ResetPasswordPage({Key? key, required this.code}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ChangePasswordVM>.reactive(
        viewModelBuilder: () {
          return ChangePasswordVM();
        },
        onViewModelReady: (model) {},
        builder: (context, model, child) {
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
                            'Ubah Kata Sandi',
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
                              FormHelper.titleWithWidget(
                                  title: 'Kata Sandi Baru',
                                  validation: model.passwordValidation,
                                  widget: FormHelper.roundedTextfield(context,
                                      controller: model.passwordController,
                                      obscureText: !model.isPasswordShow,
                                      onChanged: (value) {
                                    model.onPasswordChanged(value);
                                  },
                                      suffixWidget: GestureDetector(
                                          onTap: () {
                                            model.onPasswordIconTap();
                                          },
                                          child: Icon(
                                              model.isPasswordShow
                                                  ? Icons.visibility_outlined
                                                  : Icons
                                                      .visibility_off_outlined,
                                              color: model.isPasswordShow
                                                  ? Theme.of(context)
                                                      .primaryColor
                                                  : Colors.grey)),
                                      hintText: 'Kata Sandi Baru')),
                              SizedBox(
                                height: 5.0.w,
                              ),
                              FormHelper.titleWithWidget(
                                  title: 'Konfirmasi Kata Sandi Baru',
                                  validation: model.confirmValidation,
                                  widget: FormHelper.roundedTextfield(context,
                                      controller: model.confirmController,
                                      obscureText: !model.isPasswordShow,
                                      onChanged: (value) {
                                    model.onConfirmChanged(value);
                                  },
                                      suffixWidget: GestureDetector(
                                          onTap: () {
                                            model.onPasswordIconTap();
                                          },
                                          child: Icon(
                                              model.isPasswordShow
                                                  ? Icons.visibility_outlined
                                                  : Icons
                                                      .visibility_off_outlined,
                                              color: model.isPasswordShow
                                                  ? Theme.of(context)
                                                      .primaryColor
                                                  : Colors.grey)),
                                      hintText: 'Konfirmasi Kata Sandi Baru'))
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
                          enabled: true, onTap: () {
                        model.onResetPasswordSubmit(context, code: code);
                      }, title: 'Update Kata Sandi'),
                    )
                  ])));
        });
  }
}
