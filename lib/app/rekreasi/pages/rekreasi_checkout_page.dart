import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:travelsya/shared/styles/font_style.dart';
import 'package:travelsya/shared/styles/size_styles.dart';
import 'package:travelsya/shared/styles/theme_style.dart';
import 'package:travelsya/shared/widgets/form_helper.dart';
import 'package:travelsya/shared/widgets/form_helper/elevated_button_widget.dart';

class RekreasiCheckokutPage extends StatelessWidget {
  const RekreasiCheckokutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            Container(
              padding: EdgeInsets.all(margin16),
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
                    width: margin24 / 2,
                  ),
                  Text(
                    'Informasi Pemesanan',
                    style: mainBody3.copyWith(
                        color: Colors.white, fontWeight: FontWeight.w700),
                  )
                ],
              ),
            ),
            Expanded(
                child: ListView(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(vertical: margin16),
                  child: Column(
                    children: [
                      CarouselSlider(
                        options: CarouselOptions(
                            viewportFraction: 0.85,
                            autoPlay: false,
                            enableInfiniteScroll: false,
                            onPageChanged: (value, _) {},
                            height: 200),
                        items: List.generate(3, (index) {
                          return Builder(
                            builder: (BuildContext context) {
                              return Container(
                                margin: EdgeInsets.only(
                                    left: index == 0 ? 0 : margin24 / 2),
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
                                          width: 45,
                                          height: 45,
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
                                              color: neutral50, width: 0.5)),
                                      padding: EdgeInsets.all(margin24 / 2),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Reflexology 30 menit',
                                            style: mainBody4.copyWith(
                                                color: neutral100,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            'Tidak bisa refund dan reschedule',
                                            style: mainBody5.copyWith(
                                                color: neutral50),
                                          ),
                                          Container(
                                            margin: EdgeInsets.symmetric(
                                                vertical: margin24 / 2),
                                            width: double.infinity,
                                            height: 1,
                                            color: neutral50.withOpacity(0.3),
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
                                                            style: mainBody4
                                                                .copyWith(
                                                                    color:
                                                                        neutral50),
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
                                                              style: mainBody3.copyWith(
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
                                                      style: mainBody5.copyWith(
                                                          color: neutral50),
                                                    ),
                                                  )
                                                ],
                                              )),
                                              SizedBox(
                                                width: margin24 / 2,
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
                        height: margin24 / 2,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: margin16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              '1',
                              style: mainBody4.copyWith(
                                  color: neutral100,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              ' /3 Layanan',
                              style: mainBody4.copyWith(
                                color: neutral50,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(margin16),
                  color: const Color(0xffFFEEF1),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Jumlah Tiket',
                        style: mainBody4.copyWith(
                            color: neutral100, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: margin16,
                      ),
                      Column(
                        children: List.generate(2, (index) {
                          return Container(
                            margin: EdgeInsets.only(
                                bottom: index == 0 ? margin24 / 2 : 0),
                            child: Row(
                              children: [
                                Expanded(
                                    child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Label',
                                      style:
                                          mainBody5.copyWith(color: neutral100),
                                    ),
                                    Text(
                                      'IDR 130,500/orang',
                                      style: mainBody4.copyWith(
                                          color: Theme.of(context).primaryColor,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                )),
                                SizedBox(
                                  width: margin24 / 2,
                                ),
                                SizedBox(
                                  width: 150,
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
                  padding: EdgeInsets.all(margin16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Metode Pembayaran',
                        style: mainBody3.copyWith(
                            color: neutral100, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: margin16,
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
                                    style:
                                        mainBody4.copyWith(color: neutral100),
                                  ))),
                          SizedBox(
                            width: margin24 / 2,
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                                vertical: margin8, horizontal: margin24 / 2),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: const Color(0xffffeef1)),
                            child: Text(
                              'Topup',
                              style: mainBody4.copyWith(
                                  color: Theme.of(context).primaryColor,
                                  fontWeight: FontWeight.bold),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: margin24 / 2,
                      ),
                      FormHelper.optionsCircle(context,
                          title: 'Metode Pembayaran Lain',
                          onTap: () {},
                          status: false)
                    ],
                  ),
                ),
                SizedBox(
                  height: margin32,
                )
              ],
            )),
            Container(
              padding: EdgeInsets.all(margin16),
              decoration: BoxDecoration(
                  border: Border(
                      top: BorderSide(color: neutral50.withOpacity(0.3)))),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Masa Berlaku',
                        style: mainBody4.copyWith(color: neutral100),
                      ),
                      Text(
                        '15 Feb 2023 - 1 Mar 2023',
                        style: mainBody4.copyWith(
                            color: neutral100, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  SizedBox(height: margin4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total Biaya',
                        style: mainBody4.copyWith(color: neutral100),
                      ),
                      Text(
                        'IDR 1,561,000',
                        style: mainBody3.copyWith(
                            color: neutral100, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  SizedBox(
                    height: margin24 / 2,
                  ),
                  ElevatedButtonWidget(
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
