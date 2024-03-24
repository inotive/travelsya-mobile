import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:travelsya/app/rekreasi/pages/rekreasi_checkout_page.dart';
import 'package:travelsya/shared/styles/font_style.dart';
import 'package:travelsya/shared/styles/theme_style.dart';

class RekreasiPackageSection extends StatelessWidget {
  const RekreasiPackageSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.only(top: 5.0.w, left: 5.0.w, right: 5.0.w),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Paket Tersedia',
                    style: mainFont.copyWith(
                        fontSize: 12.0.sp,
                        color: Colors.black87,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Lihat Semua',
                    style: mainFont.copyWith(
                        fontSize: 11.0.sp,
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ],
          ),
        ),
        SizedBox(
          height: 5.0.w,
        ),
        Container(
            padding: EdgeInsets.symmetric(horizontal: 5.0.w),
            child: Column(
              children: List.generate(5, (index) {
                return Container(
                  padding: EdgeInsets.all(5.0.w),
                  margin: EdgeInsets.only(bottom: 3.0.w),
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: neutral30.withOpacity(0.3))),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                            fontSize: 9.0.sp, color: neutral30),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 3.0.w),
                        width: double.infinity,
                        height: 1,
                        color: neutral30.withOpacity(0.3),
                      ),
                      Row(
                        children: [
                          Expanded(
                              child: Column(
                            children: [
                              SizedBox(
                                width: double.infinity,
                                child: RichText(
                                    text: TextSpan(
                                        style: mainFont.copyWith(
                                            fontSize: 10.0.sp,
                                            color: neutral30),
                                        children: [
                                      const TextSpan(text: 'mulai '),
                                      const TextSpan(
                                          text: '1,750,000',
                                          style: TextStyle(
                                              decoration:
                                                  TextDecoration.lineThrough)),
                                      TextSpan(
                                          text: ' IDR 200,500',
                                          style: TextStyle(
                                              fontSize: 12.0.sp,
                                              fontWeight: FontWeight.bold,
                                              color: Theme.of(context)
                                                  .primaryColor)),
                                    ])),
                              ),
                              SizedBox(
                                width: double.infinity,
                                child: Text(
                                  '/orang (termasuk pajak)',
                                  style: mainFont.copyWith(
                                      fontSize: 9.0.sp, color: neutral30),
                                ),
                              )
                            ],
                          )),
                          SizedBox(
                            width: 3.0.w,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) =>
                                          const RekreasiCheckokutPage()));
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 3.0.w, horizontal: 5.0.w),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Theme.of(context).primaryColor,
                              ),
                              child: Text(
                                'Pesan',
                                style: mainFont.copyWith(
                                    fontSize: 11.0.sp,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                );
              }),
            )),
        SizedBox(
          height: 2.0.w,
        ),
        Container(
          width: double.infinity,
          height: 2.0.w,
          color: const Color(0xfff4f4f4),
        ),
      ],
    );
  }
}
