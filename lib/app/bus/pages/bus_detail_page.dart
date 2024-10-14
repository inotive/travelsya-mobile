import 'package:flutter/material.dart';
import 'package:travelsya/app/bus/pages/bus_checkout_page.dart';
import 'package:travelsya/shared/styles/font_style.dart';
import 'package:travelsya/shared/styles/size_styles.dart';
import 'package:travelsya/shared/styles/theme_style.dart';

class BusDetailPage extends StatelessWidget {
  const BusDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: const Color(0xfff5f5f5),
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
                  'Cari Tiket',
                  style: mainBody3.copyWith(
                      color: Colors.white, fontWeight: FontWeight.w700),
                )
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(margin16),
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border(
                    bottom: BorderSide(color: neutral50.withOpacity(0.3)))),
            child: Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  child: Wrap(
                    children: [
                      Text(
                        'Surabaya ke Jakarta',
                        style: mainBody3.copyWith(
                            color: neutral100, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: margin8,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                            vertical: margin4, horizontal: margin24 / 2),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: neutral10),
                        child: Text(
                          'Pergi',
                          style: mainBody5.copyWith(color: neutral50),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: margin24 / 2,
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                      vertical: margin8, horizontal: margin16),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8), color: neutral10),
                  child: Row(
                    children: [
                      SizedBox(
                          width: 16,
                          height: 16,
                          child: Image.asset('assets/icons/users.png')),
                      SizedBox(
                        width: margin8,
                      ),
                      Expanded(
                          child: Text(
                        '2 Penumpang | Ekonomi | 19 Feb 2023',
                        style: mainBody4.copyWith(color: neutral100),
                      )),
                      SizedBox(
                        width: margin8,
                      ),
                      Text(
                        'Ubah',
                        style: mainBody4.copyWith(
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
              padding: EdgeInsets.all(margin16),
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
                            style: mainBody4.copyWith(color: neutral50),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Semua Jakarta',
                                style: mainBody4.copyWith(color: neutral100),
                              ),
                              Icon(
                                Icons.keyboard_arrow_down_rounded,
                                size: margin16,
                                color: neutral50,
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: margin16,
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
                            style: mainBody4.copyWith(color: neutral50),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Semua Surabaya',
                                style: mainBody4.copyWith(color: neutral100),
                              ),
                              Icon(
                                Icons.keyboard_arrow_down_rounded,
                                size: margin16,
                                color: neutral50,
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
              padding: EdgeInsets.symmetric(horizontal: margin16),
              children: List.generate(5, (index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const BusCheckoutPage()));
                  },
                  child: Container(
                    margin: EdgeInsets.only(
                        top: index == 0 ? margin16 : margin24 / 2),
                    padding: EdgeInsets.all(margin16),
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: neutral50.withOpacity(0.3))),
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
                                  style: mainBody4.copyWith(
                                      color: neutral100,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  'Executives (Subclass C)',
                                  style: mainBody5.copyWith(
                                    color: neutral50,
                                  ),
                                ),
                              ],
                            )),
                            SizedBox(
                              width: margin24 / 2,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  '35 kursi tersedia',
                                  style:
                                      mainBody5.copyWith(color: Colors.green),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      'IDR 276,002',
                                      style: mainBody3.copyWith(
                                          color: Theme.of(context).primaryColor,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      ' /pax',
                                      style:
                                          mainBody5.copyWith(color: neutral50),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: margin24 / 2,
                        ),
                        SizedBox(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: margin8,
                              ),
                              IntrinsicHeight(
                                child: Row(
                                  children: [
                                    Container(
                                      constraints:
                                          const BoxConstraints(maxWidth: 64),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            '06.00',
                                            style: mainBody3.copyWith(
                                                color: neutral100,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            'Sen, 11 Feb 2023',
                                            style: mainBody4.copyWith(
                                                color: neutral100),
                                          ),
                                          SizedBox(
                                            height: margin32,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.symmetric(
                                          horizontal: margin8),
                                      height: double.infinity,
                                      child: Column(
                                        children: [
                                          Container(
                                            width: margin8,
                                            height: margin8,
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
                                          style: mainBody4.copyWith(
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
                                          const BoxConstraints(maxWidth: 64),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            '07:45',
                                            style: mainBody3.copyWith(
                                                color: neutral100,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            'Sen, 11 Feb 2023',
                                            style: mainBody4.copyWith(
                                                color: neutral100),
                                          )
                                        ],
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: Container(
                                        width: margin8,
                                        height: margin8,
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color:
                                                Theme.of(context).primaryColor),
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        'Universitas Islam Nasional Cibiru',
                                        style: mainBody4.copyWith(
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
