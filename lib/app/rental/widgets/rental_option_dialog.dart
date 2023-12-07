import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:travelsya/app/rental/pages/rental_checkout_page.dart';
import 'package:travelsya/shared/styles/font_style.dart';
import 'package:travelsya/shared/styles/theme_style.dart';

class RentalOptionDialog extends StatelessWidget {
  const RentalOptionDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
            children: [
              Container(
                padding: EdgeInsets.all(5.0.w),
                child: Row(
                  children: [
                    Expanded(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Pilih Vendor',
                          style: mainFont.copyWith(
                              fontSize: 12.0.sp,
                              color: neutral100,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 5.0.w,
                        ),
                        Text(
                          'Toyota Grand New Avanza',
                          style: mainFont.copyWith(
                              fontSize: 11.0.sp,
                              color: neutral100,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 2.0.w,
                        ),
                        Row(
                          children: [
                            Container(
                                width: 5.0.w,
                                height: 5.0.w,
                                child: Image.asset('assets/icons/users.png')),
                            SizedBox(
                              width: 1.0.w,
                            ),
                            Text(
                              '6 Orang',
                              style: mainFont.copyWith(
                                  fontSize: 10.0.sp, color: neutral30),
                            ),
                            SizedBox(
                              width: 3.0.w,
                            ),
                            Container(
                                width: 5.0.w,
                                height: 5.0.w,
                                child: Image.asset('assets/icons/users.png')),
                            SizedBox(
                              width: 1.0.w,
                            ),
                            Text(
                              'Otomatis',
                              style: mainFont.copyWith(
                                  fontSize: 10.0.sp, color: neutral30),
                            )
                          ],
                        ),
                      ],
                    )),
                    SizedBox(
                      width: 3.0.w,
                    ),
                    Container(
                        width: 20.0.w,
                        height: 20.0.w,
                        child: Image.asset(
                            'assets/images/xenia miring depan 1.png'))
                  ],
                ),
              ),
              Expanded(
                  child: Container(
                width: double.infinity,
                height: double.infinity,
                color: neutral10,
                child: ListView(
                  padding: EdgeInsets.symmetric(horizontal: 3.0.w),
                  children: List.generate(10, (index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => RentalCheckoutPage()));
                      },
                      child: Container(
                        margin:
                            EdgeInsets.only(top: index == 0 ? 5.0.w : 3.0.w),
                        padding: EdgeInsets.all(3.0.w),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white),
                        child: Row(
                          children: [
                            Expanded(
                                child: Text(
                              'SIGMA RENT CAR',
                              style: mainFont.copyWith(
                                  fontSize: 11.0.sp,
                                  color: neutral100,
                                  fontWeight: FontWeight.bold),
                            )),
                            SizedBox(
                              width: 2.0.w,
                            ),
                            Row(
                              children: [
                                Text(
                                  'IDR 218,999',
                                  style: mainFont.copyWith(
                                      fontSize: 11.0.sp,
                                      color: Theme.of(context).primaryColor,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  ' /hari',
                                  style: mainFont.copyWith(
                                      fontSize: 9.0.sp, color: neutral30),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  }),
                ),
              ))
            ],
          ),
        )),
      ],
    );
  }
}
