import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:travelsya/shared/styles/font_style.dart';
import 'package:travelsya/shared/styles/theme_style.dart';
import 'package:travelsya/shared/function/show_snackbar.dart';
import 'package:travelsya/shared/widgets/form_helper.dart';

class PaymentSuccessDialog extends StatelessWidget {
  const PaymentSuccessDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Center(
        child: Container(
          width: 30.0.w,
          height: 2.0.w,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10), color: Colors.white),
        ),
      ),
      SizedBox(
        height: 2.0.w,
      ),
      Expanded(
          child: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10), topRight: Radius.circular(10)),
            color: Colors.white),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 20.0.w,
              height: 20.0.w,
              child: Image.asset('assets/icons/validating-ticket 1.png'),
            ),
            SizedBox(
              height: 3.0.w,
            ),
            Text(
              'Pembayaran Sukses',
              style: mainFont.copyWith(
                  fontSize: 12.0.sp,
                  color: neutral100,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 1.0.w,
            ),
            Text(
              'Pembayaran Anda telah berhasil',
              style: mainFont.copyWith(fontSize: 8.0.sp, color: neutral30),
            ),
            SizedBox(
              height: 5.0.w,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 5.0.w),
              child: FormHelper.elevatedButtonBasic(context,
                  enabled: true, onTap: () {}, title: 'Kembali'),
            )
          ],
        ),
      ))
    ]);
  }
}
