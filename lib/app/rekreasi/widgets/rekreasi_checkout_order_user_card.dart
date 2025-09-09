import 'package:flutter/material.dart';
import 'package:travelsya/shared/styles/font_style.dart';
import 'package:travelsya/shared/styles/size_styles.dart';
import 'package:travelsya/shared/widgets/form_helper/rounded_texfield_widget.dart';
import 'package:travelsya/shared/widgets/form_helper/title_with_widget.dart';

class RekreasiCheckoutOrderUserCard extends StatelessWidget {
  const RekreasiCheckoutOrderUserCard({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController phoneController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Detail Pemesan',
            style: mainBody2.copyWith(fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: margin16,
          ),
          TitleWithWidget(
              title: 'Nama Lengkap',
              // validation: model.phoneValidation,
              child: RoundedTextfield(
                controller: nameController,
                // controller: model.phoneController,
                onChanged: (value) {
                  // model.onPhoneChanged(value);
                },
                hintText: 'Seperti di KTP/SIM.',
              )),
          SizedBox(
            height: margin16,
          ),
          TitleWithWidget(
              title: 'Nomor Handphone',
              // validation: model.phoneValidation,
              child: RoundedTextfield(
                controller: phoneController,
                // controller: model.phoneController,
                onChanged: (value) {
                  // model.onPhoneChanged(value);
                },
                // hintText: 'Seperti di KTP/SIM.',
              )),
          SizedBox(
            height: margin16,
          ),
          TitleWithWidget(
              title: 'Email',
              // validation: model.phoneValidation,
              child: RoundedTextfield(
                controller: emailController,
                // controller: model.phoneController,
                onChanged: (value) {
                  // model.onPhoneChanged(value);
                },
                // hintText: 'Seperti di KTP/SIM.',
              )),
        ],
      ),
    );
  }
}
