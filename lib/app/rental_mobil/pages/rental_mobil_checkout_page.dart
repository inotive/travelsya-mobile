import 'package:flutter/material.dart';
import 'package:travelsya/shared/styles/font_style.dart';
import 'package:travelsya/shared/styles/size_styles.dart';
import 'package:travelsya/shared/styles/theme_style.dart';
import 'package:travelsya/shared/widgets/form_helper.dart';
import 'package:travelsya/shared/widgets/form_helper/elevated_button_widget.dart';
import 'package:travelsya/shared/widgets/form_helper/rounded_texfield_widget.dart';
import 'package:travelsya/shared/widgets/form_helper/title_with_widget.dart';

class RentalCheckoutPage extends StatelessWidget {
  const RentalCheckoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            Container(
              padding: EdgeInsets.all(margin16),
              color: Theme.of(context).primaryColor,
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    width: margin24 / 2,
                  ),
                  Text(
                    'Informasi Pemesanan',
                    style: mainBody3.copyWith(
                        color: Colors.white, fontWeight: FontWeight.w700),
                  )
                ],
              ),
            ),
            Expanded(
                child: ListView(
              children: [
                Container(
                  padding: EdgeInsets.all(margin16),
                  color: neutral10,
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          Positioned(
                            top: 0,
                            bottom: 0,
                            left: 0,
                            right: 0,
                            child: Container(
                              width: double.infinity,
                              height: double.infinity,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: neutral50.withOpacity(0.3)),
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white),
                              alignment: Alignment.topRight,
                              child: SizedBox(
                                width: 45,
                                height: 45,
                                child: Image.asset(
                                  'assets/icons/Group 23.png',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(margin16),
                            width: double.infinity,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Detail Mobil dan Vendor',
                                  style: mainBody4.copyWith(
                                      color: neutral100,
                                      fontWeight: FontWeight.bold),
                                ),
                                Container(
                                  margin: EdgeInsets.symmetric(
                                      vertical: margin24 / 2),
                                  width: double.infinity,
                                  height: 1,
                                  color: neutral50.withOpacity(0.3),
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                        child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        RichText(
                                            text: TextSpan(children: [
                                          TextSpan(
                                              text: 'SIGMA RENT CAR',
                                              style: mainBody5.copyWith(
                                                  color: neutral100,
                                                  fontWeight: FontWeight.bold)),
                                          TextSpan(
                                              text: ' - Lepas Kunci',
                                              style: mainBody5.copyWith(
                                                  color: neutral50,
                                                  fontStyle: FontStyle.italic))
                                        ])),
                                        Text(
                                          'Toyota Grand New Avanza',
                                          style: mainBody5.copyWith(
                                              color: neutral100),
                                        ),
                                        SizedBox(
                                          height: margin8,
                                        ),
                                        Row(
                                          children: [
                                            SizedBox(
                                                width: margin16,
                                                height: margin16,
                                                child: Image.asset(
                                                    'assets/icons/users.png')),
                                            SizedBox(
                                              width: margin4,
                                            ),
                                            Text(
                                              '6 Orang',
                                              style: mainBody5.copyWith(
                                                  color: neutral50),
                                            ),
                                            SizedBox(
                                              width: margin24 / 2,
                                            ),
                                            SizedBox(
                                                width: margin16,
                                                height: margin16,
                                                child: Image.asset(
                                                    'assets/icons/users.png')),
                                            SizedBox(
                                              width: margin4,
                                            ),
                                            Text(
                                              'Otomatis',
                                              style: mainBody5.copyWith(
                                                  color: neutral50),
                                            )
                                          ],
                                        ),
                                        SizedBox(
                                          height: margin24 / 2,
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              'IDR 218,999',
                                              style: mainBody4.copyWith(
                                                  color: Theme.of(context)
                                                      .primaryColor,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text(
                                              ' /hari',
                                              style: mainBody5.copyWith(
                                                  color: neutral50),
                                            )
                                          ],
                                        )
                                      ],
                                    )),
                                    SizedBox(
                                      width: margin24 / 2,
                                    ),
                                    SizedBox(
                                        width: 45,
                                        height: 45,
                                        child: Image.asset(
                                            'assets/images/xenia miring depan 1.png'))
                                  ],
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: margin16,
                      ),
                      Stack(
                        children: [
                          Positioned(
                            top: 0,
                            bottom: 0,
                            left: 0,
                            right: 0,
                            child: Container(
                              width: double.infinity,
                              height: double.infinity,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: neutral50.withOpacity(0.3)),
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white),
                              alignment: Alignment.topRight,
                              child: SizedBox(
                                width: 45,
                                height: 45,
                                child: Image.asset(
                                  'assets/icons/Group 23.png',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(margin16),
                            width: double.infinity,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Waktu Sewa',
                                  style: mainBody5.copyWith(
                                      color: neutral100,
                                      fontWeight: FontWeight.bold),
                                ),
                                Container(
                                  margin: EdgeInsets.symmetric(
                                      vertical: margin24 / 2),
                                  width: double.infinity,
                                  height: 1,
                                  color: neutral50.withOpacity(0.3),
                                ),
                                Row(
                                  children: [
                                    Flexible(
                                      flex: 1,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Tanggal Jemput',
                                            style: mainBody5.copyWith(
                                                color: neutral50),
                                          ),
                                          Text(
                                            'Minggu, 20 Feb 2023',
                                            style: mainBody4.copyWith(
                                                color: neutral100,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            '06:00 AM',
                                            style: mainBody4.copyWith(
                                                color: neutral100),
                                          )
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: margin16,
                                    ),
                                    Flexible(
                                      flex: 1,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Tanggal Jemput',
                                            style: mainBody5.copyWith(
                                                color: neutral50),
                                          ),
                                          Text(
                                            'Minggu, 20 Feb 2023',
                                            style: mainBody4.copyWith(
                                                color: neutral100,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            '06:00 AM',
                                            style: mainBody4.copyWith(
                                                color: neutral100),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  margin: EdgeInsets.symmetric(
                                      vertical: margin24 / 2),
                                  width: double.infinity,
                                  height: 1,
                                  color: neutral50.withOpacity(0.3),
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                        child: Text(
                                      'Bisa refund, reschedule dan overtime',
                                      style: mainBody5.copyWith(
                                          fontWeight: FontWeight.bold,
                                          color:
                                              Theme.of(context).primaryColor),
                                    )),
                                    SizedBox(
                                      width: margin24 / 2,
                                    ),
                                    Icon(
                                      Icons.arrow_forward_ios_rounded,
                                      color: neutral100,
                                      size: 15,
                                    )
                                  ],
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: margin16,
                      ),
                      Stack(
                        children: [
                          Positioned(
                            top: 0,
                            bottom: 0,
                            left: 0,
                            right: 0,
                            child: Container(
                              width: double.infinity,
                              height: double.infinity,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: neutral50.withOpacity(0.3)),
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white),
                              alignment: Alignment.topRight,
                              child: SizedBox(
                                width: 45,
                                height: 45,
                                child: Image.asset(
                                  'assets/icons/Group 23.png',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(margin16),
                            width: double.infinity,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Area Sewa',
                                  style: mainBody5.copyWith(
                                      color: neutral100,
                                      fontWeight: FontWeight.bold),
                                ),
                                Container(
                                  margin: EdgeInsets.symmetric(
                                      vertical: margin24 / 2),
                                  width: double.infinity,
                                  height: 1,
                                  color: neutral50.withOpacity(0.3),
                                ),
                                Text(
                                  'Jakarta',
                                  style: mainBody4.copyWith(
                                      color: neutral100,
                                      fontWeight: FontWeight.bold),
                                ),
                                Container(
                                  margin: EdgeInsets.symmetric(
                                      vertical: margin24 / 2),
                                  width: double.infinity,
                                  height: 1,
                                  color: neutral50.withOpacity(0.3),
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                        child: Text(
                                      'Lihat Cakupan Area',
                                      style: mainBody5.copyWith(
                                          fontWeight: FontWeight.bold,
                                          color:
                                              Theme.of(context).primaryColor),
                                    )),
                                    SizedBox(
                                      width: margin24 / 2,
                                    ),
                                    Icon(
                                      Icons.arrow_forward_ios_rounded,
                                      color: neutral100,
                                      size: 15,
                                    )
                                  ],
                                )
                              ],
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(margin16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Detail Pemesan',
                        style: mainBody3.copyWith(
                            color: neutral100, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: margin16,
                      ),
                      FormHelper.optionsCircle(context,
                          title: 'Sama dengan pemilik akun',
                          onTap: () {},
                          status: true),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: margin24 / 2),
                        width: double.infinity,
                        height: 1,
                        color: neutral50.withOpacity(0.3),
                      ),
                      Row(
                        children: [
                          FormHelper.optionsCircle(context,
                              title: 'Tuan', onTap: () {}, status: false),
                          SizedBox(
                            width: margin24 / 2,
                          ),
                          FormHelper.optionsCircle(context,
                              title: 'Nyonya', onTap: () {}, status: false),
                        ],
                      ),
                      SizedBox(
                        height: margin16,
                      ),
                      TitleWithWidget(
                          title: 'Nama Lengkap',
                          child: RoundedTextfield(
                              hintText: 'Masukkan nama lengkap Anda',
                              controller: TextEditingController())),
                      SizedBox(
                        height: margin4,
                      ),
                      Text(
                        'Seperti di KTP/SIM/Paspor.',
                        style: mainBody5.copyWith(color: neutral50),
                      ),
                      SizedBox(
                        height: margin16,
                      ),
                      TitleWithWidget(
                          title: 'Nomor Handphone',
                          child: RoundedTextfield(
                              prefixIcon: Center(
                                widthFactor: 1,
                                child: Text(
                                  '+62',
                                  style:
                                      mainBody4.copyWith(color: Colors.black87),
                                ),
                              ),
                              controller: TextEditingController())),
                      SizedBox(
                        height: margin16,
                      ),
                      TitleWithWidget(
                          title: 'Email',
                          child: RoundedTextfield(
                              hintText: 'Masukkan email Anda',
                              controller: TextEditingController())),
                    ],
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: margin8,
                  color: neutral10,
                ),
                Container(
                  padding: EdgeInsets.all(margin16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Metode Pembayaran',
                        style: mainBody3.copyWith(
                            color: neutral100, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: margin16,
                      ),
                      Row(
                        children: [
                          Expanded(
                              child: FormHelper.optionsCircle(context,
                                  title: 'Travelsya Pay',
                                  isBold: true,
                                  onTap: () {},
                                  status: true,
                                  customDetailWidget: Text(
                                    'Balance : Rp32,456',
                                    style:
                                        mainBody5.copyWith(color: neutral100),
                                  ))),
                          SizedBox(
                            width: margin24 / 2,
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                                vertical: margin8, horizontal: margin24 / 2),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: const Color(0xffffeef1)),
                            child: Text(
                              'Topup',
                              style: mainBody5.copyWith(
                                  color: Theme.of(context).primaryColor,
                                  fontWeight: FontWeight.bold),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: margin24 / 2,
                      ),
                      FormHelper.optionsCircle(context,
                          title: 'Metode Pembayaran Lain',
                          onTap: () {},
                          status: false)
                    ],
                  ),
                ),
                SizedBox(
                  height: margin32,
                )
              ],
            )),
            Container(
              padding: EdgeInsets.all(margin16),
              decoration: BoxDecoration(
                  border: Border(
                      top: BorderSide(color: neutral50.withOpacity(0.3)))),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total Biaya',
                        style: mainBody4.copyWith(color: neutral100),
                      ),
                      Text(
                        'IDR 1,561,000',
                        style: mainBody3.copyWith(
                            color: neutral100, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  SizedBox(
                    height: margin24 / 2,
                  ),
                  ElevatedButtonWidget(
                      enabled: true,
                      onTap: () {},
                      title: 'Lanjutkan ke Pembayaran')
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
