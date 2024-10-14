import 'package:flutter/material.dart';
import 'package:travelsya/app/rekreasi/pages/rekreasi_checkout_page.dart';
import 'package:travelsya/shared/styles/font_style.dart';
import 'package:travelsya/shared/styles/size_styles.dart';
import 'package:travelsya/shared/styles/theme_style.dart';

class HealthPackageSection extends StatelessWidget {
  const HealthPackageSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding:
              EdgeInsets.only(top: margin16, left: margin16, right: margin16),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Paket Tersedia',
                    style: mainBody4.copyWith(
                        color: Colors.black87, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Lihat Semua',
                    style: mainBody4.copyWith(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ],
          ),
        ),
        SizedBox(
          height: margin16,
        ),
        Container(
            padding: EdgeInsets.symmetric(horizontal: margin16),
            child: Column(
              children: List.generate(5, (index) {
                return Container(
                  padding: EdgeInsets.all(margin16),
                  margin: EdgeInsets.only(bottom: margin24 / 2),
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: neutral50.withOpacity(0.3))),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 45,
                            height: 45,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                image: const DecorationImage(
                                    image: AssetImage(
                                        'assets/images/health_illustration.jpeg'),
                                    fit: BoxFit.cover)),
                          ),
                          SizedBox(
                            width: margin24 / 2,
                          ),
                          Expanded(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Doket Gigi',
                                style: mainBody4.copyWith(
                                    color: neutral100,
                                    fontWeight: FontWeight.bold),
                              ),
                              Row(
                                children: [
                                  SizedBox(
                                    width: 16,
                                    height: 16,
                                    child:
                                        Image.asset('assets/icons/profile.png'),
                                  ),
                                  SizedBox(
                                    width: margin8,
                                  ),
                                  Expanded(
                                      child: Text(
                                    'dr. Joko Susilo',
                                    style: mainBody4,
                                  ))
                                ],
                              )
                            ],
                          ))
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: margin24 / 2),
                        width: double.infinity,
                        height: 1,
                        color: neutral50.withOpacity(0.3),
                      ),
                      Row(
                        children: [
                          Expanded(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: double.infinity,
                                child: RichText(
                                    text: TextSpan(
                                        style: mainBody5.copyWith(
                                            color: neutral50),
                                        children: [
                                      const TextSpan(text: 'mulai '),
                                      const TextSpan(
                                          text: '1,750,000',
                                          style: TextStyle(
                                              decoration:
                                                  TextDecoration.lineThrough)),
                                      TextSpan(
                                          text: ' IDR 200,500',
                                          style: mainBody4.copyWith(
                                              fontWeight: FontWeight.bold,
                                              color: Theme.of(context)
                                                  .primaryColor)),
                                    ])),
                              ),
                              Text(
                                '* Termasuk Pajak\n * Tidak bisa refund dan reschedule',
                                style: mainBody5.copyWith(
                                    fontSize: 8,
                                    color: Theme.of(context).primaryColor),
                              )
                            ],
                          )),
                          SizedBox(
                            width: margin24 / 2,
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
                                  vertical: margin24 / 2, horizontal: margin16),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Theme.of(context).primaryColor,
                              ),
                              child: Text(
                                'Pesan',
                                style: mainBody4.copyWith(
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
          height: margin8,
        ),
        Container(
          width: double.infinity,
          height: margin8,
          color: const Color(0xfff4f4f4),
        ),
      ],
    );
  }
}
