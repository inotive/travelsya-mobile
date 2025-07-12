import 'package:flutter/material.dart';
import 'package:travelsya/shared/styles/font_style.dart';
import 'package:travelsya/shared/styles/size_styles.dart';
import 'package:travelsya/shared/widgets/form_helper.dart';
import 'package:travelsya/shared/widgets/form_helper/elevated_button_widget.dart';

class PhotoSourcePickerDialog extends StatelessWidget {
  const PhotoSourcePickerDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Container(
          padding: EdgeInsets.all(margin16),
          width: MediaQuery.of(context).size.width * 0.8,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10), color: Colors.white),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: Text(
                  'Pilih Sumber Foto',
                  style: mainBody4.copyWith(fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(
                  vertical: margin24 / 2,
                ),
                width: double.infinity,
                height: 1,
                color: Colors.black12,
              ),
              ElevatedButtonWidget(
                  enabled: true,
                  onTap: () {
                    Navigator.pop(context, 0);
                  },
                  title: 'Galeri'),
              SizedBox(
                height: margin16,
              ),
              ElevatedButtonWidget(
                  enabled: true,
                  onTap: () {
                    Navigator.pop(context, 1);
                  },
                  title: 'Kamera'),
              SizedBox(
                height: margin32,
              ),
              FormHelper.borderButton(context, onTap: () {
                Navigator.pop(context);
              }, title: 'Batal'),
            ],
          ),
        ),
      ),
    );
  }
}
