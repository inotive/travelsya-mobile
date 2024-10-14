import 'package:flutter/material.dart';
import 'package:travelsya/shared/helper/const_helper.dart';
import 'package:travelsya/shared/styles/font_style.dart';
import 'package:travelsya/shared/styles/size_styles.dart';
import 'package:travelsya/shared/styles/theme_style.dart';

class MutasiPage extends StatefulWidget {
  const MutasiPage({super.key});

  @override
  State<MutasiPage> createState() => _MutasiPageState();
}

class _MutasiPageState extends State<MutasiPage> {
  List<Map<String, dynamic>> dataHistory = [
    {
      'group_date': 'Hari Ini',
      'data': [
        {
          'type': 1,
          'title': 'MEISO KELAPA GADING',
          'desc': 'Reflexology 30 menit',
          'value': 'IDR 211,000',
          'assets': ConstHelper.hotelIcon
        },
        {
          'type': 2,
          'title': 'TOPUP E-WALLET',
          'desc': 'BCA',
          'value': 'IDR 300,000',
          'assets': 'assets/icons/plus (1) 1.png'
        }
      ]
    },
    {
      'group_date': 'Selasa, 14 Feb 2023',
      'data': [
        {
          'type': 2,
          'title': 'KALINGGA HERITAGE GUEST HOUSE',
          'desc': 'Kamar Superior Queen',
          'value': 'IDR 2,211,000',
          'assets': ConstHelper.hotelIcon
        },
        {
          'type': 2,
          'title': 'TOPUP E-WALLET',
          'desc': 'BCA',
          'value': 'IDR 300,000',
          'assets': 'assets/icons/plus (1) 1.png'
        }
      ]
    }
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: Column(children: [
      Container(
        padding: EdgeInsets.all(margin16),
        decoration: BoxDecoration(
            border:
                Border(bottom: BorderSide(color: neutral30.withOpacity(0.3)))),
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
            SizedBox(width: margin24 / 2),
            Text(
              'Riwayat Transaksi',
              style: mainFont.copyWith(
                  fontSize: 15, color: neutral100, fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
      Expanded(
          child: ListView(
        padding: EdgeInsets.symmetric(horizontal: margin16),
        children: List.generate(dataHistory.length, (index) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: margin16,
              ),
              Text(
                dataHistory[index]['group_date'],
                style: mainFont.copyWith(
                    fontSize: 13,
                    color: neutral30,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: margin24 / 2,
              ),
              Column(
                children:
                    List.generate(dataHistory[index]['data'].length, (index2) {
                  return Stack(
                    children: [
                      Container(
                        margin: EdgeInsets.only(bottom: margin24 / 2),
                        padding: EdgeInsets.symmetric(
                            horizontal: margin16, vertical: margin16),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                                color: neutral30.withOpacity(0.3), width: 0.5)),
                        child: IntrinsicHeight(
                          child: Row(
                            children: [
                              Container(
                                width: 32,
                                height: 32,
                                decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Color(0xffF4F4F4)),
                                alignment: Alignment.center,
                                child: SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: Image.asset(dataHistory[index]['data']
                                      [index2]['assets']),
                                ),
                              ),
                              SizedBox(
                                width: margin24 / 2,
                              ),
                              Expanded(
                                  child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    dataHistory[index]['data'][index2]['title'],
                                    style: mainFont.copyWith(
                                        fontSize: 12,
                                        color: Colors.black87,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    dataHistory[index]['data'][index2]['desc'],
                                    style: mainFont.copyWith(
                                        fontSize: 11, color: neutral30),
                                  )
                                ],
                              )),
                              SizedBox(
                                width: margin24 / 2,
                              ),
                              Container(
                                  alignment: Alignment.topRight,
                                  child: Text(
                                    (dataHistory[index]['data'][index2]
                                                    ['type'] ==
                                                1
                                            ? '- '
                                            : '+ ') +
                                        dataHistory[index]['data'][index2]
                                            ['value'],
                                    style: mainFont.copyWith(
                                        fontSize: 12,
                                        color: dataHistory[index]['data']
                                                    [index2]['type'] ==
                                                1
                                            ? Colors.red
                                            : Colors.green,
                                        fontWeight: FontWeight.bold),
                                  ))
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        top: 0,
                        right: 0,
                        child: SizedBox(
                          width: 30,
                          height: 30,
                          child: Image.asset(
                            dataHistory[index]['data'][index2]['type'] == 1
                                ? ConstHelper.redElips
                                : ConstHelper.greenElips,
                            fit: BoxFit.cover,
                          ),
                        ),
                      )
                    ],
                  );
                }),
              )
            ],
          );
        }),
      ))
    ])));
  }
}
