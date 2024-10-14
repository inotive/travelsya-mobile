import 'package:flutter/material.dart';
import 'package:travelsya/shared/helper/const_helper.dart';
import 'package:travelsya/shared/styles/font_style.dart';
import 'package:travelsya/shared/styles/size_styles.dart';
import 'package:travelsya/shared/styles/theme_style.dart';

class DetailPointSection extends StatefulWidget {
  const DetailPointSection({super.key});

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
          padding: EdgeInsets.symmetric(
              horizontal: margin16, vertical: margin24 / 2),
          width: double.infinity,
          child: Text(
            'Level : Bronze',
            style: mainFont.copyWith(
                fontSize: 14,
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
                        vertical: margin16, horizontal: margin16),
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                                color: neutral30.withOpacity(0.3),
                                width: 0.5))),
                    child: Row(
                      children: [
                        SizedBox(
                            width: 40,
                            height: 40,
                            child: Image.asset(
                              dataBenefints[index]['assets'],
                              color: index == 0 ? null : neutral30,
                            )),
                        SizedBox(
                          width: margin24 / 2,
                        ),
                        Expanded(
                          child: Text(
                            dataBenefints[index]['data'],
                            style: mainFont.copyWith(
                                fontSize: 11,
                                color: index == 0 ? Colors.black87 : neutral30,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          width: margin24 / 2,
                        ),
                        Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: neutral30,
                          size: 12,
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
