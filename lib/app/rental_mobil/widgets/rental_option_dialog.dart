import 'package:flutter/material.dart';
import 'package:travelsya/app/rental_mobil/pages/rental_mobil_checkout_page.dart';
import 'package:travelsya/shared/styles/font_style.dart';
import 'package:travelsya/shared/styles/size_styles.dart';
import 'package:travelsya/shared/styles/theme_style.dart';

class RentalOptionDialog extends StatelessWidget {
  const RentalOptionDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Container(
            width: 200,
            height: 8,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), color: Colors.white),
          ),
        ),
        SizedBox(
          height: margin8,
        ),
        Expanded(
            child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10), topRight: Radius.circular(10)),
              color: Colors.white),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(margin16),
                child: Row(
                  children: [
                    Expanded(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Pilih Vendor',
                          style: mainBody3.copyWith(
                              color: neutral100, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: margin16,
                        ),
                        Text(
                          'Toyota Grand New Avanza',
                          style: mainBody4.copyWith(
                              color: neutral100, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: margin8,
                        ),
                        Row(
                          children: [
                            SizedBox(
                                width: margin16,
                                height: margin16,
                                child: Image.asset('assets/icons/users.png')),
                            SizedBox(
                              width: margin4,
                            ),
                            Text(
                              '6 Orang',
                              style: mainBody5.copyWith(color: neutral50),
                            ),
                            SizedBox(width: margin24 / 2),
                            SizedBox(
                                width: margin16,
                                height: margin16,
                                child: Image.asset('assets/icons/users.png')),
                            SizedBox(
                              width: margin4,
                            ),
                            Text(
                              'Otomatis',
                              style: mainBody5.copyWith(color: neutral50),
                            )
                          ],
                        ),
                      ],
                    )),
                    SizedBox(
                      width: margin24 / 2,
                    ),
                    SizedBox(
                        width: 60,
                        height: 60,
                        child: Image.asset(
                            'assets/images/xenia miring depan 1.png'))
                  ],
                ),
              ),
              Expanded(
                  child: Container(
                width: double.infinity,
                height: double.infinity,
                color: neutral10,
                child: ListView(
                  padding: EdgeInsets.symmetric(horizontal: margin24 / 2),
                  children: List.generate(10, (index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const RentalCheckoutPage()));
                      },
                      child: Container(
                        margin: EdgeInsets.only(
                            top: index == 0 ? margin16 : margin24 / 2),
                        padding: EdgeInsets.all(margin24 / 2),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: neutral40),
                            color: Colors.white),
                        child: Row(
                          children: [
                            Expanded(
                                child: Text(
                              'SIGMA RENT CAR',
                              style: mainBody4.copyWith(
                                  color: neutral100,
                                  fontWeight: FontWeight.bold),
                            )),
                            SizedBox(
                              width: margin8,
                            ),
                            Row(
                              children: [
                                Text(
                                  'IDR 218,999',
                                  style: mainBody4.copyWith(
                                      color: Theme.of(context).primaryColor,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  ' /hari',
                                  style: mainBody5.copyWith(color: neutral50),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  }),
                ),
              ))
            ],
          ),
        )),
      ],
    );
  }
}
