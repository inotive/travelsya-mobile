import 'package:flutter/material.dart';
import 'package:travelsya/shared/styles/font_style.dart';
import 'package:travelsya/shared/styles/size_styles.dart';
import 'package:travelsya/shared/styles/theme_style.dart';
import 'package:travelsya/shared/widgets/form_helper.dart';
import 'package:travelsya/shared/widgets/form_helper/elevated_button_widget.dart';
import 'package:travelsya/shared/widgets/form_helper/rounded_texfield_widget.dart';
import 'package:travelsya/shared/widgets/form_helper/title_with_widget.dart';

class BusCheckoutPage extends StatelessWidget {
  const BusCheckoutPage({super.key});

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
                      color: Colors.black87,
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
                  child: Column(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: Wrap(
                          children: [
                            Text(
                              'Surabaya ke Jakarta',
                              style: mainBody3.copyWith(
                                  color: neutral100,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              width: margin8,
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: margin4, horizontal: margin24 / 2),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: neutral10),
                              child: Text(
                                'Pergi',
                                style: mainBody5.copyWith(color: neutral50),
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: margin24 / 2,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                            vertical: margin8, horizontal: margin16),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: neutral10),
                        child: Row(
                          children: [
                            SizedBox(
                                width: 16,
                                height: 16,
                                child: Image.asset('assets/icons/users.png')),
                            SizedBox(
                              width: margin8,
                            ),
                            Expanded(
                                child: Text(
                              '2 Penumpang | Ekonomi | 19 Feb 2023',
                              style: mainBody4.copyWith(color: neutral100),
                            )),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(margin16),
                  color: const Color(0xffFFF6F6),
                  child: Column(
                    children: List.generate(2, (index) {
                      return Container(
                        margin:
                            EdgeInsets.only(top: index == 0 ? 0 : margin24 / 2),
                        padding: EdgeInsets.all(margin16),
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            border:
                                Border.all(color: neutral50.withOpacity(0.3))),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                    child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'NADIRA TRANS',
                                      style: mainBody4.copyWith(
                                          color: neutral100,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      'Executives (Subclass C)',
                                      style: mainBody5.copyWith(
                                        color: neutral50,
                                      ),
                                    ),
                                  ],
                                )),
                                SizedBox(
                                  width: margin24 / 2,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      '35 kursi tersedia',
                                      style: mainBody5.copyWith(
                                          color: Colors.green),
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          'IDR 276,002',
                                          style: mainBody4.copyWith(
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          ' /pax',
                                          style: mainBody5.copyWith(
                                              color: neutral50),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(
                              height: margin24 / 2,
                            ),
                            SizedBox(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: margin8,
                                  ),
                                  IntrinsicHeight(
                                    child: Row(
                                      children: [
                                        Container(
                                          constraints: const BoxConstraints(
                                              maxWidth: 64),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                '06.00',
                                                style: mainBody3.copyWith(
                                                    color: neutral100,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Text(
                                                'Sen,  11 Feb 2023',
                                                style: mainBody4.copyWith(
                                                    color: neutral100),
                                              ),
                                              SizedBox(
                                                height: margin32,
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.symmetric(
                                              horizontal: margin8),
                                          height: double.infinity,
                                          child: Column(
                                            children: [
                                              Container(
                                                width: margin8,
                                                height: margin8,
                                                decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: Theme.of(context)
                                                        .primaryColor),
                                              ),
                                              Expanded(
                                                  child: Container(
                                                width: 1,
                                                height: double.infinity,
                                                color: Theme.of(context)
                                                    .primaryColor,
                                              ))
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                            child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Binawan University',
                                              style: mainBody4.copyWith(
                                                color: neutral100,
                                              ),
                                            ),
                                          ],
                                        ))
                                      ],
                                    ),
                                  ),
                                  IntrinsicHeight(
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          constraints: const BoxConstraints(
                                              maxWidth: 64),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                '07:45',
                                                style: mainBody3.copyWith(
                                                    color: neutral100,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Text(
                                                'Sen, 11 Feb 2023',
                                                style: mainBody4.copyWith(
                                                    color: neutral100),
                                              )
                                            ],
                                          ),
                                        ),
                                        Container(
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 10),
                                          child: Container(
                                            width: margin8,
                                            height: margin8,
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Theme.of(context)
                                                    .primaryColor),
                                          ),
                                        ),
                                        Expanded(
                                          child: Text(
                                            'Universitas Islam Nasional Cibiru',
                                            style: mainBody4.copyWith(
                                              color: neutral100,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      );
                    }),
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
                        'Detail Penampung',
                        style: mainBody3.copyWith(
                            color: neutral100, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: margin16,
                      ),
                      Row(
                        children: [
                          SizedBox(
                              width: 16,
                              height: 16,
                              child: Image.asset('assets/icons/users.png')),
                          SizedBox(
                            width: margin8,
                          ),
                          Text(
                            '0/3 Detail penumpang terisi',
                            style: mainBody5.copyWith(
                                color: Theme.of(context).primaryColor),
                          ),
                          SizedBox(
                            width: margin4,
                          ),
                          Icon(
                            Icons.info_outline,
                            color: Theme.of(context).primaryColor,
                            size: 16,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: margin16,
                      ),
                      FormHelper.borderButton(context,
                          onTap: () {}, title: 'Lengkapi Detail Penumpang')
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
                                        mainBody4.copyWith(color: neutral100),
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
                              style: mainBody4.copyWith(
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
                        style: mainBody4.copyWith(
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
