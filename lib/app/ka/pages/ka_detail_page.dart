import 'package:flutter/material.dart';
import 'package:travelsya/app/ka/pages/ka_checkout_page.dart';
import 'package:travelsya/app/plane/pages/plane_checkout_page.dart';
import 'package:travelsya/shared/styles/font_style.dart';
import 'package:travelsya/shared/styles/theme_style.dart';
import 'package:sizer/sizer.dart';

class KADetailPage extends StatelessWidget {
  const KADetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Color(0xfff5f5f5),
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
                  child: Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  width: 3.0.w,
                ),
                Text(
                  'Cari Tiket',
                  style: mainFont.copyWith(
                      fontSize: 13.0.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.w700),
                )
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(5.0.w),
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border(
                    bottom: BorderSide(color: neutral30.withOpacity(0.3)))),
            child: Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  child: Wrap(
                    children: [
                      Text(
                        'Surabaya ke Jakarta',
                        style: mainFont.copyWith(
                            fontSize: 13.0.sp,
                            color: neutral100,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: 2.0.w,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                            vertical: 1.0.w, horizontal: 3.0.w),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: neutral10),
                        child: Text(
                          'Pergi',
                          style: mainFont.copyWith(
                              fontSize: 8.0.sp, color: neutral30),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 3.0.w,
                ),
                Container(
                  padding:
                      EdgeInsets.symmetric(vertical: 2.0.w, horizontal: 4.0.w),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8), color: neutral10),
                  child: Row(
                    children: [
                      Container(
                          width: 4.0.w,
                          height: 4.0.w,
                          child: Image.asset('assets/icons/users.png')),
                      SizedBox(
                        width: 2.0.w,
                      ),
                      Expanded(
                          child: Text(
                        '2 Penumpang | Ekonomi | 19 Feb 2023',
                        style: mainFont.copyWith(
                            fontSize: 10.0.sp, color: neutral100),
                      )),
                      SizedBox(
                        width: 2.0.w,
                      ),
                      Text(
                        'Ubah',
                        style: mainFont.copyWith(
                            fontSize: 10.0.sp,
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          Expanded(
              child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 3.0.w),
            children: List.generate(10, (index) {
              return Container(
                margin:
                    EdgeInsets.only(bottom: 1.0.w, top: index == 0 ? 3.0.w : 0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => KACheckoutPage()));
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: Container(
                      padding: EdgeInsets.all(5.0.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                  child: Text(
                                'JAKA TINGKIR 257A',
                                style: mainFont.copyWith(
                                    fontSize: 11.0.sp,
                                    color: neutral100,
                                    fontWeight: FontWeight.bold),
                              )),
                              SizedBox(
                                width: 3.0.w,
                              ),
                              Icon(
                                Icons.arrow_forward_ios_rounded,
                                color: neutral100,
                                size: 3.0.w,
                              )
                            ],
                          ),
                          Text(
                            'Ekonomi (Subclass C)',
                            style: mainFont.copyWith(
                                fontSize: 9.0.sp, color: neutral30),
                          ),
                          SizedBox(
                            height: 1.0.w,
                          ),
                          IntrinsicHeight(
                            child: Row(
                              children: [
                                Expanded(
                                  child: IntrinsicHeight(
                                    child: Row(
                                      children: [
                                        Column(
                                          children: [
                                            Text(
                                              '06:00',
                                              style: mainFont.copyWith(
                                                  fontSize: 13.0.sp,
                                                  color: neutral100,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text(
                                              'SUB',
                                              style: mainFont.copyWith(
                                                  fontSize: 10.0.sp,
                                                  color: neutral30),
                                            ),
                                          ],
                                        ),
                                        Container(
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 2.0.w),
                                          height: double.infinity,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.arrow_forward_rounded,
                                                color: neutral30,
                                                size: 4.0.w,
                                              ),
                                              SizedBox(
                                                height: 1.0.w,
                                              ),
                                              Text(
                                                '1j 30m',
                                                style: mainFont.copyWith(
                                                    fontSize: 10.0.sp,
                                                    color: neutral30),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Column(
                                          children: [
                                            Text(
                                              '07:30',
                                              style: mainFont.copyWith(
                                                  fontSize: 13.0.sp,
                                                  color: neutral100,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text(
                                              'CGK',
                                              style: mainFont.copyWith(
                                                  fontSize: 10.0.sp,
                                                  color: neutral30),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: double.infinity,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        '35 kursi tersedia',
                                        style: mainFont.copyWith(
                                            fontSize: 8.0.sp,
                                            color: Colors.green),
                                      ),
                                      Row(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Text(
                                            'IDR 276,002',
                                            style: mainFont.copyWith(
                                                fontSize: 12.0.sp,
                                                color: Theme.of(context)
                                                    .primaryColor,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            ' /pax',
                                            style: mainFont.copyWith(
                                                fontSize: 11.0.sp,
                                                color: neutral30),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }),
          ))
        ],
      ),
    ));
  }
}
