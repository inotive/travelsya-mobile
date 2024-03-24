import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:travelsya/shared/helper/const_helper.dart';
import 'package:travelsya/shared/styles/font_style.dart';
import 'package:travelsya/shared/styles/theme_style.dart';

class DetailPointSection extends StatefulWidget {
  const DetailPointSection({Key? key}) : super(key: key);

  @override
  State<DetailPointSection> createState() => _DetailPointSectionState();
}

class _DetailPointSectionState extends State<DetailPointSection> {
  List<Map<String, dynamic>> dataBenefints = [
    {
      'data': 'Dapat gunakan points untuk ditukar dengan diskon',
      'assets': ConstHelper.discountIcon,
      'id': 1
    },
    {
      'data': 'Diskon hingga 10%+ pemesanan hotel',
      'assets': ConstHelper.promoHotelIcon,
      'id': 1
    },
    {
      'data': 'Diskon hingga 15%+ pemesanan hotel',
      'assets': ConstHelper.promoHotelIcon,
      'id': 1
    },
    {
      'data': 'Early access untuk promo baru',
      'assets': ConstHelper.promoIcon,
      'id': 1
    },
    {
      'data': 'Jalur Customer Care khusus',
      'assets': ConstHelper.csPromoIcon,
      'id': 1
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 5.0.w, vertical: 3.0.w),
          width: double.infinity,
          child: Text(
            'Level : Bronze',
            style: mainFont.copyWith(
                fontSize: 12.0.sp,
                color: Colors.black87,
                fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
          child: ListView(
            children: [
              Column(
                children: List.generate(dataBenefints.length, (index) {
                  return Container(
                    padding: EdgeInsets.symmetric(
                        vertical: 4.0.w, horizontal: 5.0.w),
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                                color: neutral30.withOpacity(0.3),
                                width: 0.5))),
                    child: Row(
                      children: [
                        SizedBox(
                            width: 10.0.w,
                            height: 10.0.w,
                            child: Image.asset(
                              dataBenefints[index]['assets'],
                              color: index == 0 ? null : neutral30,
                            )),
                        SizedBox(
                          width: 3.0.w,
                        ),
                        Expanded(
                          child: Text(
                            dataBenefints[index]['data'],
                            style: mainFont.copyWith(
                                fontSize: 9.0.sp,
                                color: index == 0 ? Colors.black87 : neutral30,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          width: 3.0.w,
                        ),
                        Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: neutral30,
                          size: 4.0.w,
                        )
                      ],
                    ),
                  );
                }),
              )
            ],
          ),
        ),
      ],
    );
  }
}
