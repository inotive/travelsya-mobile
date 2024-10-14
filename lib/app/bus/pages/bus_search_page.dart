import 'package:flutter/material.dart';
import 'package:travelsya/app/bus/pages/bus_detail_page.dart';
import 'package:travelsya/shared/styles/font_style.dart';
import 'package:travelsya/shared/styles/size_styles.dart';
import 'package:travelsya/shared/styles/theme_style.dart';
import 'package:travelsya/shared/widgets/form_helper.dart';
import 'package:travelsya/shared/widgets/form_helper/elevated_button_widget.dart';

class BusSearchPage extends StatelessWidget {
  const BusSearchPage({super.key});

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
              width: double.infinity,
              height: 200,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage(
                          'assets/images/edvin-johansson-rlwE8f8anOc-unsplash 1 (2).png'))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Bus & Travel',
                    style: mainBody3.copyWith(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Lebih hemat dengan kendaraan umum',
                    textAlign: TextAlign.center,
                    style: mainBody4.copyWith(
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: margin24)
                ],
              ),
            ),
          ),
          Positioned(
            left: margin16,
            top: MediaQuery.of(context).padding.top + margin16,
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                width: 45,
                height: 45,
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
            top: 180,
            left: 0,
            right: 0,
            child: Container(
              width: double.infinity,
              height: double.infinity,
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(24),
                      topRight: Radius.circular(24))),
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  SizedBox(
                    height: margin16,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: margin16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FormHelper.dropdownForm(context,
                            data: 'Surabaya (SUBC)', hintText: 'Kota Asal'),
                        SizedBox(
                          height: margin8,
                        ),
                        Text(
                          'Stasiun Asal',
                          style: mainBody5.copyWith(color: neutral50),
                        ),
                        SizedBox(
                          height: margin24 / 2,
                        ),
                        FormHelper.dropdownForm(context,
                            data: 'Jakarta (JKTC)', hintText: 'Kota Tujuan'),
                        SizedBox(
                          height: margin8,
                        ),
                        Text(
                          'Stasiun Tujuan',
                          style: mainBody5.copyWith(color: neutral50),
                        ),
                        SizedBox(
                          height: margin24 / 2,
                        ),
                        FormHelper.dropdownForm(context,
                            customIcons: Icons.date_range,
                            data: '12 Feb 2023',
                            hintText: 'Tanggal Keberangkatan'),
                        SizedBox(
                          height: margin8,
                        ),
                        Text(
                          'Tanggal Keberangkatan',
                          style: mainBody5.copyWith(color: neutral50),
                        ),
                        SizedBox(
                          height: margin24 / 2,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  FormHelper.dropdownForm(context,
                                      data: '1 Penumpang',
                                      hintText: 'Jumlah Penumpang'),
                                  SizedBox(
                                    height: margin8,
                                  ),
                                  Text(
                                    'Jumlah Penumpang',
                                    style: mainBody5.copyWith(color: neutral50),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: margin24 / 2,
                            ),
                            Row(
                              children: [
                                SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: Checkbox(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(4)),
                                        value: false,
                                        onChanged: (value) {})),
                                SizedBox(
                                  width: margin4,
                                ),
                                Text(
                                  'Pulang pergi?',
                                  style: mainBody4.copyWith(color: neutral100),
                                )
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: margin16,
                        ),
                        ElevatedButtonWidget(
                            enabled: true,
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => const BusDetailPage()));
                            },
                            title: 'Cari Tiket')
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(margin16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Info Terbaru COVID-19!',
                          style: mainBody4.copyWith(
                              color: neutral100, fontWeight: FontWeight.bold),
                        ),
                        RichText(
                            text: TextSpan(
                                style: mainBody5.copyWith(color: neutral100),
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
                    height: margin32,
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
