import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:travelsya/app/rekreasi/pages/rekreasi_detail_page.dart';
import 'package:travelsya/shared/helper/const_helper.dart';
import 'package:travelsya/shared/styles/font_style.dart';
import 'package:travelsya/shared/widgets/form_helper.dart';

class RekreasiSearchPage extends StatefulWidget {
  const RekreasiSearchPage({Key? key}) : super(key: key);

  @override
  State<RekreasiSearchPage> createState() => _RekreasiSearchPageState();
}

class _RekreasiSearchPageState extends State<RekreasiSearchPage> {
  List<String> dataFilter = [
    'Atraksi',
    'Spa & Kecantikan',
    'Event',
    'Arena Bermain'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            alignment: Alignment.topCenter,
            child: Container(
              width: 100.0.w,
              height: 30.0.h,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage(
                          'assets/images/edvin-johansson-rlwE8f8anOc-unsplash 1 (1).png'))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Rekreasi',
                    style: mainFont.copyWith(
                        fontSize: 15.0.sp,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Cari aktivitas dan atraksi menyenangkan',
                    style: mainFont.copyWith(
                      fontSize: 11.0.sp,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    height: 2.0.h,
                  )
                ],
              ),
            ),
          ),
          Positioned(
            left: 3.0.w,
            top: 9.0.w,
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                width: 10.0.w,
                height: 10.0.w,
                decoration: const BoxDecoration(
                    shape: BoxShape.circle, color: Colors.white),
                child: Icon(
                  Icons.arrow_back,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            child: Container(
              width: 100.0.w,
              height: 75.0.h,
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(24),
                      topRight: Radius.circular(24))),
              child: ListView(
                children: [
                  SizedBox(
                    height: 5.0.w,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 5.0.w),
                    child: Column(
                      children: [
                        FormHelper.dropdownForm(context,
                            hintText: 'Cari Aktivitas',
                            customIcons: Icons.search),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 5.0.w,
                  ),
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 5.0.w),
                          child: Text(
                            'Apa yang ingin kamu lakukan?',
                            style: mainFont.copyWith(
                                fontSize: 13.0.sp,
                                color: Colors.black87,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          height: 3.0.w,
                        ),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: List.generate(dataFilter.length, (index) {
                              return Container(
                                margin: EdgeInsets.only(
                                    left: index == 0 ? 5.0.w : 1.0.w,
                                    right: index == 9 ? 5.0.w : 0),
                                padding: EdgeInsets.symmetric(
                                    vertical: 1.0.w, horizontal: 5.0.w),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: index == 0
                                        ? Color(0xffFFEEF1)
                                        : Colors.transparent,
                                    border: Border.all(
                                        color: index == 0
                                            ? Theme.of(context).primaryColor
                                            : Color(0xffA5A5A5))),
                                child: Text(
                                  dataFilter[index],
                                  style: mainFont.copyWith(
                                      fontSize: 10.0.sp,
                                      color: index == 0
                                          ? Theme.of(context).primaryColor
                                          : Color(0xffA5A5A5)),
                                ),
                              );
                            }),
                          ),
                        ),
                        SizedBox(
                          height: 5.0.w,
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 5.0.w),
                          width: double.infinity,
                          child: Wrap(
                            alignment: WrapAlignment.spaceBetween,
                            children: List.generate(4, (index) {
                              return FractionallySizedBox(
                                widthFactor: 0.49,
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) =>
                                                RekreasiDetailPage()));
                                  },
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8)),
                                    child: Column(
                                      children: [
                                        AspectRatio(
                                          aspectRatio: 167 / 100,
                                          child: Container(
                                            width: double.infinity,
                                            height: double.infinity,
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.only(
                                                    topLeft: Radius.circular(8),
                                                    topRight:
                                                        Radius.circular(8)),
                                                image: DecorationImage(
                                                    fit: BoxFit.cover,
                                                    image: AssetImage(
                                                        ConstHelper
                                                            .helperPhoto))),
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.all(3.0.w),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Martha Tilaar Salon & Day Spa',
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                style: mainFont.copyWith(
                                                    fontSize: 11.0.sp,
                                                    color: Colors.black87,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Text(
                                                'Jakarta Utara',
                                                style: mainFont.copyWith(
                                                    fontSize: 8.0.sp,
                                                    color: Color(0xffa5a5a5)),
                                              ),
                                              SizedBox(
                                                height: 2.0.w,
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    'mulai dari ',
                                                    style: mainFont.copyWith(
                                                        fontSize: 8.0.sp,
                                                        color:
                                                            Color(0xffa5a5a5)),
                                                  ),
                                                  Text(
                                                    '500.000',
                                                    style: mainFont.copyWith(
                                                        fontSize: 8.0.sp,
                                                        decoration:
                                                            TextDecoration
                                                                .lineThrough,
                                                        color:
                                                            Color(0xffa5a5a5)),
                                                  )
                                                ],
                                              ),
                                              Text(
                                                'IDR 400,500',
                                                style: mainFont.copyWith(
                                                    fontSize: 12.0.sp,
                                                    color: Theme.of(context)
                                                        .primaryColor,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              SizedBox(
                                                height: 2.0.w,
                                              ),
                                              Row(
                                                children: [
                                                  Icon(
                                                    Icons.star,
                                                    color: Theme.of(context)
                                                        .primaryColor,
                                                  ),
                                                  SizedBox(
                                                    width: 1.0.w,
                                                  ),
                                                  Text(
                                                    '4,8 ',
                                                    style: mainFont.copyWith(
                                                        fontSize: 11.0.sp,
                                                        color: Colors.black87,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  Text(
                                                    '(120)',
                                                    style: mainFont.copyWith(
                                                      fontSize: 8.0.sp,
                                                      color: Color(0xffa5a5a5),
                                                    ),
                                                  )
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }),
                          ),
                        ),
                        SizedBox(
                          height: 5.0.w,
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 5.0.w),
                          child: FormHelper.borderButton(context,
                              onTap: () {}, title: 'Lihat Semua'),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10.0.w,
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
