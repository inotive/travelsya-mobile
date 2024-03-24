import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:travelsya/shared/styles/font_style.dart';
import 'package:travelsya/shared/styles/theme_style.dart';
import 'package:travelsya/shared/widgets/form_helper.dart';

class RekreasiCheckokutPage extends StatelessWidget {
  const RekreasiCheckokutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
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
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    width: 3.0.w,
                  ),
                  Text(
                    'Informasi Pemesanan',
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
              children: [
                Container(
                  padding: EdgeInsets.symmetric(vertical: 5.0.w),
                  child: Column(
                    children: [
                      CarouselSlider(
                        options: CarouselOptions(
                            viewportFraction: 0.85,
                            autoPlay: false,
                            enableInfiniteScroll: false,
                            onPageChanged: (value, _) {},
                            height: 38.1.w),
                        items: List.generate(3, (index) {
                          return Builder(
                            builder: (BuildContext context) {
                              return Container(
                                margin: EdgeInsets.only(
                                    left: index == 0 ? 0 : 3.0.w),
                                child: Stack(
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
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: Colors.white),
                                        alignment: Alignment.topRight,
                                        child: SizedBox(
                                          width: 20.0.w,
                                          height: 20.0.w,
                                          child: Image.asset(
                                            'assets/icons/Group 23.png',
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: double.infinity,
                                      height: double.infinity,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          border: Border.all(
                                              color: neutral30.withOpacity(0.3),
                                              width: 0.5)),
                                      padding: EdgeInsets.all(3.0.w),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Reflexology 30 menit',
                                            style: mainFont.copyWith(
                                                fontSize: 11.0.sp,
                                                color: neutral100,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            'Tidak bisa refund dan reschedule',
                                            style: mainFont.copyWith(
                                                fontSize: 9.0.sp,
                                                color: neutral30),
                                          ),
                                          Container(
                                            margin: EdgeInsets.symmetric(
                                                vertical: 3.0.w),
                                            width: double.infinity,
                                            height: 1,
                                            color: neutral30.withOpacity(0.3),
                                          ),
                                          Row(
                                            children: [
                                              Expanded(
                                                  child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  SizedBox(
                                                    width: double.infinity,
                                                    child: RichText(
                                                        text: TextSpan(
                                                            style: mainFont
                                                                .copyWith(
                                                                    fontSize:
                                                                        10.0.sp,
                                                                    color:
                                                                        neutral30),
                                                            children: [
                                                          const TextSpan(
                                                              text: 'mulai '),
                                                          const TextSpan(
                                                              text: '1,750,000',
                                                              style: TextStyle(
                                                                  decoration:
                                                                      TextDecoration
                                                                          .lineThrough)),
                                                          TextSpan(
                                                              text:
                                                                  ' IDR 200,500',
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      12.0.sp,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Theme.of(
                                                                          context)
                                                                      .primaryColor)),
                                                        ])),
                                                  ),
                                                  SizedBox(
                                                    width: double.infinity,
                                                    child: Text(
                                                      '/orang (termasuk pajak)',
                                                      style: mainFont.copyWith(
                                                          fontSize: 9.0.sp,
                                                          color: neutral30),
                                                    ),
                                                  )
                                                ],
                                              )),
                                              SizedBox(
                                                width: 3.0.w,
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        }).toList(),
                      ),
                      SizedBox(
                        height: 3.0.w,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 5.0.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              '1',
                              style: mainFont.copyWith(
                                  fontSize: 10.0.sp,
                                  color: neutral100,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              ' /3 Layanan',
                              style: mainFont.copyWith(
                                fontSize: 10.0.sp,
                                color: neutral30,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(5.0.w),
                  color: const Color(0xffFFEEF1),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Jumlah Tiket',
                        style: mainFont.copyWith(
                            fontSize: 12.0.sp,
                            color: neutral100,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 5.0.w,
                      ),
                      Column(
                        children: List.generate(2, (index) {
                          return Container(
                            margin:
                                EdgeInsets.only(bottom: index == 0 ? 3.0.w : 0),
                            child: Row(
                              children: [
                                Expanded(
                                    child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Label',
                                      style: mainFont.copyWith(
                                          fontSize: 9.0.sp, color: neutral100),
                                    ),
                                    Text(
                                      'IDR 130,500/orang',
                                      style: mainFont.copyWith(
                                          fontSize: 11.0.sp,
                                          color: Theme.of(context).primaryColor,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                )),
                                SizedBox(
                                  width: 3.0.w,
                                ),
                                SizedBox(
                                  width: 35.0.w,
                                  child: FormHelper.dropdownForm(
                                    context,
                                    hintText: '-',
                                    data: '2 Orang',
                                  ),
                                )
                              ],
                            ),
                          );
                        }),
                      )
                    ],
                  ),
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
                                color: const Color(0xffffeef1)),
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
                SizedBox(
                  height: 10.0.w,
                )
              ],
            )),
            Container(
              padding: EdgeInsets.all(5.0.w),
              decoration: BoxDecoration(
                  border: Border(
                      top: BorderSide(color: neutral30.withOpacity(0.3)))),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Masa Berlaku',
                        style: mainFont.copyWith(
                            fontSize: 10.0.sp, color: neutral100),
                      ),
                      Text(
                        '15 Feb 2023 - 1 Mar 2023',
                        style: mainFont.copyWith(
                            fontSize: 10.0.sp,
                            color: neutral100,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 1.0.w,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total Biaya',
                        style: mainFont.copyWith(
                            fontSize: 10.0.sp, color: neutral100),
                      ),
                      Text(
                        'IDR 1,561,000',
                        style: mainFont.copyWith(
                            fontSize: 12.0.sp,
                            color: neutral100,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 3.0.w,
                  ),
                  FormHelper.elevatedButtonBasic(context,
                      enabled: true,
                      onTap: () {},
                      title: 'Lanjutkan ke Pembayaran')
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
