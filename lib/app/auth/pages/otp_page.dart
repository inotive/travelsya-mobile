import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:sizer/sizer.dart';
import 'package:stacked/stacked.dart';
import 'package:travelsya/app/auth/pages/register_page.dart';
import 'package:travelsya/app/auth/viewmodel/otp_vm.dart';
import 'package:travelsya/shared/helper/const_helper.dart';
import 'package:travelsya/shared/styles/font_style.dart';
import 'package:travelsya/shared/styles/theme_style.dart';
import 'package:travelsya/shared/function/show_snackbar.dart';
import 'package:travelsya/shared/widgets/form_helper.dart';

class OTPPage extends StatelessWidget {
  final String email;
  const OTPPage({Key? key, required this.email}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 12.0.w,
      height: 12.0.w,
      textStyle: mainFont.copyWith(
          fontSize: 13.0.sp,
          color: Theme.of(context).primaryColor,
          fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.black38)),
      ),
    );

    return ViewModelBuilder<OTPVM>.reactive(viewModelBuilder: () {
      return OTPVM();
    }, onViewModelReady: (model) {
      model.onInit(context);
    }, builder: (context, model, child) {
      return SafeArea(
          child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      height: 10.0.w,
                    ),
                    Container(
                      width: 20.0.w,
                      height: 20.0.w,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: Color(0xffF4F4F4)),
                      alignment: Alignment.center,
                      child: SizedBox(
                        width: 10.0.w,
                        height: 10.0.w,
                        child: Image.asset(ConstHelper.padlockIcon),
                      ),
                    ),
                    SizedBox(
                      height: 10.0.w,
                    ),
                    Text(
                      'Verifikasi Akun',
                      style: mainFont.copyWith(
                          fontSize: 15.0.sp,
                          color: Colors.black87,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 5.0.w,
                    ),
                    Text(
                      'Masukkan kode OTP yang telah dikirim ke',
                      style: mainFont.copyWith(
                          fontSize: 11.0.sp, color: Colors.black87),
                    ),
                    Text(
                      email,
                      style: mainFont.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 11.0.sp,
                          color: Colors.black87),
                    ),
                    SizedBox(
                      height: 10.0.w,
                    ),
                    Container(
                      width: 80.0.w,
                      padding: EdgeInsets.all(5.0.w),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          color: Color(0xffF4F4F4)),
                      child: Pinput(
                        length: 6,
                        controller: model.emailController,
                        defaultPinTheme: defaultPinTheme,
                        focusedPinTheme: defaultPinTheme.copyDecorationWith(
                          border:
                              Border.all(color: Theme.of(context).primaryColor),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        submittedPinTheme: defaultPinTheme.copyDecorationWith(
                          border:
                              Border.all(color: Theme.of(context).primaryColor),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                        showCursor: true,
                        onCompleted: (pin) {
                          model.onSubmit(context, pin);
                        },
                      ),
                    ),
                    SizedBox(
                      height: 10.0.w,
                    ),
                    Text(
                      'Tidak terima Kode OTP?',
                      style: mainFont.copyWith(
                          fontSize: 11.0.sp, color: Colors.black87),
                    ),
                    model.timerResend
                        ? GestureDetector(
                            onTap: () {
                              model.onResendOtp(context, email: email);
                            },
                            child: Text(
                              'Kirim Ulang',
                              style: mainFont.copyWith(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 11.0.sp,
                                  color: Theme.of(context).primaryColor),
                            ),
                          )
                        : Text(
                            'Kirim Ulang (00:${model.countDown.toString().padLeft(2, '0')})',
                            style: mainFont.copyWith(
                                fontSize: 11.0.sp, color: Colors.grey),
                          ),
                    SizedBox(
                      height: 10.0.w,
                    ),
                  ],
                ),
              ),
            ),
            Container(
                padding: EdgeInsets.all(5.0.w),
                child: SizedBox(
                  width: 90.0.w,
                  child: FormHelper.elevatedButtonBasic(context,
                      enabled: true, onTap: () {}, title: 'Verifikasi Akun'),
                ))
          ],
        ),
      ));
    });
  }
}
