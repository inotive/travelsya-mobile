import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:string_validator/string_validator.dart';
import 'package:travelsya/app/hostel/models/hostel_model.dart';
import 'package:travelsya/shared/styles/font_style.dart';
import 'package:travelsya/shared/styles/theme_style.dart';
import 'package:sizer/sizer.dart';
import 'package:travelsya/shared/function/show_snackbar.dart';
import 'package:travelsya/shared/widgets/form_helper.dart';

class GuestInfoForm extends StatefulWidget {
  final GuestModel? data;
  const GuestInfoForm({Key? key, this.data}) : super(key: key);

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
                    color: Colors.black87,
                  ),
                ),
                SizedBox(
                  width: 3.0.w,
                ),
                Text(
                  'Informasi Tamu',
                  style: mainFont.copyWith(
                      fontSize: 13.0.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.w700),
                )
              ],
            ),
          ),
          Expanded(
              child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 5.0.w),
            children: [
              SizedBox(
                height: 5.0.w,
              ),
              FormHelper.titleWithWidget(
                  title: 'Nomor KTP',
                  widget: FormHelper.roundedTextfield(context,
                      keyboardType: TextInputType.number,
                      hintText: 'Nomor KTP Tamu',
                      controller: ktpController)),
              SizedBox(
                height: 5.0.w,
              ),
              FormHelper.titleWithWidget(
                  title: 'Nama Sesuai KTP',
                  widget: FormHelper.roundedTextfield(context,
                      hintText: 'Nama Sesuai KTP', controller: nameController)),
              SizedBox(
                height: 10.0.w,
              ),
              FormHelper.elevatedButtonBasic(context, enabled: true, onTap: () {
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

                Navigator.pop(
                    context,
                    GuestModel(
                        type: 'ktp',
                        number: ktpController.text,
                        name: nameController.text));
              }, title: 'Simpan'),
              SizedBox(
                height: 10.0.w,
              ),
            ],
          ))
        ],
      ),
    ));
  }
}
