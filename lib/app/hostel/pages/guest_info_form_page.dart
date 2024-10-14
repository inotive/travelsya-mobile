import 'package:flutter/material.dart';
import 'package:string_validator/string_validator.dart';
import 'package:travelsya/app/hostel/models/hostel_model.dart';
import 'package:travelsya/shared/function/show_snackbar.dart';
import 'package:travelsya/shared/styles/font_style.dart';
import 'package:travelsya/shared/styles/size_styles.dart';
import 'package:travelsya/shared/widgets/form_helper/elevated_button_widget.dart';
import 'package:travelsya/shared/widgets/form_helper/rounded_texfield_widget.dart';
import 'package:travelsya/shared/widgets/form_helper/title_with_widget.dart';

class GuestInfoForm extends StatefulWidget {
  final GuestModel? data;
  const GuestInfoForm({super.key, this.data});

  @override
  State<GuestInfoForm> createState() => _GuestInfoFormState();
}

class _GuestInfoFormState extends State<GuestInfoForm> {
  TextEditingController ktpController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  @override
  void initState() {
    if (widget.data != null) {
      ktpController.text = widget.data!.number;
      nameController.text = widget.data!.name;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Column(
        children: [
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
                    color: Colors.black87,
                  ),
                ),
                SizedBox(
                  width: margin24 / 2,
                ),
                Text(
                  'Informasi Tamu',
                  style: mainFont.copyWith(
                      fontSize: 15,
                      color: Colors.white,
                      fontWeight: FontWeight.w700),
                )
              ],
            ),
          ),
          Expanded(
              child: ListView(
            padding: EdgeInsets.symmetric(horizontal: margin16),
            children: [
              SizedBox(
                height: margin16,
              ),
              TitleWithWidget(
                  title: 'Nomor KTP',
                  child: RoundedTextfield(
                      keyboardType: TextInputType.number,
                      hintText: 'Nomor KTP Tamu',
                      controller: ktpController)),
              SizedBox(
                height: margin16,
              ),
              TitleWithWidget(
                  title: 'Nama Sesuai KTP',
                  child: RoundedTextfield(
                      hintText: 'Nama Sesuai KTP', controller: nameController)),
              SizedBox(
                height: margin32,
              ),
              ElevatedButtonWidget(
                  enabled: true,
                  onTap: () {
                    String validation = '';

                    if (nameController.text.isEmpty) {
                      validation = 'Mohon mengisi nama tamu';
                    } else {
                      if (isAlpha(nameController.text.replaceAll(' ', ''))) {
                        validation = 'Nama Tidak Valid';
                      }
                    }

                    if (ktpController.text.isEmpty) {
                      validation = 'Mohon mengisi nomor KTP tamu';
                    } else {
                      if (ktpController.text.length != 16) {
                        validation = 'Nomor KTP Tidak Valid';
                      }
                    }

                    if (validation.isEmpty) {
                      Navigator.pop(
                          context,
                          GuestModel(
                              type: 'ktp',
                              number: ktpController.text,
                              name: nameController.text));
                    } else {
                      showSnackbar(context,
                          data: validation, colors: Colors.orange);
                    }
                  },
                  title: 'Simpan'),
              SizedBox(
                height: margin32,
              ),
            ],
          ))
        ],
      ),
    ));
  }
}
