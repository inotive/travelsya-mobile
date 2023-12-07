import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:travelsya/shared/styles/font_style.dart';
import 'package:travelsya/shared/styles/theme_style.dart';
import 'package:travelsya/shared/function/show_snackbar.dart';
import 'package:travelsya/shared/widgets/form_helper.dart';

class BusCheckoutPage extends StatelessWidget {
  const BusCheckoutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            Container(
              padding: EdgeInsets.all(5.0.w),
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
                    width: 3.0.w,
                  ),
                  Text(
                    'Informasi Pemesanan',
                    style: mainFont.copyWith(
                        fontSize: 13.0.sp,
                        color: Colors.white,
                        fontWeight: FontWeight.w700),
                  )
                ],
              ),
            ),
            Expanded(
                child: ListView(
              children: [
                Container(
                  padding: EdgeInsets.all(5.0.w),
                  child: Column(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: Wrap(
                          children: [
                            Text(
                              'Surabaya ke Jakarta',
                              style: mainFont.copyWith(
                                  fontSize: 13.0.sp,
                                  color: neutral100,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              width: 2.0.w,
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 1.0.w, horizontal: 3.0.w),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: neutral10),
                              child: Text(
                                'Pergi',
                                style: mainFont.copyWith(
                                    fontSize: 8.0.sp, color: neutral30),
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 3.0.w,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                            vertical: 2.0.w, horizontal: 4.0.w),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: neutral10),
                        child: Row(
                          children: [
                            Container(
                                width: 4.0.w,
                                height: 4.0.w,
                                child: Image.asset('assets/icons/users.png')),
                            SizedBox(
                              width: 2.0.w,
                            ),
                            Expanded(
                                child: Text(
                              '2 Penumpang | Ekonomi | 19 Feb 2023',
                              style: mainFont.copyWith(
                                  fontSize: 10.0.sp, color: neutral100),
                            )),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(5.0.w),
                  color: Color(0xffFFF6F6),
                  child: Column(
                    children: List.generate(2, (index) {
                      return Container(
                        margin: EdgeInsets.only(top: index == 0 ? 0 : 3.0.w),
                        padding: EdgeInsets.all(5.0.w),
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            border:
                                Border.all(color: neutral30.withOpacity(0.3))),
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
                                      style: mainFont.copyWith(
                                          fontSize: 11.0.sp,
                                          color: neutral100,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      'Executives (Subclass C)',
                                      style: mainFont.copyWith(
                                        fontSize: 9.0.sp,
                                        color: neutral30,
                                      ),
                                    ),
                                  ],
                                )),
                                SizedBox(
                                  width: 3.0.w,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      '35 kursi tersedia',
                                      style: mainFont.copyWith(
                                          fontSize: 9.0.sp,
                                          color: Colors.green),
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          'IDR 276,002',
                                          style: mainFont.copyWith(
                                              fontSize: 12.0.sp,
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          ' /pax',
                                          style: mainFont.copyWith(
                                              fontSize: 9.0.sp,
                                              color: neutral30),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 3.0.w,
                            ),
                            Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 2.0.w,
                                  ),
                                  IntrinsicHeight(
                                    child: Row(
                                      children: [
                                        Container(
                                          constraints:
                                              BoxConstraints(maxWidth: 20.0.w),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                '06.00',
                                                style: mainFont.copyWith(
                                                    fontSize: 15.0.sp,
                                                    color: neutral100,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Text(
                                                'Sen,  11 Feb 2023',
                                                style: mainFont.copyWith(
                                                    fontSize: 10.0.sp,
                                                    color: neutral100),
                                              ),
                                              SizedBox(
                                                height: 10.0.w,
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 2.0.w),
                                          height: double.infinity,
                                          child: Column(
                                            children: [
                                              Container(
                                                width: 2.0.w,
                                                height: 2.0.w,
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
                                              style: mainFont.copyWith(
                                                fontSize: 11.0.sp,
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
                                          constraints:
                                              BoxConstraints(maxWidth: 20.0.w),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                '07:45',
                                                style: mainFont.copyWith(
                                                    fontSize: 15.0.sp,
                                                    color: neutral100,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Text(
                                                'Sen, 11 Feb 2023',
                                                style: mainFont.copyWith(
                                                    fontSize: 10.0.sp,
                                                    color: neutral100),
                                              )
                                            ],
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 2.5.w),
                                          child: Container(
                                            width: 2.0.w,
                                            height: 2.0.w,
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Theme.of(context)
                                                    .primaryColor),
                                          ),
                                        ),
                                        Expanded(
                                          child: Text(
                                            'Universitas Islam Nasional Cibiru',
                                            style: mainFont.copyWith(
                                              fontSize: 11.0.sp,
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
                  padding: EdgeInsets.all(5.0.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Detail Pemesan',
                        style: mainFont.copyWith(
                            fontSize: 13.0.sp,
                            color: neutral100,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 5.0.w,
                      ),
                      FormHelper.optionsCircle(context,
                          title: 'Sama dengan pemilik akun',
                          onTap: () {},
                          status: true),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 3.0.w),
                        width: double.infinity,
                        height: 1,
                        color: neutral30.withOpacity(0.3),
                      ),
                      Row(
                        children: [
                          FormHelper.optionsCircle(context,
                              title: 'Tuan', onTap: () {}, status: false),
                          SizedBox(
                            width: 3.0.w,
                          ),
                          FormHelper.optionsCircle(context,
                              title: 'Nyonya', onTap: () {}, status: false),
                        ],
                      ),
                      SizedBox(
                        height: 5.0.w,
                      ),
                      FormHelper.titleWithWidget(
                          title: 'Nama Lengkap',
                          widget: FormHelper.roundedTextfield(context,
                              hintText: 'Masukkan nama lengkap Anda',
                              controller: TextEditingController())),
                      SizedBox(
                        height: 1.0.w,
                      ),
                      Text(
                        'Seperti di KTP/SIM/Paspor.',
                        style: mainFont.copyWith(
                            fontSize: 8.0.sp, color: neutral30),
                      ),
                      SizedBox(
                        height: 5.0.w,
                      ),
                      FormHelper.titleWithWidget(
                          title: 'Nomor Handphone',
                          widget: FormHelper.roundedTextfield(context,
                              prefixIcon: Center(
                                widthFactor: 1,
                                child: Text(
                                  '+62',
                                  style: mainFont.copyWith(
                                      fontSize: 11.0.sp, color: Colors.black87),
                                ),
                              ),
                              controller: TextEditingController())),
                      SizedBox(
                        height: 5.0.w,
                      ),
                      FormHelper.titleWithWidget(
                          title: 'Email',
                          widget: FormHelper.roundedTextfield(context,
                              hintText: 'Masukkan email Anda',
                              controller: TextEditingController())),
                    ],
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: 2.0.w,
                  color: neutral10,
                ),
                Container(
                  padding: EdgeInsets.all(5.0.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Detail Penampung',
                        style: mainFont.copyWith(
                            fontSize: 13.0.sp,
                            color: neutral100,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 5.0.w,
                      ),
                      Row(
                        children: [
                          Container(
                              width: 6.0.w,
                              height: 6.0.w,
                              child: Image.asset('assets/icons/users.png')),
                          SizedBox(
                            width: 2.0.w,
                          ),
                          Text(
                            '0/3 Detail penumpang terisi',
                            style: mainFont.copyWith(
                                fontSize: 9.0.sp,
                                color: Theme.of(context).primaryColor),
                          ),
                          SizedBox(
                            width: 1.0.w,
                          ),
                          Icon(
                            Icons.info_outline,
                            color: Theme.of(context).primaryColor,
                            size: 4.0.w,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5.0.w,
                      ),
                      FormHelper.borderButton(context,
                          onTap: () {}, title: 'Lengkapi Detail Penumpang')
                    ],
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: 2.0.w,
                  color: neutral10,
                ),
                Container(
                  padding: EdgeInsets.all(5.0.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Metode Pembayaran',
                        style: mainFont.copyWith(
                            fontSize: 13.0.sp,
                            color: neutral100,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 5.0.w,
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
                                    style: mainFont.copyWith(
                                        fontSize: 10.0.sp, color: neutral100),
                                  ))),
                          SizedBox(
                            width: 3.0.w,
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 2.0.w, horizontal: 3.0.w),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Color(0xffffeef1)),
                            child: Text(
                              'Topup',
                              style: mainFont.copyWith(
                                  fontSize: 10.0.sp,
                                  color: Theme.of(context).primaryColor,
                                  fontWeight: FontWeight.bold),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 3.0.w,
                      ),
                      FormHelper.optionsCircle(context,
                          title: 'Metode Pembayaran Lain',
                          onTap: () {},
                          status: false)
                    ],
                  ),
                ),
                SizedBox(
                  height: 10.0.w,
                )
              ],
            )),
            Container(
              padding: EdgeInsets.all(5.0.w),
              decoration: BoxDecoration(
                  border: Border(
                      top: BorderSide(color: neutral30.withOpacity(0.3)))),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total Biaya',
                        style: mainFont.copyWith(
                            fontSize: 10.0.sp, color: neutral100),
                      ),
                      Text(
                        'IDR 1,561,000',
                        style: mainFont.copyWith(
                            fontSize: 12.0.sp,
                            color: neutral100,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 3.0.w,
                  ),
                  FormHelper.elevatedButtonBasic(context,
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
