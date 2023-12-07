import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:travelsya/shared/styles/font_style.dart';
import 'package:travelsya/shared/styles/theme_style.dart';
import 'package:travelsya/shared/function/show_snackbar.dart';
import 'package:travelsya/shared/widgets/form_helper.dart';

class RentalCheckoutPage extends StatelessWidget {
  const RentalCheckoutPage({Key? key}) : super(key: key);

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
                    child: Icon(
                      Icons.arrow_back,
                      color: Colors.white,
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
                                      color: neutral30.withOpacity(0.3)),
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white),
                              alignment: Alignment.topRight,
                              child: SizedBox(
                                width: 20.0.w,
                                height: 20.0.w,
                                child: Image.asset(
                                  'assets/icons/Group 23.png',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(5.0.w),
                            width: double.infinity,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Detail Mobil dan Vendor',
                                  style: mainFont.copyWith(
                                      fontSize: 10.0.sp,
                                      color: neutral100,
                                      fontWeight: FontWeight.bold),
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        RichText(
                                            text: TextSpan(children: [
                                          TextSpan(
                                              text: 'SIGMA RENT CAR',
                                              style: mainFont.copyWith(
                                                  fontSize: 10.0.sp,
                                                  color: neutral100,
                                                  fontWeight: FontWeight.bold)),
                                          TextSpan(
                                              text: ' - Lepas Kunci',
                                              style: mainFont.copyWith(
                                                  fontSize: 10.0.sp,
                                                  color: neutral30,
                                                  fontStyle: FontStyle.italic))
                                        ])),
                                        Text(
                                          'Toyota Grand New Avanza',
                                          style: mainFont.copyWith(
                                              fontSize: 10.0.sp,
                                              color: neutral100),
                                        ),
                                        SizedBox(
                                          height: 2.0.w,
                                        ),
                                        Row(
                                          children: [
                                            Container(
                                                width: 5.0.w,
                                                height: 5.0.w,
                                                child: Image.asset(
                                                    'assets/icons/users.png')),
                                            SizedBox(
                                              width: 1.0.w,
                                            ),
                                            Text(
                                              '6 Orang',
                                              style: mainFont.copyWith(
                                                  fontSize: 10.0.sp,
                                                  color: neutral30),
                                            ),
                                            SizedBox(
                                              width: 3.0.w,
                                            ),
                                            Container(
                                                width: 5.0.w,
                                                height: 5.0.w,
                                                child: Image.asset(
                                                    'assets/icons/users.png')),
                                            SizedBox(
                                              width: 1.0.w,
                                            ),
                                            Text(
                                              'Otomatis',
                                              style: mainFont.copyWith(
                                                  fontSize: 10.0.sp,
                                                  color: neutral30),
                                            )
                                          ],
                                        ),
                                        SizedBox(
                                          height: 3.0.w,
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              'IDR 218,999',
                                              style: mainFont.copyWith(
                                                  fontSize: 12.0.sp,
                                                  color: Theme.of(context)
                                                      .primaryColor,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text(
                                              ' /hari',
                                              style: mainFont.copyWith(
                                                  fontSize: 9.0.sp,
                                                  color: neutral30),
                                            )
                                          ],
                                        )
                                      ],
                                    )),
                                    SizedBox(
                                      width: 3.0.w,
                                    ),
                                    Container(
                                        width: 20.0.w,
                                        height: 20.0.w,
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
                        height: 5.0.w,
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
                                      color: neutral30.withOpacity(0.3)),
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white),
                              alignment: Alignment.topRight,
                              child: SizedBox(
                                width: 20.0.w,
                                height: 20.0.w,
                                child: Image.asset(
                                  'assets/icons/Group 23.png',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(5.0.w),
                            width: double.infinity,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Waktu Sewa',
                                  style: mainFont.copyWith(
                                      fontSize: 10.0.sp,
                                      color: neutral100,
                                      fontWeight: FontWeight.bold),
                                ),
                                Container(
                                  margin: EdgeInsets.symmetric(vertical: 3.0.w),
                                  width: double.infinity,
                                  height: 1,
                                  color: neutral30.withOpacity(0.3),
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
                                            style: mainFont.copyWith(
                                                fontSize: 8.0.sp,
                                                color: neutral30),
                                          ),
                                          Text(
                                            'Minggu, 20 Feb 2023',
                                            style: mainFont.copyWith(
                                                fontSize: 11.0.sp,
                                                color: neutral100,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            '06:00 AM',
                                            style: mainFont.copyWith(
                                                fontSize: 11.0.sp,
                                                color: neutral100),
                                          )
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: 5.0.w,
                                    ),
                                    Flexible(
                                      flex: 1,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Tanggal Jemput',
                                            style: mainFont.copyWith(
                                                fontSize: 8.0.sp,
                                                color: neutral30),
                                          ),
                                          Text(
                                            'Minggu, 20 Feb 2023',
                                            style: mainFont.copyWith(
                                                fontSize: 11.0.sp,
                                                color: neutral100,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            '06:00 AM',
                                            style: mainFont.copyWith(
                                                fontSize: 11.0.sp,
                                                color: neutral100),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
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
                                        child: Text(
                                      'Bisa refund, reschedule dan overtime',
                                      style: mainFont.copyWith(
                                          fontSize: 10.0.sp,
                                          fontWeight: FontWeight.bold,
                                          color:
                                              Theme.of(context).primaryColor),
                                    )),
                                    SizedBox(
                                      width: 3.0.w,
                                    ),
                                    Icon(
                                      Icons.arrow_forward_ios_rounded,
                                      color: neutral100,
                                      size: 4.0.w,
                                    )
                                  ],
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 5.0.w,
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
                                      color: neutral30.withOpacity(0.3)),
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white),
                              alignment: Alignment.topRight,
                              child: SizedBox(
                                width: 20.0.w,
                                height: 20.0.w,
                                child: Image.asset(
                                  'assets/icons/Group 23.png',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(5.0.w),
                            width: double.infinity,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Area Sewa',
                                  style: mainFont.copyWith(
                                      fontSize: 10.0.sp,
                                      color: neutral100,
                                      fontWeight: FontWeight.bold),
                                ),
                                Container(
                                  margin: EdgeInsets.symmetric(vertical: 3.0.w),
                                  width: double.infinity,
                                  height: 1,
                                  color: neutral30.withOpacity(0.3),
                                ),
                                Text(
                                  'Jakarta',
                                  style: mainFont.copyWith(
                                      fontSize: 12.0.sp,
                                      color: neutral100,
                                      fontWeight: FontWeight.bold),
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
                                        child: Text(
                                      'Lihat Cakupan Area',
                                      style: mainFont.copyWith(
                                          fontSize: 10.0.sp,
                                          fontWeight: FontWeight.bold,
                                          color:
                                              Theme.of(context).primaryColor),
                                    )),
                                    SizedBox(
                                      width: 3.0.w,
                                    ),
                                    Icon(
                                      Icons.arrow_forward_ios_rounded,
                                      color: neutral100,
                                      size: 4.0.w,
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
