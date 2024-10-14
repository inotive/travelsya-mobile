import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:stacked/stacked.dart';
import 'package:travelsya/app/auth/viewmodel/otp_vm.dart';
import 'package:travelsya/shared/helper/const_helper.dart';
import 'package:travelsya/shared/styles/font_style.dart';
import 'package:travelsya/shared/styles/size_styles.dart';
import 'package:travelsya/shared/widgets/form_helper/elevated_button_widget.dart';
import 'package:travelsya/shared/widgets/statusbar_widget.dart';

class OTPPage extends StatelessWidget {
  final String email;
  const OTPPage({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<OTPVM>.reactive(viewModelBuilder: () {
      return OTPVM();
    }, onViewModelReady: (model) {
      model.onInit(context);
    }, builder: (context, model, child) {
      return StatusbarWidget(
          child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).padding.top,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      height: margin32,
                    ),
                    Container(
                      width: 65,
                      height: 65,
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle, color: Color(0xffF4F4F4)),
                      alignment: Alignment.center,
                      child: SizedBox(
                        width: 32,
                        height: 32,
                        child: Image.asset(ConstHelper.padlockIcon),
                      ),
                    ),
                    SizedBox(
                      height: margin32,
                    ),
                    Text(
                      'Verifikasi Akun',
                      style: mainFont.copyWith(
                          fontSize: 17,
                          color: Colors.black87,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: margin16,
                    ),
                    Text(
                      'Masukkan kode OTP yang telah dikirim ke',
                      style: mainFont.copyWith(
                          fontSize: 13, color: Colors.black87),
                    ),
                    Text(
                      email,
                      style: mainFont.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                          color: Colors.black87),
                    ),
                    SizedBox(
                      height: margin32,
                    ),
                    Container(
                      padding: EdgeInsets.all(margin16),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          color: const Color(0xffF4F4F4)),
                      child: Pinput(
                        length: 6,
                        controller: model.codeController,
                        defaultPinTheme: model.getThemeDefaultTheme(context),
                        focusedPinTheme: model
                            .getThemeDefaultTheme(context)
                            .copyDecorationWith(
                              borderRadius: BorderRadius.circular(8),
                            ),
                        submittedPinTheme: model
                            .getThemeDefaultTheme(context)
                            .copyDecorationWith(
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
                      height: margin32,
                    ),
                    Text(
                      'Tidak terima Kode OTP?',
                      style: mainFont.copyWith(
                          fontSize: 13, color: Colors.black87),
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
                                  fontSize: 13,
                                  color: Theme.of(context).primaryColor),
                            ),
                          )
                        : Text(
                            'Kirim Ulang (00:${model.countDown.toString().padLeft(2, '0')})',
                            style: mainFont.copyWith(
                                fontSize: 13, color: Colors.grey),
                          ),
                    SizedBox(
                      height: margin32,
                    ),
                  ],
                ),
              ),
            ),
            Container(
                padding: EdgeInsets.all(margin16),
                child: ElevatedButtonWidget(
                    enabled: true,
                    onTap: () {
                      model.onSubmit(context, model.codeController.text);
                    },
                    title: 'Verifikasi Akun'))
          ],
        ),
      ));
    });
  }
}
