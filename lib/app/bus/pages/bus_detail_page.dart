import 'package:flutter/material.dart';
import 'package:travelsya/app/bus/pages/bus_checkout_page.dart';
import 'package:travelsya/shared/styles/font_style.dart';
import 'package:travelsya/shared/styles/theme_style.dart';
import 'package:sizer/sizer.dart';

class BusDetailPage extends StatelessWidget {
  const BusDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: const Color(0xfff5f5f5),
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
                      SizedBox(
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
          Container(
              padding: EdgeInsets.all(5.0.w),
              child: Row(
                children: [
                  Flexible(
                    flex: 1,
                    child: SizedBox(
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Boarding Point',
                            style: mainFont.copyWith(
                                fontSize: 9.0.sp, color: neutral30),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Semua Jakarta',
                                style: mainFont.copyWith(
                                    fontSize: 10.0.sp, color: neutral100),
                              ),
                              Icon(
                                Icons.keyboard_arrow_down_rounded,
                                size: 5.0.w,
                                color: neutral30,
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 5.0.w,
                  ),
                  Flexible(
                    flex: 1,
                    child: SizedBox(
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Arrival Point',
                            style: mainFont.copyWith(
                                fontSize: 9.0.sp, color: neutral30),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Semua Surabaya',
                                style: mainFont.copyWith(
                                    fontSize: 10.0.sp, color: neutral100),
                              ),
                              Icon(
                                Icons.keyboard_arrow_down_rounded,
                                size: 5.0.w,
                                color: neutral30,
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  )
                ],
              )),
          Expanded(
              child: Container(
            color: Colors.white,
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 5.0.w),
              children: List.generate(5, (index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const BusCheckoutPage()));
                  },
                  child: Container(
                    margin: EdgeInsets.only(top: index == 0 ? 5.0.w : 3.0.w),
                    padding: EdgeInsets.all(5.0.w),
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: neutral30.withOpacity(0.3))),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                                child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'NADIRA TRANS',
                                  style: mainFont.copyWith(
                                      fontSize: 11.0.sp,
                                      color: neutral100,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  'Executives (Subclass C)',
                                  style: mainFont.copyWith(
                                    fontSize: 9.0.sp,
                                    color: neutral30,
                                  ),
                                ),
                              ],
                            )),
                            SizedBox(
                              width: 3.0.w,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  '35 kursi tersedia',
                                  style: mainFont.copyWith(
                                      fontSize: 9.0.sp, color: Colors.green),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      'IDR 276,002',
                                      style: mainFont.copyWith(
                                          fontSize: 12.0.sp,
                                          color: Theme.of(context).primaryColor,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      ' /pax',
                                      style: mainFont.copyWith(
                                          fontSize: 9.0.sp, color: neutral30),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 3.0.w,
                        ),
                        SizedBox(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 2.0.w,
                              ),
                              IntrinsicHeight(
                                child: Row(
                                  children: [
                                    Container(
                                      constraints:
                                          BoxConstraints(maxWidth: 20.0.w),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            '06.00',
                                            style: mainFont.copyWith(
                                                fontSize: 15.0.sp,
                                                color: neutral100,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            'Sen,  11 Feb 2023',
                                            style: mainFont.copyWith(
                                                fontSize: 10.0.sp,
                                                color: neutral100),
                                          ),
                                          SizedBox(
                                            height: 10.0.w,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.symmetric(
                                          horizontal: 2.0.w),
                                      height: double.infinity,
                                      child: Column(
                                        children: [
                                          Container(
                                            width: 2.0.w,
                                            height: 2.0.w,
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Theme.of(context)
                                                    .primaryColor),
                                          ),
                                          Expanded(
                                              child: Container(
                                            width: 1,
                                            height: double.infinity,
                                            color:
                                                Theme.of(context).primaryColor,
                                          ))
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                        child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Binawan University',
                                          style: mainFont.copyWith(
                                            fontSize: 11.0.sp,
                                            color: neutral100,
                                          ),
                                        ),
                                      ],
                                    ))
                                  ],
                                ),
                              ),
                              IntrinsicHeight(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      constraints:
                                          BoxConstraints(maxWidth: 20.0.w),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            '07:45',
                                            style: mainFont.copyWith(
                                                fontSize: 15.0.sp,
                                                color: neutral100,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            'Sen, 11 Feb 2023',
                                            style: mainFont.copyWith(
                                                fontSize: 10.0.sp,
                                                color: neutral100),
                                          )
                                        ],
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.symmetric(
                                          horizontal: 2.5.w),
                                      child: Container(
                                        width: 2.0.w,
                                        height: 2.0.w,
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color:
                                                Theme.of(context).primaryColor),
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        'Universitas Islam Nasional Cibiru',
                                        style: mainFont.copyWith(
                                          fontSize: 11.0.sp,
                                          color: neutral100,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                );
              }),
            ),
          )),
        ],
      ),
    ));
  }
}
