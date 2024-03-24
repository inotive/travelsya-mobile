import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:travelsya/app/plane/pages/plane_detail_page.dart';
import 'package:travelsya/shared/helper/const_helper.dart';
import 'package:travelsya/shared/styles/font_style.dart';
import 'package:travelsya/shared/styles/theme_style.dart';
import 'package:travelsya/shared/widgets/form_helper.dart';

class PlaneSearchPage extends StatelessWidget {
  const PlaneSearchPage({Key? key}) : super(key: key);

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
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage(
                          'assets/images/edvin-johansson-rlwE8f8anOc-unsplash 1 (4).png'))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Pesawat',
                    style: mainFont.copyWith(
                        fontSize: 15.0.sp,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Pesan tiket pesawat domestik dan\ninternasional',
                    textAlign: TextAlign.center,
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FormHelper.dropdownForm(context,
                            data: 'Surabaya (SUBC)', hintText: 'Kota Asal'),
                        SizedBox(
                          height: 2.0.w,
                        ),
                        Text(
                          'Kota Asal',
                          style: mainFont.copyWith(
                              fontSize: 9.0.sp, color: neutral30),
                        ),
                        SizedBox(
                          height: 3.0.w,
                        ),
                        FormHelper.dropdownForm(context,
                            data: 'Jakarta (JKTC)', hintText: 'Kota Tujuan'),
                        SizedBox(
                          height: 2.0.w,
                        ),
                        Text(
                          'Kota Tujuan',
                          style: mainFont.copyWith(
                              fontSize: 9.0.sp, color: neutral30),
                        ),
                        SizedBox(
                          height: 3.0.w,
                        ),
                        FormHelper.dropdownForm(context,
                            customIcons: Icons.date_range,
                            data: '12 Feb 2023',
                            hintText: 'Tanggal Keberangkatan'),
                        SizedBox(
                          height: 2.0.w,
                        ),
                        Text(
                          'Tanggal Keberangkatan',
                          style: mainFont.copyWith(
                              fontSize: 9.0.sp, color: neutral30),
                        ),
                        SizedBox(
                          height: 3.0.w,
                        ),
                        Row(
                          children: [
                            SizedBox(
                                width: 7.0.w,
                                height: 7.0.w,
                                child: Checkbox(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(4)),
                                    value: false,
                                    onChanged: (value) {})),
                            SizedBox(
                              width: 1.0.w,
                            ),
                            Text(
                              'Pulang pergi?',
                              style: mainFont.copyWith(
                                  fontSize: 10.0.sp, color: neutral100),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 3.0.w,
                        ),
                        Row(
                          children: [
                            Flexible(
                              flex: 1,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  FormHelper.dropdownForm(context,
                                      data: '1 Penumpang',
                                      hintText: 'Jumlah Penumpang'),
                                  SizedBox(
                                    height: 1.0.w,
                                  ),
                                  Text(
                                    'Kelas',
                                    style: mainFont.copyWith(
                                        fontSize: 9.0.sp, color: neutral30),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 3.0.w,
                            ),
                            Flexible(
                              flex: 1,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  FormHelper.dropdownForm(context,
                                      data: 'Ekonomi', hintText: 'Kelas'),
                                  SizedBox(
                                    height: 1.0.w,
                                  ),
                                  Text(
                                    'Kelas',
                                    style: mainFont.copyWith(
                                        fontSize: 9.0.sp, color: neutral30),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5.0.w,
                        ),
                        FormHelper.elevatedButtonBasic(context, enabled: true,
                            onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => const PlaneDetailPage()));
                        }, title: 'Cari Tiket')
                      ],
                    ),
                  ),
                  Column(
                    children: List.generate(2, (index) {
                      return Container(
                        padding: EdgeInsets.symmetric(horizontal: 5.0.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 10.0.w,
                            ),
                            Text(
                              index == 0
                                  ? 'Domestik Populer'
                                  : 'Trip Internasional',
                              style: mainFont.copyWith(
                                  fontSize: 14.0.sp,
                                  color: Colors.black87,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              index == 0
                                  ? 'Pilihan rute dalam negri dengan harga terbaik'
                                  : 'Berbagai pilihan murah untuk liburan di luar negri',
                              style: mainFont.copyWith(
                                fontSize: 10.0.sp,
                                color: Colors.black87,
                              ),
                            ),
                            SizedBox(
                              height: 5.0.w,
                            ),
                            SizedBox(
                              width: double.infinity,
                              child: Wrap(
                                alignment: WrapAlignment.spaceBetween,
                                children: List.generate(4, (index) {
                                  return FractionallySizedBox(
                                    widthFactor: 0.49,
                                    child: GestureDetector(
                                      onTap: () {
                                        // Navigator.push(
                                        //     context,
                                        //     MaterialPageRoute(
                                        //         builder: (_) =>
                                        //             HotelDetailPage()));
                                      },
                                      child: Card(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(8)),
                                        child: Column(
                                          children: [
                                            AspectRatio(
                                              aspectRatio: 167 / 100,
                                              child: Container(
                                                width: double.infinity,
                                                height: double.infinity,
                                                decoration: const BoxDecoration(
                                                    image: DecorationImage(
                                                        fit: BoxFit.cover,
                                                        image: AssetImage(
                                                            ConstHelper
                                                                .helperPhoto)),
                                                    borderRadius:
                                                        BorderRadius.only(
                                                            topLeft: Radius
                                                                .circular(8),
                                                            topRight:
                                                                Radius.circular(
                                                                    8)),
                                                    color: Colors.blue),
                                              ),
                                            ),
                                            Container(
                                              padding: EdgeInsets.all(3.0.w),
                                              width: double.infinity,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'Sekali Jalan',
                                                    style: mainFont.copyWith(
                                                        fontSize: 9.0.sp,
                                                        color: const Color(
                                                            0xffa5a5a5)),
                                                  ),
                                                  Row(
                                                    children: [
                                                      Text(
                                                        'Jakarta ',
                                                        maxLines: 2,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style:
                                                            mainFont.copyWith(
                                                                fontSize:
                                                                    11.0.sp,
                                                                color: Colors
                                                                    .black87,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                      ),
                                                      Icon(
                                                        Icons.arrow_forward,
                                                        size: 4.0.w,
                                                        color: neutral100,
                                                      ),
                                                      Text(
                                                        ' Bali',
                                                        maxLines: 2,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style:
                                                            mainFont.copyWith(
                                                                fontSize:
                                                                    11.0.sp,
                                                                color: Colors
                                                                    .black87,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                      ),
                                                    ],
                                                  ),
                                                  Text(
                                                    '14 Feb 2023',
                                                    style: mainFont.copyWith(
                                                        fontSize: 8.0.sp,
                                                        color: const Color(
                                                            0xffa5a5a5)),
                                                  ),
                                                  SizedBox(
                                                    height: 2.0.w,
                                                  ),
                                                  Text(
                                                    'Citilink | Ekkonomi',
                                                    style: mainFont.copyWith(
                                                        fontSize: 8.0.sp,
                                                        color: neutral100),
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
                            FormHelper.borderButton(context,
                                onTap: () {}, title: 'Lihat Semua')
                          ],
                        ),
                      );
                    }),
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
