import 'package:flutter/material.dart';
import 'package:travelsya/shared/styles/font_style.dart';
import 'package:travelsya/shared/styles/size_styles.dart';
import 'package:travelsya/shared/styles/theme_style.dart';
import 'package:travelsya/shared/widgets/form_helper/elevated_button_widget.dart';

class PaymentSuccessDialog extends StatelessWidget {
  const PaymentSuccessDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Center(
        child: Container(
          width: 100,
          height: 8,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10), color: Colors.white),
        ),
      ),
      SizedBox(
        height: margin8,
      ),
      Expanded(
          child: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10), topRight: Radius.circular(10)),
            color: Colors.white),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 60,
              height: 60,
              child: Image.asset('assets/icons/validating-ticket 1.png'),
            ),
            SizedBox(
              height: margin24 / 2,
            ),
            Text(
              'Pembayaran Sukses',
              style: mainFont.copyWith(
                  fontSize: 13, color: neutral100, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: margin4,
            ),
            Text(
              'Pembayaran Anda telah berhasil',
              style: mainFont.copyWith(fontSize: 11, color: neutral30),
            ),
            SizedBox(
              height: margin16,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: margin16),
              child: ElevatedButtonWidget(
                  enabled: true, onTap: () {}, title: 'Kembali'),
            )
          ],
        ),
      ))
    ]);
  }
}
