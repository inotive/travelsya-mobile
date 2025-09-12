import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:travelsya/app/rekreasi/viewmodel/recreation_checkout_vm.dart';
import 'package:travelsya/shared/styles/font_style.dart';
import 'package:travelsya/shared/styles/size_styles.dart';
import 'package:travelsya/shared/widgets/form_helper/rounded_texfield_widget.dart';
import 'package:travelsya/shared/widgets/form_helper/title_with_widget.dart';

class RekreasiCheckoutOrderUserCard extends StatelessWidget {
  const RekreasiCheckoutOrderUserCard({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<RecreationCheckoutVM>.reactive(
      viewModelBuilder: () => RecreationCheckoutVM(),
      onModelReady: (model) => model.onInit(context),
      builder: (context, model, child) {
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
                  child: RoundedTextfield(
                      hintText: 'Masukkan nama lengkap Anda',
                      controller: model.nameController)),
              SizedBox(
                height: margin16,
              ),
              TitleWithWidget(
                  title: 'Nomor Handphone',
                  child: RoundedTextfield(
                      // prefixIcon: Center(
                      //   widthFactor: 1,
                      //   child: Text(
                      //     '+62',
                      //     style: mainBody4.copyWith(color: Colors.black87),
                      //   ),
                      // ),
                      hintText: '812xxxxxx',
                      controller: model.phoneController)),
              SizedBox(
                height: margin16,
              ),
              TitleWithWidget(
                  title: 'Email',
                  child: RoundedTextfield(
                      hintText: 'Masukkan email Anda',
                      controller: model.emailController)),
            ],
          ),
        );
      },
    );
  }
}
