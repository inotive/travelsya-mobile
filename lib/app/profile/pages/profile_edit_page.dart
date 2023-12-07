import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:travelsya/app/profile/vm/profile_edit_vm.dart';
import 'package:travelsya/shared/styles/font_style.dart';
import 'package:travelsya/shared/styles/size_styles.dart';
import 'package:travelsya/shared/widgets/appbar_widget.dart';
import 'package:travelsya/shared/widgets/form_helper.dart';
import 'package:travelsya/shared/widgets/form_helper/elevated_button_widget.dart';
import 'package:travelsya/shared/widgets/form_helper/rounded_texfield_widget.dart';
import 'package:travelsya/shared/widgets/form_helper/title_with_widget.dart';

class ProfileEditPage extends StatelessWidget {
  const ProfileEditPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ProfileEditVM>.reactive(viewModelBuilder: () {
      return ProfileEditVM();
    }, onViewModelReady: (model) {
      model.onInit(context);
    }, builder: (context, model, child) {
      return SafeArea(
          child: Scaffold(
              appBar: appbarWidget(context, title: 'Update Profile'),
              backgroundColor: Colors.white,
              body: ListView(
                children: [
                  Container(
                    padding: EdgeInsets.all(margin16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TitleWithWidget(
                            title: 'Email',
                            validation: model.emailValidation,
                            child: Text(
                              model.emailController.text,
                              style: mainBody4.copyWith(
                                  fontWeight: FontWeight.bold),
                            )),
                        SizedBox(
                          height: margin16,
                        ),
                        TitleWithWidget(
                            title: 'Nama',
                            validation: model.nameValidation,
                            child: RoundedTextfield(
                              controller: model.nameController,
                              onChanged: (value) {
                                model.onNameChanged(value);
                              },
                              hintText: 'Nama',
                            )),
                        SizedBox(
                          height: margin16,
                        ),
                        TitleWithWidget(
                            title: 'Nomor Handphone',
                            validation: model.phoneValidation,
                            child: RoundedTextfield(
                              controller: model.phoneController,
                              onChanged: (value) {
                                model.onPhoneChanged(value);
                              },
                              hintText: 'Nomor Handphone',
                            )),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: margin32,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: margin16),
                    child: ElevatedButtonWidget(
                        enabled: true,
                        onTap: () {
                          model.onUpdateSubmit(context);
                        },
                        title: 'Simpan'),
                  ),
                  SizedBox(height: margin32),
                ],
              )));
    });
  }
}
