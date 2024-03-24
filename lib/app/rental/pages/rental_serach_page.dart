import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:travelsya/app/rental/pages/rental_detail_page.dart';
import 'package:travelsya/shared/styles/font_style.dart';
import 'package:travelsya/shared/styles/theme_style.dart';
import 'package:travelsya/shared/widgets/form_helper.dart';

class RentalSearchPage extends StatelessWidget {
  const RentalSearchPage({Key? key}) : super(key: key);

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
                          'assets/images/edvin-johansson-rlwE8f8anOc-unsplash 1.png'))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Rental Mobil',
                    style: mainFont.copyWith(
                        fontSize: 15.0.sp,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Tingkatkan mobilitasmu selama liburan',
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
                            data: 'Jakarta', hintText: 'Area Rental'),
                        SizedBox(
                          height: 2.0.w,
                        ),
                        Text(
                          'Area Rental',
                          style: mainFont.copyWith(
                              fontSize: 9.0.sp, color: neutral30),
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
                                      data: '12 Feb 2023',
                                      customIcons: Icons.date_range,
                                      hintText: 'Tanggal Rental'),
                                  SizedBox(
                                    height: 2.0.w,
                                  ),
                                  Text(
                                    'Tanggal Rental',
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
                                      customIcons: Icons.watch_later_outlined,
                                      data: '08:00',
                                      hintText: 'Jam Pengambilan'),
                                  SizedBox(
                                    height: 2.0.w,
                                  ),
                                  Text(
                                    'Jam Pengambilan',
                                    style: mainFont.copyWith(
                                        fontSize: 9.0.sp, color: neutral30),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 3.0.w,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  FormHelper.dropdownForm(context,
                                      data: '1 Hari (24 Jam)', hintText: ''),
                                  SizedBox(
                                    height: 2.0.w,
                                  ),
                                  Text(
                                    'Durasi Rental',
                                    style: mainFont.copyWith(
                                        fontSize: 9.0.sp, color: neutral30),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 3.0.w,
                            ),
                            Row(
                              children: [
                                SizedBox(
                                    width: 7.0.w,
                                    height: 7.0.w,
                                    child: Checkbox(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(4)),
                                        value: false,
                                        onChanged: (value) {})),
                                SizedBox(
                                  width: 1.0.w,
                                ),
                                Text(
                                  'Dengan Sopir?',
                                  style: mainFont.copyWith(
                                      fontSize: 10.0.sp, color: neutral100),
                                )
                              ],
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
                                  builder: (_) => const RentalDetailPage()));
                        }, title: 'Cari Mobil')
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 5.0.w,
                  ),
                  Container(
                    padding: EdgeInsets.all(5.0.w),
                    margin: EdgeInsets.symmetric(horizontal: 5.0.w),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: neutral10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Info Terbaru COVID-19!',
                          style: mainFont.copyWith(
                              fontSize: 12.0.sp,
                              color: neutral100,
                              fontWeight: FontWeight.bold),
                        ),
                        RichText(
                            text: TextSpan(
                                style: mainFont.copyWith(
                                    fontSize: 10.0.sp, color: neutral100),
                                children: [
                              const TextSpan(
                                text:
                                    'Ikuti perkembangan info, peraturan resmi, dan syarat perjalanan terbaru selama pandemi COVID-19 ',
                              ),
                              TextSpan(
                                  text: 'disini',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context).primaryColor))
                            ]))
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
