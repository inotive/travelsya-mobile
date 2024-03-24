import 'package:flutter/material.dart';
import 'package:travelsya/shared/helper/const_helper.dart';
import 'package:travelsya/shared/styles/font_style.dart';
import 'package:travelsya/shared/styles/theme_style.dart';
import 'package:sizer/sizer.dart';

class MutasiPage extends StatefulWidget {
  const MutasiPage({Key? key}) : super(key: key);

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
        padding: EdgeInsets.all(5.0.w),
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
            SizedBox(
              width: 3.0.w,
            ),
            Text(
              'Riwayat Transaksi',
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
        padding: EdgeInsets.symmetric(horizontal: 5.0.w),
        children: List.generate(dataHistory.length, (index) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 5.0.w,
              ),
              Text(
                dataHistory[index]['group_date'],
                style: mainFont.copyWith(
                    fontSize: 12.0.sp,
                    color: neutral30,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 3.0.w,
              ),
              Column(
                children:
                    List.generate(dataHistory[index]['data'].length, (index2) {
                  return Stack(
                    children: [
                      Container(
                        margin: EdgeInsets.only(bottom: 3.0.w),
                        padding: EdgeInsets.symmetric(
                            horizontal: 5.0.w, vertical: 4.0.w),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                                color: neutral30.withOpacity(0.3), width: 0.5)),
                        child: IntrinsicHeight(
                          child: Row(
                            children: [
                              Container(
                                width: 10.0.w,
                                height: 10.0.w,
                                decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Color(0xffF4F4F4)),
                                alignment: Alignment.center,
                                child: SizedBox(
                                  width: 6.0.w,
                                  height: 6.0.w,
                                  child: Image.asset(dataHistory[index]['data']
                                      [index2]['assets']),
                                ),
                              ),
                              SizedBox(
                                width: 3.0.w,
                              ),
                              Expanded(
                                  child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    dataHistory[index]['data'][index2]['title'],
                                    style: mainFont.copyWith(
                                        fontSize: 10.0.sp,
                                        color: Colors.black87,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    dataHistory[index]['data'][index2]['desc'],
                                    style: mainFont.copyWith(
                                        fontSize: 8.0.sp, color: neutral30),
                                  )
                                ],
                              )),
                              SizedBox(
                                width: 3.0.w,
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
                                        fontSize: 10.0.sp,
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
                          width: 8.0.w,
                          height: 8.0.w,
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
