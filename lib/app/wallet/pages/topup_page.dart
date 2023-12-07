import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:travelsya/shared/styles/font_style.dart';
import 'package:travelsya/shared/styles/theme_style.dart';
import 'package:travelsya/shared/function/show_snackbar.dart';
import 'package:travelsya/shared/widgets/form_helper.dart';

class TopupPage extends StatelessWidget {
  const TopupPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(5.0.w),
            decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(color: neutral30.withOpacity(0.3)))),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.arrow_back,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                SizedBox(
                  width: 3.0.w,
                ),
                Text(
                  'Topup E-Wallet',
                  style: mainFont.copyWith(
                      fontSize: 13.0.sp,
                      color: neutral100,
                      fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
          Expanded(
              child: ListView(
            children: [
              Container(
                padding: EdgeInsets.all(5.0.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Pilih Nominal',
                      style: mainFont.copyWith(
                          fontSize: 12.0.sp,
                          color: neutral100,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 3.0.w,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: Wrap(
                        alignment: WrapAlignment.spaceBetween,
                        runSpacing: 3.0.w,
                        children: List.generate(10, (index) {
                          return Stack(
                            children: [
                              Positioned(
                                top: 0,
                                bottom: 0,
                                left: 0,
                                right: 0,
                                child: Container(
                                  width: double.infinity,
                                  height: double.infinity,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.white),
                                  alignment: Alignment.topRight,
                                  child: SizedBox(
                                    width: 15.0.w,
                                    height: 15.0.w,
                                    child: Image.asset(
                                      'assets/icons/Group 23.png',
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                              FractionallySizedBox(
                                widthFactor: 0.32,
                                child: Container(
                                  padding: EdgeInsets.all(3.0.w),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                          color: neutral30.withOpacity(0.3))),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '5,000',
                                        style: mainFont.copyWith(
                                            fontSize: 12.0.sp,
                                            color: neutral100,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        'Bayar 6,000',
                                        style: mainFont.copyWith(
                                          fontSize: 9.0.sp,
                                          color: neutral30,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          );
                        }),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 5.0.w,
              ),
              Container(
                width: double.infinity,
                height: 2.0.w,
                color: neutral10,
              ),
              Container(
                padding: EdgeInsets.all(5.0.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Metode Pembayaran',
                      style: mainFont.copyWith(
                          fontSize: 13.0.sp,
                          color: neutral100,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 5.0.w,
                    ),
                    Row(
                      children: [
                        Expanded(
                            child: FormHelper.optionsCircle(context,
                                title: 'Travelsya Pay',
                                isBold: true,
                                onTap: () {},
                                status: true,
                                customDetailWidget: Text(
                                  'Balance : Rp32,456',
                                  style: mainFont.copyWith(
                                      fontSize: 10.0.sp, color: neutral100),
                                ))),
                        SizedBox(
                          width: 3.0.w,
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 2.0.w, horizontal: 3.0.w),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Color(0xffffeef1)),
                          child: Text(
                            'Topup',
                            style: mainFont.copyWith(
                                fontSize: 10.0.sp,
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 3.0.w,
                    ),
                    FormHelper.optionsCircle(context,
                        title: 'Metode Pembayaran Lain',
                        onTap: () {},
                        status: false)
                  ],
                ),
              ),
            ],
          )),
          Container(
            padding: EdgeInsets.all(5.0.w),
            decoration: BoxDecoration(
                border:
                    Border(top: BorderSide(color: neutral30.withOpacity(0.3)))),
            child: FormHelper.elevatedButtonBasic(context,
                enabled: true, onTap: () {}, title: 'Topup IDR 11,000'),
          )
        ],
      ),
    ));
  }
}
