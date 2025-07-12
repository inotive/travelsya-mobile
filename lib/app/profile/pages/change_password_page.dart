import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:travelsya/app/profile/vm/change_password_vm.dart';
import 'package:travelsya/shared/styles/size_styles.dart';
import 'package:travelsya/shared/widgets/appbar_widget.dart';
import 'package:travelsya/shared/widgets/form_helper/elevated_button_widget.dart';
import 'package:travelsya/shared/widgets/form_helper/rounded_texfield_widget.dart';
import 'package:travelsya/shared/widgets/form_helper/title_with_widget.dart';
import 'package:travelsya/shared/widgets/statusbar_widget.dart';

class ChangePasswordPage extends StatelessWidget {
  const ChangePasswordPage({super.key});

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
                  appBar: appbarWidget(
                    context,
                    title: 'Ubah Kata Sandi',
                  ),
                  backgroundColor: Colors.white,
                  body: Column(children: [
                    Expanded(
                        child: ListView(
                      padding: EdgeInsets.symmetric(horizontal: margin16),
                      children: [
                        SizedBox(
                          height: margin16,
                        ),
                        TitleWithWidget(
                            title: 'Kata Sandi Lama',
                            validation: model.oldPasswordValidation,
                            child: RoundedTextfield(
                                controller: model.oldPasswordController,
                                obscureText: !model.isPasswordShow,
                                onChanged: (value) {
                                  model.onOldPasswordChanged(value);
                                },
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
                                hintText: 'Kata Sandi Lama')),
                        SizedBox(
                          height: margin16,
                        ),
                        TitleWithWidget(
                            title: 'Kata Sandi Baru',
                            validation: model.passwordValidation,
                            child: RoundedTextfield(
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
                                            : Icons.visibility_off_outlined,
                                        color: model.isPasswordShow
                                            ? Theme.of(context).primaryColor
                                            : Colors.grey)),
                                hintText: 'Kata Sandi Baru')),
                        SizedBox(
                          height: margin16,
                        ),
                        TitleWithWidget(
                            title: 'Konfirmasi Kata Sandi Baru',
                            validation: model.confirmValidation,
                            child: RoundedTextfield(
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
                                            : Icons.visibility_off_outlined,
                                        color: model.isPasswordShow
                                            ? Theme.of(context).primaryColor
                                            : Colors.grey)),
                                hintText: 'Konfirmasi Kata Sandi Baru')),
                        SizedBox(
                          height: margin16,
                        ),
                      ],
                    )),
                    Container(
                      padding: EdgeInsets.all(margin16),
                      child: ElevatedButtonWidget(
                          enabled: true,
                          onTap: () {
                            model.onPasswordChangeSubmit(context);
                          },
                          title: 'Update Kata Sandi'),
                    )
                  ])));
        });
  }
}
